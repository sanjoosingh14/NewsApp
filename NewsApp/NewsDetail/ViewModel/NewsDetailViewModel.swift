
import Foundation
import UIKit

enum newsDetialCellType {
    case image
    case description
    case additionalInfo
}

protocol NewsDetailDataSource {
    var cellType: newsDetialCellType { get }
    var cellIdentifier: String { get }
    var newsModel: News { get }
    func getheightOfCell(tableViewWidth: CGFloat) -> CGFloat
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell
}
class NewsDetailViewModel{
    
    var isLoader = Observable<Bool>(value: true)
    var newsDataSource = Observable<[NewsDetailDataSource]?>(value: [])
    private var news:News
    private var commentCount:Int = 0
    private var likeCount:Int = 0

    private let photoLoader: PhotoDownloader
    private let newsUseCase: NewsDetailUseCase
    private let likeUrl = "https://cn-news-info-api.herokuapp.com/likes/_"
    private let commentUrl = "https://cn-news-info-api.herokuapp.com/comments/_"

    init(_ newsUseCase: NewsDetailUseCase, downloader: PhotoDownloader, newsDetail: News) {
        self.newsUseCase = newsUseCase
        self.photoLoader = downloader
        self.news = newsDetail
    }
    
    
    //MARK:- Fetch comments and Likes
    
    func downloadDetails(){
        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
        if let newsEndPoint = NewsEndPoint(self.likeUrl) {
             self.newsUseCase.executeLikes(newsEndPoint) { [weak self](result) in
                 switch result {
                 case .success(let like):
                  self?.likeCount = like.likes ?? 0
                 case .failure(let error):
                     print(error)
                 }
                DispatchQueue.main.async {
                    dispatchGroup.leave()
                }
             }
         }

        dispatchGroup.enter()
        if let newsEndPoint = NewsEndPoint(self.commentUrl) {
                      self.newsUseCase.executeComment(newsEndPoint) { [weak self](result) in
                          switch result {
                          case .success(let comment):
                              self?.commentCount = comment.comments ?? 0
                          case .failure(let error):
                              print(error)
                          }
                        DispatchQueue.main.async {
                            dispatchGroup.leave()
                        }
                      }
        }

        dispatchGroup.notify(queue: .main) {
             self.newsDataSource.value = self.createDetailDataSource()
             self.isLoader.value = false
        }
    }
    
    func createDetailDataSource()-> [NewsDetailDataSource]{
        var newsDataSource = [NewsDetailDataSource]()
        
            if let url = news.urlToImage{
                let photosRecord = PhotoRecord(urlStr: url)
                newsDataSource.append(ImageTableCellViewModel(photosRecord: photosRecord, downloader: self.photoLoader, news: news))
            }
           newsDataSource.append(AditionalInfoTableCellViewModel(like:likeCount, comment:commentCount, news: self.news))
            if let _ = news.title{
                newsDataSource.append(DescriptionTablleCellViewModel(news: news))
            }
          return newsDataSource
      }

}
