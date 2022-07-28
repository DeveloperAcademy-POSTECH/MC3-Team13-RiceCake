//
//  BusBellMissionViewController.swift
//  RiceCake
//
//  Created by 조은비 on 2022/07/26.
//

import UIKit

class BusBellMissionViewController: UIViewController {
    
    @IBOutlet weak var busBellMissionBackground: UIImageView!
    @IBOutlet weak var busBell: UIImageView!
    @IBOutlet weak var tapRecognizer: UIImageView!
    @IBOutlet weak var childLeftHand: UIImageView!
    @IBOutlet weak var pushedButton: UIImageView!
    
    // 3가지 손 위치
    let childLeftHandPisitions: [CGFloat] = [1, 1.1, 1.3]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let busBellTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedBell(_:)))
        tapRecognizer.addGestureRecognizer(busBellTapGesture)
        
        self.pushedButton.isHidden = true
        self.tapRecognizer.isHidden = true
        childHandUpDown()
    }
    
    @objc func tappedBell(_ sender: UITapGestureRecognizer) {
        self.pushedButton.isHidden = false
        print("what")
    }
    
    func childHandUpDown() {
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseInOut, .autoreverse], animations: { [weak self] in
            guard let self = self else { return }
            self.childLeftHand.center.y -= self.view.bounds.height * self.childLeftHandPisitions.randomElement()!
            if self.childLeftHand.center.y ==  self.view.bounds.height / 0.5 - self.view.bounds.height * 1.3 {
                self.tapRecognizer.isHidden = false
                print("ok")
            }
        }, completion: {_ in
            self.setupChildHand()
            self.childHandUpDown()
        })
    }
    
    // 손 위치 초기 설정
    func setupChildHand() {
        self.childLeftHand.center.y = self.view.bounds.height / 0.5
        self.pushedButton.isHidden = true
        self.tapRecognizer.isHidden = true
    }
    
}
