//
//  HintViewController.swift
//  RiceCake
//
//  Created by Eunbi Han on 2022/07/27.
//

import UIKit

class HintViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    
    let testTexts: [String] = ["버스를 탔는데 자리가 하나밖에 없는거야!", "그래서 빈자리에 얼른 가서 앉았어.", "우리 아가.", "흔들려서 힘들지 않았어?"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 말풍선 생성
        let label1 = createPaddingLabel(text: testTexts[0], viewTag: 1)
        let label2 = createPaddingLabel(text: testTexts[1], viewTag: 2)
        let label3 = createPaddingLabel(text: testTexts[2], viewTag: 3, isLeft: true)
        let label4 = createPaddingLabel(text: testTexts[3], viewTag: 4, isLeft: true)
        
        // 말풍선 위치 설정
        setLabelConstraints(targetLabel: label1, topConstraintView: mainView, isFirst: true)
        setLabelConstraints(targetLabel: label2, topConstraintView: label1)
        setLabelConstraints(targetLabel: label3, topConstraintView: label2, isLeft: true)
        setLabelConstraints(targetLabel: label4, topConstraintView: label3, isLeft: true)

    }
    
    // Padding이 적용된 UILabel 생성
    private func createPaddingLabel(text: String, viewTag: Int = 0, isLeft: Bool = false) -> UILabel {
        let label = PaddingLabel()
        label.padding(10, 10, 10, 10)
        label.tag = viewTag
        label.backgroundColor = isLeft ? .white : .black
        label.textColor = isLeft ? .black : .white
        label.text = text
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 12
        self.mainView.addSubview(label)
        
        return label
    }
    
    // 말풍선에 AutoLayout 적용
    private func setLabelConstraints(targetLabel: UIView, topConstraintView: UIView, isFirst: Bool = false, isLeft: Bool = false) {
        targetLabel.translatesAutoresizingMaskIntoConstraints = false
        targetLabel.topAnchor.constraint(equalTo: isFirst ? topConstraintView.topAnchor : topConstraintView.bottomAnchor, constant: 20).isActive = true
        targetLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10).isActive = isLeft
        targetLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10).isActive = !isLeft
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
