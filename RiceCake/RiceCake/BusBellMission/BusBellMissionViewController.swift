//
//  BusBellMissionViewController.swift
//  RiceCake
//
//  Created by 조은비 on 2022/07/26.
//

import UIKit

class BusBellMissionViewController: UIViewController, UICollisionBehaviorDelegate {
    private var dynamicAnimator: UIDynamicAnimator?
    
    @IBOutlet weak var busBellMissionBackground: UIImageView!
    @IBOutlet weak var busBell: UIImageView!
    @IBOutlet weak var childLeftHand: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        childHandUpAndDown()
        let collisionBehavior = UICollisionBehavior(items: [busBell, childLeftHand])
        collisionBehavior.collisionDelegate = self
        collisionBehavior.setTranslatesReferenceBoundsIntoBoundary(with: .zero)
        collisionBehavior.collisionMode = .everything
        self.dynamicAnimator?.addBehavior(collisionBehavior)
    }
    
    // 손 위치 반복될 때마다 초기 설정
    func setupChildHand() {
        self.childLeftHand.center.y = self.view.bounds.height * 1.4
    }
    
    // 손이 올라가는 위치 랜덤 값으로 형성
    func randomY() -> CGFloat {
        let randomCordsY = CGFloat.random(in: view.bounds.height/2...view.bounds.height/1.5)
        return randomCordsY
    }
    
    // 손이 랜덤한 높이로 올라갔다 내려오는 함수
    func childHandUpAndDown() {
        UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseInOut, .autoreverse], animations: { [weak self] in
            guard let self = self else { return }
            self.childLeftHand.center.y -= self.randomY()
        }, completion: { (done) in
            self.setupChildHand()
            self.childHandUpAndDown()
        })
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior,
                           beganContactFor item: UIDynamicItem,
                           withBoundaryIdentifier identifier: NSCopying?,
                           at position: CGPoint) {
      print("began contact boundary")
    }
    
}
