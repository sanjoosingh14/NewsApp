import Foundation
import UIKit

struct AditionalInfoTableCellViewModel:NewsDetailDataSource {
   
    var cellType: newsDetialCellType {
        return .additionalInfo
    }
    
   var cellIdentifier: String {
        return "AdditionalInfoTableViewCell"
    }
    
    var newsModel: News
    
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
