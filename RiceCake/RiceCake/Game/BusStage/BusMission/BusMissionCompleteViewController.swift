//
//  BusMissionCompleteViewController.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/30.
//

import UIKit

class BusMissionCompleteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func nextStageButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Stage", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "StageViewController") as! StageViewController
        
        navigationController?.popViewController(animated: true)
        viewController.index = 1
    }
}
