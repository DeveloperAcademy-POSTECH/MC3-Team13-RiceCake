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
    @IBOutlet weak var childLeftHand: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func randomY () -> CGFloat {
        let randCoordsY = CGFloat.random(in: 0...view.bounds.height/4)
        return randCoordsY
    }
    
    func childHandUpAndDown() {
        UIView.animate(withDuration: 0.7, delay: 0, options: [.repeat, .autoreverse], animations: {
            self.childLeftHand.center.y = self.randomY()
        }, completion: nil)
    }
}
