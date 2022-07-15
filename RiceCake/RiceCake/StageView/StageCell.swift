//
//  StageCell.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/14.
//

import UIKit

class StageCell: UICollectionViewCell {
    
    @IBOutlet weak var stageImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 16
    }
    
    func configure(_ stage: Stage) {
        stageImageView.image = UIImage(named: stage.imageName)
    }
}
