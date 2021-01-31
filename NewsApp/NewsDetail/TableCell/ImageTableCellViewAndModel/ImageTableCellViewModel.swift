import Foundation
import UIKit

struct ImageTableCellViewModel:NewsDetailDataSource {
   
    var cellType: newsDetialCellType {
        return .image
    }
    
   var cellIdentifier: String {
        return "ImageTableViewCell"
    }
    
    var newsModel: News
    
    func getheightOfCell(tableViewWidth: CGFloat) -> CGFloat {
        return CGFloat(300)
    }
    
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? ImageTableViewCell {
            cell.selectionStyle = .none
            cell.configureCellWithModel(self)
            return cell
        }
        return UITableViewCell()
    }
}
