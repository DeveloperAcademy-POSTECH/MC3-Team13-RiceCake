//
//  StageViewController.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/14.
//

import UIKit

class StageViewController: UIViewController {
    
    let lists: [Stage] = Stage.list
    var index: Int = 0
    
    @IBOutlet weak var stageNameLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    // 커스텀 레이아웃
    let flowLayout = PagedFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.collectionViewLayout = flowLayout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.decelerationRate = .fast
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.delegate = self
        stageNameLabel.text = Stage.list[index].stageName
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func leftButtonTapped(_ sender: UIButton) {
        if index != 0 {
            index -= 1
            stageNameLabel.text = Stage.list[index].stageName
        } else {
            index = 0
        }
        
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func rightButtonTapped(_ sender: UIButton) {
        if index != lists.count - 1 {
            index += 1
            stageNameLabel.text = Stage.list[index].stageName
        } else {
            index = lists.count - 1
        }
        
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension StageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StageCell", for: indexPath) as? StageCell else {
            return UICollectionViewCell()
        }
        
        let stage = Stage.list[indexPath.item]
        cell.configure(stage)
        
        return cell
    }
}

extension StageViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page: Int = Int(scrollView.contentOffset.x / view.bounds.height)
        stageNameLabel.text = Stage.list[page].stageName
        self.index = page
    }
}
    
extension StageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "GameView", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
