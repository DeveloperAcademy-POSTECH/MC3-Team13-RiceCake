//
//  PaggedFlowLayout.swift
//  RiceCake
//
//  Created by Jung Yunseong on 2022/07/19.
//

import UIKit

class PagedFlowLayout: UICollectionViewFlowLayout {

    override init() {
        super.init()

        scrollDirection = .horizontal
        minimumLineSpacing = 60
        minimumInteritemSpacing = 0
        sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepare() {
        super.prepare()

        guard let collectionView = collectionView else { fatalError() }

        let itemHeight = collectionView.bounds.height - sectionInset.top - sectionInset.bottom
        itemSize = CGSize(width: itemHeight * 1.5, height: itemHeight)

        let horizontalInsets = (collectionView.bounds.width - itemSize.width) / 2
        sectionInset.left = horizontalInsets
        sectionInset.right = horizontalInsets
    }

     // 스크롤 이후 셀이 가운데에 위치하도록 함. https://stackoverflow.com/a/14291208/1966109
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return .zero }

        var proposedContentOffset = proposedContentOffset
        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let horizontalCenter = proposedContentOffset.x + collectionView.bounds.size.width / 2
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)

        guard let layoutAttributesArray = super.layoutAttributesForElements(in: targetRect) else { return .zero }

        for layoutAttributes in layoutAttributesArray {
            let itemHorizontalCenter = layoutAttributes.center.x
            if abs(itemHorizontalCenter - horizontalCenter) < abs(offsetAdjustment) {
                offsetAdjustment = itemHorizontalCenter - horizontalCenter
            }
        }

        var nextOffset = proposedContentOffset.x + offsetAdjustment
        let snapStep = itemSize.width + minimumLineSpacing

        func isValidOffset(_ offset: CGFloat) -> Bool {
            let minContentOffset = -collectionView.contentInset.left
            let maxContentOffset = collectionView.contentInset.left + collectionView.contentSize.width - itemSize.width
            return offset >= minContentOffset && offset <= maxContentOffset
        }

        repeat {
            proposedContentOffset.x = nextOffset
            let deltaX = proposedContentOffset.x - collectionView.contentOffset.x
            let velX = velocity.x

            if deltaX.sign.rawValue * velX.sign.rawValue != -1 {
                break
            }

            nextOffset += CGFloat(velocity.x.sign.rawValue) * snapStep
        } while isValidOffset(nextOffset)

        return proposedContentOffset
    }

}
