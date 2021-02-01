
import Foundation
import UIKit

enum newsListCellType {
    case image
    case video
}

enum clickEventType: String {
    case image
    case video
}

protocol NewsListDataSource {
    var cellType: newsListCellType { get }
    var cellIdentifier: String { get }
    var newsModel: News { get }
    func getheightOfCell(tableViewWidth: CGFloat) -> CGFloat
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath, actionDelegate: cellActionDelegate?) -> UITableViewCell
}

protocol cellActionDelegate: AnyObject{
    func clickAction(with type: clickEventType, and newsData: News?)
}

protocol CellConfigurable {
    associatedtype cellViewModel
    var viewModel: cellViewModel? { get set }
    func configureCellWithModel(_: cellViewModel)
}

class NewsListViewModel{
    let newsRepository: NewsRepository
    var newsDataSource = Observable<[NewsListDataSource]?>(value: [])

    init( newsRepository: NewsRepository = NewsRepositoryImp()) {
        self.newsRepository = newsRepository
    }
    
    //MARK:- Fetch news

    func fetchNewsFromApi(){
            self.newsRepository.fetchNews { [weak self](news) in
                if let data = news{
                    self?.newsDataSource.value = self?.createNewsDataSource(newsList: data)
                }
            }
        
    }
    
    func createNewsDataSource(newsList: [News])-> [NewsListDataSource]{
          var newsDataSource = [NewsListDataSource]()
          for news in newsList {
            if let dataSource = makeNewsDataSourceElement(news: news) {
                newsDataSource.append(dataSource)
            }
          }
          return newsDataSource
      }
    func makeNewsDataSourceElement(news: News) -> NewsListDataSource? {
        if let _ = news.urlToImage{
            return NewsListImageViewModel(newsModel: news)
        }
        
        return nil
    }

}
