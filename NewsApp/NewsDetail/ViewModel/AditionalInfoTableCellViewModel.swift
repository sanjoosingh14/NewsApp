import Foundation
import UIKit

class AditionalInfoTableCellViewModel:NewsDetailDataSource {
    var newsModel: News
    var cellType: newsDetialCellType {
        return .additionalInfo
    }
    
   var cellIdentifier: String {
        return String(describing: AdditionalInfoTableViewCell.self)
    }
    
    var likeCount: Int
    var commentCount: Int

    init(like:Int, comment:Int,news:News) {
         self.newsModel = news
         self.likeCount = like
         self.commentCount = comment

    }
    func getheightOfCell(tableViewWidth: CGFloat) -> CGFloat {
        return CGFloat(40)
    }
    
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? AdditionalInfoTableViewCell {
            cell.selectionStyle = .none
            cell.configureCellWithModel(self)
            return cell
        }
        return UITableViewCell()
    }
    
}
