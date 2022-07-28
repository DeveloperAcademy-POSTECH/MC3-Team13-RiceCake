//
//  NoKidsZoneMissionViewController.swift
//  RiceCake
//
//  Created by Eunbi Han on 2022/07/28.
//

import UIKit

class NoKidsZoneMissionViewController: UIViewController {

    @IBOutlet weak var panel: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSwipeGesture(targetView: panel, isLeft: true)
        createSwipeGesture(targetView: panel, isLeft: false)
    }
    
    private func createSwipeGesture(targetView: UIView, isLeft: Bool) {
        let swipe: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipePanel(_:)))
        swipe.direction = isLeft ? .left : .right
        targetView.addGestureRecognizer(swipe)
    }
    
    // swipe 제스처 인식 시 판넬 이미지 변경
    @objc func swipePanel(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left || sender.direction == .right {
            panel.image = UIImage(named: "panelFront.png")
        }
    }

}
