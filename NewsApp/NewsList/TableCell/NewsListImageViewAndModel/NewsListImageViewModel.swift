//
//  NewsListImageTableCellViewModel.swift
//  NewsApp
//
//  Created by Miraah on 30/01/21.
//  Copyright © 2021 Self. All rights reserved.
//

import Foundation
import UIKit

struct NewsListImageViewModel:NewsListDataSource {
    var cellType: newsListCellType {
        return .image
    }
    
   var cellIdentifier: String {
        return "NewsListImageViewTableViewCell"
    }
    
    var newsModel: News
    
    func getheightOfCell(tableViewWidth: CGFloat) -> CGFloat {
        return CGFloat(180)
    }
    
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath, actionDelegate: cellActionDelegate?) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? NewsListImageViewTableViewCell {
            cell.selectionStyle = .none
            cell.delegate = actionDelegate
            cell.configureCellWithModel(self)
            return cell
        }
        return UITableViewCell()
    }
}
