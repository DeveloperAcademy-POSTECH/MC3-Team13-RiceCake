//
//  HintViewController.swift
//  RiceCake
//
//  Created by Eunbi Han on 2022/07/27.
//

import UIKit

final class HintViewController: UIViewController {

    @IBOutlet weak var mainView: UIView!
    
    var labelTagNumber: Int = 1
    var isHintEnd = false
    let jsonScript: [StageHint] = loadJson("HintScript.json")
    var stageNumber: Int = 0
    var missionNumber: Int = 0
    var nextAction: Notification.Name = .drawBusSeatHint
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 불러온 Json 파일에서 정보 가져와 말풍선 생성
        for script in jsonScript[0].missionHints[missionNumber].content {
            let isFirst: Bool = script.id == 1
            let isLeft: Bool = script.isLeft ?? false
            let topConstraintView: UIView = (isFirst ? mainView : view.viewWithTag(script.id-1)) ?? mainView
            
            let label = createPaddingLabel(text: script.text, viewTag: script.id, isLeft: isLeft)
            setLabelConstraints(targetLabel: label, topConstraintView: topConstraintView, isFirst: isFirst, isLeft: isLeft)
        }
        
        // Tab Gesture Recongnizer 생성
        createTapGesture(targetView: view)
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
    
    private func createTapGesture(targetView: UIView) {
        let viewTapped: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(appearLabel(_:)))
        targetView.addGestureRecognizer(viewTapped)
    }
    
    // TapGesture 인식하면 말풍선이 순서대로 화면에 나옴
    @objc func appearLabel(_ sender: UITapGestureRecognizer) {
        if labelTagNumber == jsonScript[0].missionHints[missionNumber].content.count {
            isHintEnd = true
            // 힌트 종료하고 다음 장면으로 넘어가기
            NotificationCenter.default.post(name: nextAction, object: nil)
            print("Hint \(missionNumber) is completed")
        }
        labelTagNumber += 1
        self.view.viewWithTag(labelTagNumber)?.isHidden = false
    }
    func configure(stageNumber: Int, missionNumber: Int, nextAction: Notification.Name) {
        self.stageNumber = stageNumber
        self.missionNumber = missionNumber
        self.nextAction = nextAction
    }
}
