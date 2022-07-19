//
//  BusPoleMissionViewController.swift
//  RiceCake
//
//  Created by Eunbi Han on 2022/07/18.
//

import UIKit

class BusPoleMissionViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet var tap: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tap = UITapGestureRecognizer(target: self, action: #selector(BusPoleMissionViewController.printHeart(_:)))
        image.addGestureRecognizer(tap)
        
    }
    
    // test function
    @objc func printHeart(_ tap: UITapGestureRecognizer) {
        if tap.state == .ended {
            print("done")
        }
    }
    

}
