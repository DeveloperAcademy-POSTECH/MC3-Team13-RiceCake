//
//  PrologaueViewController.swift
//  RiceCake
//
//  Created by David_ADA on 2022/07/27.
//

import Foundation
import UIKit
import SwiftUI
class PrologaueViewController: UIViewController {
    
    @IBOutlet weak var firstLabel: UILabel!
    
    @IBOutlet weak var secondLabel: UILabel!
    
    @IBOutlet weak var thirdLabel: UILabel!
    
    @IBOutlet weak var fourthLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstLabel.font = UIFont(name: "EF_Diary", size: 14)
        secondLabel.font = UIFont(name: "EF_Diary", size: 14)
        thirdLabel.font = UIFont(name: "EF_Diary", size: 14)
        fourthLabel.font = UIFont(name: "EF_Diary", size: 14)
    }
    @IBAction func nextButton(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Stage", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "StageViewController") as! StageViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
}
