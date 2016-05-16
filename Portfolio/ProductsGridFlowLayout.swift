//
//  ProductsGridFlowLayout.swift
//  LayoutChanger
//
//  Created by Sztanyi Szabolcs on 22/02/16.
//  Copyright © 2016 Zappdesigntemplates. All rights reserved.
//

import UIKit

class ProductsGridFlowLayout: UICollectionViewFlowLayout {

//    var itemHeight = CGFloat()
//    var cellWidth = CGFloat()

    override init() {
        super.init()
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }

    /**
     Sets up the layout for the collectionView. 0 distance between each cell, and vertical layout
     */
    func setupLayout() {
        minimumInteritemSpacing = 10
        minimumLineSpacing = 30
        scrollDirection = .Vertical
    }
    
    func itemWidth() -> CGFloat {
        return ((CGRectGetWidth(collectionView!.frame)-40)/3)-10
    }
    
    func itemHeight() -> CGFloat {
        return ((CGRectGetWidth(collectionView!.frame)-42)/3)-10+100
    }
    
    override var itemSize: CGSize {
        set {
            self.itemSize = CGSizeMake(itemWidth(), itemHeight())
        }
        get {
            return CGSizeMake(itemWidth(), itemHeight())
        }
    }

    override func targetContentOffsetForProposedContentOffset(proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
}
