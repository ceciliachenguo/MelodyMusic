//
//  SheetGroupCell.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 8/11/23.
//

import UIKit
import TangramKit

class SheetGroupCell: BaseTableViewCell {
    static let NAME = "SheetGroupCell"
    var datum:Array<Sheet> = []
    var cellWidth:CGFloat!
    var cellHeight:CGFloat!
    var spanCount:CGFloat = 3

    override func initViews() {
        super.initViews()
        
        container.addSubview(ViewFactoryUtil.smallDivider())
        
        container.addSubview(titleView)
        container.addSubview(collectionView)
        
        collectionView.register(SheetCell.self, forCellWithReuseIdentifier: Constants.CELL)
    }
    
    override func getContainerOrientation() -> TGOrientation {
        return .vert
    }
    
    func bind(_ data: SheetData) {
        cellWidth = (SCREEN_WIDTH - PADDING_OUTER * CGFloat(2) - (spanCount-CGFloat(1)) * PADDING_SMALL)/spanCount
        
        cellHeight = cellWidth + PADDING_SMALL + 40
        
        let rows = ceil(CGFloat(data.datum.count) / spanCount)
        
        let viewHeight = rows * (cellHeight + PADDING_MIDDLE)
        collectionView.tg_height.equal(viewHeight)
        
        datum.removeAll()
        datum += data.datum
        collectionView.reloadData()
    }
    
    lazy var titleView: ItemTitleView = {
        let r = ItemTitleView()
        r.titleView.text = R.string.localizable.recommendSheet()
        return r
    }()

    lazy var collectionView: UICollectionView = {
        let r = ViewFactoryUtil.collectionView()
        r.delegate = self
        r.dataSource = self
        r.isScrollEnabled = false
        
        return r
    }()
}

extension SheetGroupCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datum.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = datum[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CELL, for: indexPath) as! SheetCell
        
        cell.bind(data)
        return cell
    }
    
}

extension SheetGroupCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: PADDING_OUTER, bottom: PADDING_OUTER, right: PADDING_OUTER)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return PADDING_MIDDLE
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return PADDING_SMALL
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
