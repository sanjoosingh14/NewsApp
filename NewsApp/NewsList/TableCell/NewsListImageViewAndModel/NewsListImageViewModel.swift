
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
    var published: String {
        if let publishdate = newsModel.publishedAt, let publishedDate = publishdate.toDate(withFormat: "yyyy-MM-dd'T'HH:mm:ssZ"){
            let published = publishedDate.getFormattedDate(format: "HH:mm E, d MMM y")
            return "\(published) by \(newsModel.author ?? "")"
        }
        else{
            return "\(newsModel.author ?? "")"
        }
    }
}
