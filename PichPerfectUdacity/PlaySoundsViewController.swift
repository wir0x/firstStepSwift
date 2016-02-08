//
//  PlaySoundViewController.swift
//  PichPerfectUdacity
//
//  Created by Gonzalo Salazar Velasquez on 1/17/16.
//  Copyright © 2016 Gonzalo Salazar Velasquez. All rights reserved.
//

import UIKit
import AVFoundation



class PlaySoundsViewController: UIViewController {
    
    var audioPlayer: AVAudioPlayer!
    var audioEngine: AVAudioEngine!
    var receiveAudio: RecordedAudio!
    var audioFile: AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        audioEngine = AVAudioEngine()
        audioFile = try! AVAudioFile(forReading: receiveAudio.filePathUrl)
        setupAudioPlayer()
        //audioEngine = AVAudioEngine()
    }
    
    @IBAction func playSlowAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    @IBAction func playSpeedAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.rate = 1.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0.0
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        playAudioWithVariablePitch(1000)
        
    }
    
    @IBAction func playDarthvaderAudio(sender:UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        playAudioWithVariablePitch(-1000)
    }
    
    func setupAudioPlayer() {
        do {
            let sound = try AVAudioPlayer(contentsOfURL: receiveAudio.filePathUrl)
            audioPlayer = sound
            audioPlayer.enableRate = true
            
        } catch {
            print("sound not available")
            
        }
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        
        audioEngine.attachNode(changePitchEffect)
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        audioPlayerNode.play()
        
    }
         
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
