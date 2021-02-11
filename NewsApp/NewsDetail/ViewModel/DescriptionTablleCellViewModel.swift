import Foundation
import UIKit

class DescriptionTablleCellViewModel:NewsDetailDataSource {
   
    var cellType: newsDetialCellType {
        return .description
    }
    
    var cellIdentifier: String {
        return String(describing: DescriptionTableViewCell.self)
    }
    var newsModel: News
    
    // MARK:- Initialization

    init(news:News) {
        self.newsModel = news
    }
    
    func getheightOfCell(tableViewWidth: CGFloat) -> CGFloat {
      // return UITableView.automaticDimension
      //  return 600
        if let title = newsModel.title, let description = newsModel.description {
           let constraintRect = CGSize(width: 0.60 * tableViewWidth, height: .greatestFiniteMagnitude)
            let boundingBox = (title + description).boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: UIFont.systemFont(ofSize: 18) as Any], context: nil)
           return boundingBox.height + 53
        }
        return CGFloat(0)
    }
    
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? DescriptionTableViewCell {
            cell.selectionStyle = .none
            cell.configureCellWithModel(self)
            return cell
        }
        return UITableViewCell()
    }
}
