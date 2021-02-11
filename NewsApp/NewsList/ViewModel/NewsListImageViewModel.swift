
import Foundation
import UIKit

class NewsListImageViewModel:NewsCellDataSource {
    var cellType: newsListCellType {
        return .image
    }

    var cellIdentifier: String {
        return String(describing: NewsListImageViewTableViewCell.self)
    }
    
    var newsModel: News
    private let photosRecord: PhotoRecord
    private let photoLoader: PhotoDownloader
    
    func getheightOfCell(tableViewWidth: CGFloat) -> CGFloat {
        return CGFloat(180)
    }
    
    var image = Observable<UIImage?>(value: nil)
    
    // MARK:- Initilisation

    init(photosRecord: PhotoRecord, downloader: PhotoDownloader, news:News) {
        self.photosRecord = photosRecord
        self.photoLoader = downloader
        self.newsModel = news

    }
    
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? NewsListImageViewTableViewCell {
            cell.selectionStyle = .none
            cell.configureCellWithModel(self)
            self.startOperations(at: indexPath.item)
            return cell
        }
        return UITableViewCell()
    }
    
    // MARK:- Download Image
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
