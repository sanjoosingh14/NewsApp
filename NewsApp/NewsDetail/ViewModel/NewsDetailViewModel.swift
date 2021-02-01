
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
    let newsRepository: NewsRepository
    var newsDataSource = Observable<[NewsDetailDataSource]?>(value: [])
    var news:News?
    
    init(newsRepository: NewsRepository = NewsRepositoryImp()) {
        self.newsRepository = newsRepository
    }
    convenience init(with news:News){
        // display data with previous news data firstly.
        self.init()
        self.news = news
    }
    
    //MARK:- Fetch comments

    func fetchcomments(){
        self.newsRepository.getCommentsCount{ [weak self](comment) in
                if let data = self?.news{
                    data.comment = comment
                    self?.newsDataSource.value = self?.createDetailDataSource(newsList: [data])
                }
            }
    }
    
    //MARK:- Fetch likes

    func fetchlikes(){
       self.newsRepository.getLikesCount { [weak self](like) in
                  if let data = self?.news{
                      data.like = like
                      self?.newsDataSource.value = self?.createDetailDataSource(newsList: [data])
                  }
              }
        
    }
    
    func showData(){
        if let news = self.news{
            self.newsDataSource.value = self.createDetailDataSource(newsList: [news])
        }
    }
    func createDetailDataSource(newsList: [News])-> [NewsDetailDataSource]{
        var newsDataSource = [NewsDetailDataSource]()
          for news in newsList {
            if let _ = news.urlToImage{
                newsDataSource.append(ImageTableCellViewModel(newsModel: news))
            }
            if let _ = news.comment{
                newsDataSource.append(AditionalInfoTableCellViewModel(newsModel: news))
            }
            if let _ = news.description{
                newsDataSource.append(DescriptionTablleCellViewModel(newsModel: news))
            }
          }
          return newsDataSource
      }
}
