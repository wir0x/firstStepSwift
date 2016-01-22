//
//  RecordSoundsViewController.swift
//  PichPerfectUdacity
//
//  Created by Gonzalo Salazar Velasquez on 1/16/16.
//  Copyright © 2016 Gonzalo Salazar Velasquez. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate {
    
    // MARK: properties
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!

    // Declare globally
    var audioRecord: AVAudioRecorder!
    var recordedAudio: RecordedAudio!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        recordButton.enabled = true
    }
    
    // MARK: Actions
 
    @IBAction func recordAudio(sender: UIButton) {
        
        stopButton.hidden = false
        recordingLabel.hidden = false
        recordButton.enabled = false
    
        // directory when audio save audio recorder.
        let DIR_PATH = NSSearchPathForDirectoriesInDomains(.DocumentationDirectory, .UserDomainMask, true)[0] as String
        print("DIR_PATH: \(DIR_PATH)")
        
        // Configuring the way audio name.
//        let currentDate = NSDate()
//        let formatter = NSDateFormatter()
//        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let RECORDING_NAME = "my_audio.wav"
        print("RECORDING_NAME: \(RECORDING_NAME)")
        
        // Path array, directory path and recording audio name.
        let PATH_ARRAY = [DIR_PATH, RECORDING_NAME]
        let FILE_PATH = NSURL.fileURLWithPathComponents(PATH_ARRAY)
        print("PATH_ARRAY: \(PATH_ARRAY)")
        print("FILE_PATH: \(FILE_PATH)")
        
        // Setup audio session.
        let SESSION = AVAudioSession.sharedInstance()
        try! SESSION.setCategory(AVAudioSessionCategoryRecord)
        try! audioRecord = AVAudioRecorder(URL: FILE_PATH!, settings: [:])
        
        
        // Initialize and prepare the recorder.
        audioRecord.meteringEnabled = true
        audioRecord.delegate = self
        audioRecord.prepareToRecord()
        audioRecord.record()

    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {

        if flag {
            recordedAudio = RecordedAudio()
            recordedAudio.filePathUrl = recorder.url
            recordedAudio.title = recorder.url.lastPathComponent
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
        } else {
            print("Recording was not successful")
            recordButton.enabled = true
            stopButton.hidden = true
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "stopRecording" {
            let PLAY_SOUNDSVC: PlaySoundsViewController = segue.destinationViewController as! PlaySoundsViewController
            let DATA = sender as! RecordedAudio
            PLAY_SOUNDSVC.receiveAudio = DATA
        }
    }
    
    @IBAction func stopAudio(sender: UIButton) {
        recordingLabel.hidden = true
        audioRecord.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
}

