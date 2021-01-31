
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
    var newsDataSource = Observable<[NewsDetailDataSource]?>(value: [])
    var news:News?
    init(with news:News){
        // display data with previous news data firstly.
        self.news = news
    }
    func fetchcomments(){
    if let url = URL(string: "https://cn-news-info-api.herokuapp.com/comments/_"){
            NewsAPI.shared.getCommentsCount(with: url) { [weak self](comment) in
                if let data = self?.news{
                    data.comment = comment
                    self?.newsDataSource.value = self?.createDetailDataSource(newsList: [data])
                }
            }
        }
    }
    func fetchlikes(){
      if let url = URL(string: "https://cn-news-info-api.herokuapp.com/likes/_"){
              NewsAPI.shared.getLikesCount(with: url) { [weak self](like) in
                  if let data = self?.news{
                      data.like = like
                      self?.newsDataSource.value = self?.createDetailDataSource(newsList: [data])
                  }
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
