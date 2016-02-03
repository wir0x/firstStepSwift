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
    var receiveAudio: RecordedAudio!
    var audioEngine: AVAudioEngine!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup audio player.
        setupAudioPlayer()
        audioEngine = AVAudioEngine()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        let changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = 1000
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.play()
        
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
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
