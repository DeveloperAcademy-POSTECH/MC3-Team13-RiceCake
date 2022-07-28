//
//  NoKidsZoneMissionViewController.swift
//  RiceCake
//
//  Created by Eunbi Han on 2022/07/28.
//

import UIKit

class NoKidsZoneMissionViewController: UIViewController {

    @IBOutlet weak var pannel: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSwipeGesture(targetView: pannel, isLeft: true)
        createSwipeGesture(targetView: pannel, isLeft: false)
    }
    
    private func createSwipeGesture(targetView: UIView, isLeft: Bool) {
        let swipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipePannel(_:)))
        swipe.direction = isLeft ? .left : .right
        targetView.addGestureRecognizer(swipe)
    }
    
    @objc func swipePannel(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left || sender.direction == .right {
            pannel.image = UIImage(named: "pannelFront.png")
        }
    }

}
