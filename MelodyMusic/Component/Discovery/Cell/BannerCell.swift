//
//  BannerCell.swift
//  Cell for Banner in Discovery
//
//  Created by Cecilia Chen on 7/27/23.
//

import UIKit

class BannerCell: BaseTableViewCell {
    
    var bannerView:YJBannerView!
    var data:BannerData!
    var datum:[String] = []

    override func initViews() {
        super.initViews()
        
        //bottom padding is the padding between this banner cell to the next cell
        self.container.tg_padding = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        
        //banner view images
        bannerView=YJBannerView()
        bannerView.backgroundColor = .clear
        bannerView.dataSource = self
        bannerView.delegate = self
        bannerView.tg_width.equal(.fill)
        
        bannerView.tg_height.equal(UIScreen.main.bounds.width * 0.389)
        
        bannerView.clipsToBounds = true
        bannerView.layer.cornerRadius = 10
        
        //placeholder if couldn't find the image
        bannerView.emptyImage=R.image.placeholder()
        
        bannerView.placeholderImage=R.image.placeholder()
        
        bannerView.bannerViewSelectorString="sd_setImageWithURL:placeholderImage:"
        
        //set indicator color
        bannerView.pageControlNormalColor = .black80
        
        //set hightlight color
        bannerView.pageControlHighlightColor = .colorPrimary
        
        container.addSubview(bannerView)
        
    }
    
    func bind(_ data:BannerData) {
        self.data=data
        datum.removeAll()
        
        for it in data.data {
            datum.append(ResourceUtil.resourceUrl(it.icon))
        }
        bannerView.reloadData()
    }
}

// MARK: - banner data source and delegate
extension BannerCell:YJBannerViewDataSource,YJBannerViewDelegate{
    func bannerViewImages(_ bannerView: YJBannerView!) -> [Any]! {
        return datum
    }
    
    func bannerView(_ bannerView: YJBannerView!, customCell: UICollectionViewCell!, index: Int) -> UICollectionViewCell! {
        //convert cell type into YJBannerViewCell
        let cell = customCell as! YJBannerViewCell

        cell.showImageViewContentMode = .scaleAspectFill
        
        return cell
    }
}

