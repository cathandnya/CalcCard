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
    @Published var result: SFSpeechRecognitionResult?

    override init() {
        super.init()
        speechRecognizer.delegate = self
    }
    
    func prepare(handler: @escaping (Bool) -> Void) {
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
        // 録音用のカテゴリをセット
        try audioSession.setCategory(AVAudioSession.Category.record)
        try audioSession.setMode(AVAudioSession.Mode.measurement)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode = audioEngine.inputNode
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to created a SFSpeechAudioBufferRecognitionRequest object") }
        
        // 録音が完了する前のリクエストを作るかどうかのフラグ。
        // trueだと現在-1回目のリクエスト結果が返ってくる模様。falseだとボタンをオフにしたときに音声認識の結果が返ってくる設定。
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { [weak self] result, error in
            guard let `self` = self else { return }
            
            var isFinal = false
            
            self.result = result
            if let result = result {
                isFinal = result.isFinal
            }
            
            // エラーがある、もしくは最後の認識結果だった場合の処理
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
            }
        }
        
        // マイクから取得した音声バッファをリクエストに渡す
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        try startAudioEngine()
    }

    private func refreshTask() {
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
    }

    private func startAudioEngine() throws {
        // startの前にリソースを確保しておく。
        audioEngine.prepare()
        
        try audioEngine.start()
    }
    
    var isRunning: Bool {
        audioEngine.isRunning
    }
    
    func start() {
        guard !isRunning else {
            return
        }
        
        try! startRecording()
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
