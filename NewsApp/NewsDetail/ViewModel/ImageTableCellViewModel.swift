import Foundation
import UIKit

class ImageTableCellViewModel:NewsDetailDataSource {
   
    var cellType: newsDetialCellType {
        return .image
    }
    
   var cellIdentifier: String {
        return String(describing: ImageTableViewCell.self)
    }
    
    var newsModel: News
    private let photosRecord: PhotoRecord
    private let photoLoader: PhotoDownloader
    
    init(photosRecord: PhotoRecord, downloader: PhotoDownloader, news:News) {
         self.photosRecord = photosRecord
         self.photoLoader = downloader
         self.newsModel = news

    }
    var image = Observable<UIImage?>(value: nil)
    
    func getheightOfCell(tableViewWidth: CGFloat) -> CGFloat {
        return CGFloat(300)
    }
    
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? ImageTableViewCell {
            cell.selectionStyle = .none
            cell.configureCellWithModel(self)
            self.startOperations(at: indexPath.item)
            return cell
        }
        return UITableViewCell()
    }
    func startOperations(at index: Int) {
        switch (photosRecord.state) {
        case .new:
           self.photoLoader.loadPhoto(photoRecord: photosRecord, index: index) { [weak self](image, index) in
               self?.image.value = image
            }
        default:
            break
        }
    }
}
