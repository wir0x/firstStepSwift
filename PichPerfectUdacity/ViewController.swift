//
//  ViewController.swift
//  PichPerfectUdacity
//
//  Created by Gonzalo Salazar Velasquez on 1/16/16.
//  Copyright © 2016 Gonzalo Salazar Velasquez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var recordingInProgress: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordgButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReceiveMemoryWarning")
    }
    
    override func viewWillAppear(animated: Bool) {
        stopButton.hidden = true
        print("viewWillAppear")
    }
    
    @IBAction func recordAudio(sender: UIButton) {
        // TODO: Record the user's voice
        recordingInProgress.hidden = false
        stopButton.hidden = false
        sender.hidden = true
    }

    @IBAction func stopRecording(sender: UIButton) {
        recordingInProgress.hidden = true
        recordButton.hidden = false
        sender.hidden = true
    }
}

