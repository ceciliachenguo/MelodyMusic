//
//  GuideController.swift
//  Guiding/Onboarding Page
//
//  Created by Cecilia Chen on 7/23/23.
//

import UIKit
import TangramKit
import Moya
import RxSwift
import NSObject_Rx

class GuideController: BaseLogicController {
    var bannerView:YJBannerView!

    override func initViews() {
        super.initViews()
        initLinearLayoutSafeArea()
        
        container.tg_space = PADDING_OUTER
        
        bannerView = YJBannerView()
        bannerView.backgroundColor = .clear
        bannerView.dataSource = self
        bannerView.delegate = self
        bannerView.tg_width.equal(320)
        bannerView.tg_height.equal(320)
        bannerView.tg_centerX.equal(0)
        bannerView.tg_top.equal(TGLayoutPos.tg_safeAreaMargin).offset(150)

        //use placeholder if couldn't find image
        bannerView.emptyImage = R.image.placeholder()
        bannerView.placeholderImage = R.image.placeholderError()

        bannerView.bannerViewSelectorString="sd_setImageWithURL:placeholderImage:"

        //setting indicator color
        bannerView.pageControlNormalColor = .black80
                
        //setting indicator highlight color
        bannerView.pageControlHighlightColor = .colorPrimary

        //reload data
        bannerView.reloadData()

        container.addSubview(bannerView)

        //MARK: - Button Container
        let controlContainer = TGLinearLayout(.horz)
        controlContainer.tg_bottom.equal(PADDING_OUTER)
        controlContainer.tg_width ~= .fill
        controlContainer.tg_height.equal(.wrap)
        controlContainer.tg_top.equal(bannerView.tg_bottom).offset(200)
        
        controlContainer.tg_gravity = TGGravity.horz.around
        container.addSubview(controlContainer)
        
        //MARK: - Login Button
        let primaryButton = ViewFactoryUtil.primaryButton()
        primaryButton.setTitle(R.string.localizable.loginOrRegister(), for: .normal)
        primaryButton.addTarget(self, action: #selector(primaryClick(_:)), for: .touchUpInside)
        primaryButton.tg_width.equal(BUTTON_WIDTH_MIDDLE)
        controlContainer.addSubview(primaryButton)
        
        //MARK: - Enter without Login Button
        let enterButton = ViewFactoryUtil.primaryOutlineButton()
        enterButton.setTitle(R.string.localizable.experienceNow(), for: .normal)
        enterButton.addTarget(self, action: #selector(enterClick(_:)), for: .touchUpInside)
        enterButton.tg_width.equal(BUTTON_WIDTH_MIDDLE)
        controlContainer.addSubview(enterButton)
    }
    
    //MARK: - Login Button Action
    @objc func primaryClick(_ sender:QMUIButton) {
        AppDelegate.shared.toLogin()
    }
    
    //MARK: - Without Login Button Action
    @objc func enterClick(_ sender:QMUIButton) {
//        AppDelegate.shared.toMain()
        
        //Use Moya RxSwift
        let moyaProvider = MoyaProvider<DefaultService>()
        moyaProvider.rx.request(.sheets(size: 10))
            .asObservable()
            .mapString()
            .mapObject(SheetListResponse.self)
            .subscribe { event in
            switch event {
            case .next(let data):
                print(data.data.data[0].title!)
            case .error(let error):
                print("Error \(error)")
            case .completed:
                print("completed")
            }
        }.disposed(by: rx.disposeBag) //release memory recourse relate to rxSwift .subscribe
        
    }
}

//MARK: - Conform to YJBannerViewDataSource
extension GuideController:YJBannerViewDataSource {
    func bannerViewImages(_ bannerView: YJBannerView!) -> [Any]! {
        return ["guide1","guide2","guide3"]
    }
    
    func bannerView(_ bannerView: YJBannerView!, customCell: UICollectionViewCell!, index: Int) -> UICollectionViewCell! {
        let cell = customCell as! YJBannerViewCell

        cell.showImageViewContentMode = .scaleAspectFill

        return cell
    }
    
}

//MARK: - Conform to YJBannerViewDelegate
extension GuideController:YJBannerViewDelegate {
    
}

#Preview {
    GuideController()
}
