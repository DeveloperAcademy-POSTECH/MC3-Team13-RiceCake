//
//  HomeViewController.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/14.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Stage", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "StageViewController") as! StageViewController
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
