//
//  HomeViewController.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/14.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    
    @AppStorage("runCount") private var runTime = 0
    var soundBrain: SoundBrain = SoundBrain()
    var backgroundMuiscBool: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        runTime += 1
    }
    @IBAction func backgroundMusic(_ sender: UIButton) {
        if !backgroundMuiscBool {
            soundBrain.backgroundSound()
            backgroundMuiscBool.toggle()
            sender.setImage(UIImage(systemName: "pause.circle.fill"), for: UIControl.State.normal)
        } else {
            soundBrain.pauseSound(name: "background")
            sender.setImage(UIImage(systemName: "music.note"), for: UIControl.State.normal)
            backgroundMuiscBool.toggle()
        }
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        if runTime < 100 {
                let storyboard = UIStoryboard(name: "Prologaue", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "PrologaueViewController") as! PrologaueViewController
                navigationController?.pushViewController(viewController, animated: true)
                navigationController?.isNavigationBarHidden = true
            } else {
                let storyboard = UIStoryboard(name: "Stage", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier: "StageViewController") as! StageViewController
                navigationController?.pushViewController(viewController, animated: true)
            }
    }
}
