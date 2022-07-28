//
//  HintViewController.swift
//  RiceCake
//
//  Created by Eunbi Han on 2022/07/27.
//

import UIKit

class HintViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    
    var labelTagNumber: Int = 1
    var isHintEnd = false
    let jsonScript: [StageHint] = loadJson("HintScript.json")
    let testMissionNumber: Int = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 불러온 Json 파일에서 정보 가져와 말풍선 생성
        for script in jsonScript[0].missionHints[testMissionNumber].content {
            let isFirst: Bool = script.id == 1
            let isLeft: Bool = script.isLeft ?? false
            let topConstraintView: UIView = (isFirst ? mainView : view.viewWithTag(script.id-1)) ?? mainView
            
            let label = createPaddingLabel(text: script.text, viewTag: script.id, isLeft: isLeft)
            setLabelConstraints(targetLabel: label, topConstraintView: topConstraintView, isFirst: isFirst, isLeft: isLeft)
        }
        
        // Tab Gesture Recongnizer 생성
        let viewTapped: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(appearLabel(_:)))
        view.addGestureRecognizer(viewTapped)

    }
    
    // Padding이 적용된 UILabel 생성
    private func createPaddingLabel(text: String, viewTag: Int = 0, isLeft: Bool = false) -> UILabel {
        let label = PaddingLabel()
        label.padding(10, 10, 10, 10)
        label.tag = viewTag
        label.text = text
        label.textColor = isLeft ? .black : .white
        label.backgroundColor = isLeft ? .white : .black
        label.layer.borderWidth = 1
        label.layer.borderColor = isLeft ? UIColor.black.cgColor : UIColor.white.cgColor
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 20
        label.isHidden = viewTag == 1 ? false : true
        self.mainView.addSubview(label)
        
        return label
    }
    
    // 말풍선에 AutoLayout 적용
    private func setLabelConstraints(targetLabel: UIView, topConstraintView: UIView, isFirst: Bool = false, isLeft: Bool = false) {
        targetLabel.translatesAutoresizingMaskIntoConstraints = false
        targetLabel.topAnchor.constraint(equalTo: isFirst ? mainView.topAnchor : topConstraintView.bottomAnchor, constant: 10).isActive = true
        targetLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10).isActive = isLeft
        targetLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10).isActive = !isLeft
    }
    
    // TapGesture 인식하면 말풍선이 순서대로 화면에 나옴
    @objc func appearLabel(_ sender: UITapGestureRecognizer) {
        if labelTagNumber == jsonScript[0].missionHints[testMissionNumber].content.count {
            isHintEnd = true
            // TODO: 다른 view에 isHintEnd 전달
        }
        labelTagNumber += 1
        self.view.viewWithTag(labelTagNumber)?.isHidden = false
    }

}

// Padding 값 적용이 가능한 UILabel class
// https://gist.github.com/konnnn/d43af3bd525bb4c58f5c29fb14575b0d#file-uilabel-padding-swift-L66
class PaddingLabel: UILabel {
    
    var insets = UIEdgeInsets.zero
    
    func padding(_ top: CGFloat, _ bottom: CGFloat, _ left: CGFloat, _ right: CGFloat) {
        self.frame = CGRect(x: 0, y: 0, width: self.frame.width + left + right, height: self.frame.height + top + bottom)
        insets = UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += insets.top + insets.bottom
        contentSize.width += insets.left + insets.right
        
        return contentSize
    }
    
}
