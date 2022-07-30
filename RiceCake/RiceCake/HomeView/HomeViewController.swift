//
//  HomeViewController.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/14.
//

import UIKit

class HomeViewController: UIViewController {
    
    var soundBrain: SoundBrain = SoundBrain()
    var backgroundMuiscBool: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

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
        let storyboard = UIStoryboard(name: "Stage", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "StageViewController") as! StageViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
}
