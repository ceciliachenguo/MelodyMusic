//
//  SongGroupCell.swift
//  MelodyMusic
//
//  Created by Cecilia Chen on 8/14/23.
//

import UIKit
import TangramKit

class SongGroupCell: BaseTableViewCell {
    static let NAME = "SongGroupCell"
    var data:SongData!
    
    static let HEIGHT_DISCOVERY_SONG:CGFloat = 51+10*2
    
    override func initViews() {
        super.initViews()
        container.addSubview(ViewFactoryUtil.smallDivider())
        
        container.addSubview(titleView)
        container.addSubview(self.tableView)
    }
    
    override func getContainerOrientation() -> TGOrientation {
        return .vert
    }
    
    func bind(_ data:SongData) {
        self.data = data
        let viewHeight = CGFloat(data.datum.count) * SongGroupCell.HEIGHT_DISCOVERY_SONG
        tableView.tg_height.equal(viewHeight)
        tableView.reloadData()
    }
    
    lazy var titleView: ItemTitleView = {
        let r = ItemTitleView()
        r.titleView.text = R.string.localizable.recommendSong()
        return r
    }()
    
    lazy var tableView: UITableView = {
        let result=ViewFactoryUtil.tableView()
        result.separatorStyle = .singleLine
        
        result.separatorColor = .colorDivider
        result.delegate = self
        result.dataSource = self
        
        result.register(DiscoverySongCell.self, forCellReuseIdentifier: Constants.CELL)
        
        return result
    }()
}

extension SongGroupCell:QMUITableViewDelegate,QMUITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.datum.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = data.datum[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CELL, for: indexPath) as! DiscoverySongCell
        
        if indexPath.row == 0 {
            cell.container.tg_padding = UIEdgeInsets(top: 0, left: PADDING_OUTER, bottom: PADDING_MIDDLE, right: PADDING_OUTER)
        } else {
            cell.container.tg_padding = UIEdgeInsets(top: PADDING_MIDDLE, left: PADDING_OUTER, bottom: PADDING_MIDDLE, right: PADDING_OUTER)
        }
        
        cell.bind(data)
        
        return cell
    }
    
}
