//
//  VoiceRecognizer.swift
//  Calc
//
//  Created by nya on 2020/09/12.
//  Copyright © 2020 CatHand.org. All rights reserved.
//

import Foundation
import Speech

class VoiceRecognizer: NSObject, ObservableObject {
        
    let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ja-JP"))!
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private var handler: ((Int?) -> Void)?

    override init() {
        super.init()
        speechRecognizer.delegate = self
    }
    
    static func prepare(handler: @escaping (Bool) -> Void) {
        SFSpeechRecognizer.requestAuthorization { (status) in
            switch status {
            case .restricted, .denied:
                handler(false)
            case .notDetermined, .authorized:
                handler(true)
            @unknown default:
                handler(false)
            }
        }
    }
    
    private func startRecording() throws {
        refreshTask()
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSession.Category.record)
        try audioSession.setMode(AVAudioSession.Mode.measurement)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to created a SFSpeechAudioBufferRecognitionRequest object") }
        
        recognitionRequest.shouldReportPartialResults = true
        
        var timer: Timer?
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { [weak self] result, error in
            guard let me = self else { return }
                     
            if let resultValue = me.parse(result: result) {
                timer?.invalidate()
                if error != nil || (result?.isFinal ?? false) {
                    me.finish(result: resultValue)
                } else {
                    timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
                        self?.finish(result: resultValue)
                    })
                }
            } else if error != nil || (result?.isFinal ?? false) {
                me.finish(result: nil)
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        try startAudioEngine()
    }
    
    private func finish(result: Int?) {
        let inputNode = audioEngine.inputNode
        audioEngine.stop()
        inputNode.removeTap(onBus: 0)
        
        recognitionRequest = nil
        recognitionTask = nil
        
        handler?(result)
    }
    
    private func parse(result: SFSpeechRecognitionResult?) -> Int? {
        guard let result = result else {
            return nil
        }
        
        return Int(result.bestTranscription.formattedString)
    }

    private func refreshTask() {
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
    }

    private func startAudioEngine() throws {
        audioEngine.prepare()
        
        try audioEngine.start()
    }
    
    var isRunning: Bool {
        audioEngine.isRunning
    }
    
    func start(handler: @escaping (Int?) -> Void) throws {
        guard !isRunning else {
            return
        }
        
        self.handler = handler
        try startRecording()
    }

    func stop() {
        guard isRunning else {
            return
        }

        audioEngine.stop()
        recognitionRequest?.endAudio()
    }
}

extension VoiceRecognizer: SFSpeechRecognizerDelegate {
 
}
