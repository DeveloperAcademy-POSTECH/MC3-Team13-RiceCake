//
//  BusPoleMissionViewController.swift
//  RiceCake
//
//  Created by Eunbi Han on 2022/07/18.
//

import UIKit

class BusPoleMissionViewController: UIViewController, UIGestureRecognizerDelegate {
    @IBOutlet weak var busPoleBackground: UIImageView!
    @IBOutlet weak var firstBusHandle: UIImageView!
    @IBOutlet weak var frontBusPole: UIImageView!
    @IBOutlet weak var childLeftHand: UIImageView!
    @IBOutlet weak var secondBusHandle: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let busHandleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        busHandleTapGesture.delegate = self
        
        self.firstBusHandle.addGestureRecognizer(busHandleTapGesture)
        self.secondBusHandle.addGestureRecognizer(busHandleTapGesture)
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        handleTouched()
//        viewMoved(true)
        print("")
        self.firstBusHandle.endEditing(true)
        self.secondBusHandle.endEditing(true)
        
        return true
    }
    
//    func handleTouched() {
//        var frame = childLeftHand.frame
//        frame.origin = CGPoint(x: 120, y: 456)
//
//        UIView.animate(withDuration: 1.0, animations: {
//            self.childLeftHand.frame = frame
//        }, completion: { finished in
//            UIView.animate(withDuration: 1.0) {
//                self.reset()
//            }
//        })
//    }
    
//    func reset() {
//        childLeftHand.frame = CGRect(x: 120, y: 700, width: 196, height: 588)
//    }
    
//    func viewMoved(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        UIView.animate(withDuration: 1.0, delay: 1.5, options: [.curveEaseOut], animations: {
//            self.busPoleBackground.center.x -= self.view.bounds.width
//        }, completion: nil)
//
//        UIView.animate(withDuration: 1.0, delay: 1.5, options: [.curveEaseOut], animations: {
//            self.firstBusHandle.center.x -= self.view.bounds.width
//        }, completion: nil)
//
//        UIView.animate(withDuration: 1.0, delay: 1.5, options: [.curveEaseOut], animations: {
//            self.secondBusHandle.center.x -= self.view.bounds.width
//        }, completion: nil)
//
//    }
}
