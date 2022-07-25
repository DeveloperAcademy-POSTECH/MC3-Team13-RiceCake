//
//  MilkShakeViewController.swift
//  RiceCake
//
//  Created by David_ADA on 2022/07/25.
//
import UIKit
import Foundation

class MilkShakeMissionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func tappedStraw(_ sender: UITapGestureRecognizer) {
        print("Tapped")
    }
    
    @objc func longPressedStarw(_ sender: UITapGestureRecognizer) {
        print("LongPressed")
    }
}
