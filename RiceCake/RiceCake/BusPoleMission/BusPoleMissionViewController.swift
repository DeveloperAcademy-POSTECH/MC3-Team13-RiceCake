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
        
        let busHandle2TapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
        busHandle2TapGesture.delegate = self
        
//        let busPoleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
//        busPoleTapGesture.delegate = self
        
        self.firstBusHandle.addGestureRecognizer(busHandleTapGesture)
        self.secondBusHandle.addGestureRecognizer(busHandle2TapGesture)
//        self.frontBusPole.addGestureRecognizer(busPoleTapGesture)
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        handleTouched()
        viewMoved(true)
        self.firstBusHandle.endEditing(true)
        self.secondBusHandle.endEditing(true)
        
        return true
    }
    
    func handleTouched() {
        UIView.animate(withDuration: 0.7, animations: {
            self.childLeftHand.center.y -= self.view.bounds.height/4
        }, completion: nil)
        UIView.animate(withDuration: 0.7, delay: 0.7, animations: {
            self.childLeftHand.center.y += self.view.bounds.height/4
        }, completion: nil)
    }
    
    func viewMoved(_ animated: Bool) {
        super.viewDidAppear(animated)

        UIView.animate(withDuration: 1.0, delay: 1.5, options: [.curveEaseOut], animations: {
            self.busPoleBackground.center.x -= self.view.bounds.width
        }, completion: nil)

        UIView.animate(withDuration: 1.0, delay: 1.5, options: [.curveEaseOut], animations: {
            self.firstBusHandle.center.x -= self.view.bounds.width
        }, completion: nil)

        UIView.animate(withDuration: 1.0, delay: 1.5, options: [.curveEaseOut], animations: {
            self.secondBusHandle.center.x -= self.view.bounds.width
        }, completion: nil)
        
        UIView.animate(withDuration: 1.0, delay: 1.5, options: [.curveEaseOut], animations: {
            self.frontBusPole.center.x -= self.view.bounds.width
        }, completion: nil)

    }
}
