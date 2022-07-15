//
//  StageViewController.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/14.
//

import UIKit

class StageViewController: UIViewController {
    
    let lists: [Stage] = Stage.list
    
    var index = 0
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    typealias Item = Stage
    enum Section {
        case main
    }
    
    @IBOutlet weak var stageNameLabel: UILabel!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StageCell", for: indexPath) as? StageCell else {
                return nil
            }
            
            cell.configure(item)
            return cell
        })
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.main])
        snapshot.appendItems(lists, toSection: .main)
        dataSource.apply(snapshot)
        
        collectionView.collectionViewLayout = layout()
        
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 90
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        section.visibleItemsInvalidationHandler = { [self] (item, offset, env) in
            self.index = Int((offset.x + 654) / 465)
            if self.index > lists.count - 1 {
            } else {
                self.stageNameLabel.text = Stage.list[self.index].stageName
            }
            
            print(self.index)
        }
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    @IBAction func leftButtonTapped(_ sender: UIButton) {
        if index == 0 {
            index = 0
        } else {
            index -= 1
            stageNameLabel.text = Stage.list[index].stageName
        }
        
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func rightButtonTapped(_ sender: UIButton) {
        if index == lists.count - 1 {
            index = lists.count - 1
        } else {
            index += 1
            stageNameLabel.text = Stage.list[index].stageName
        }
        
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
}

extension StageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "GameView", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}
