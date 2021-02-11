
import Foundation
import UIKit

enum newsListCellType {
    case image
}

enum clickEventType: String {
    case image
}

protocol NewsCellDataSource {
    var cellType: newsListCellType { get }
    var cellIdentifier: String { get }
    var newsModel: News { get }
    func getheightOfCell(tableViewWidth: CGFloat) -> CGFloat
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell
}

protocol CellConfigurable {
    associatedtype cellViewModel
    var viewModel: cellViewModel? { get set }
    func configureCellWithModel(_: cellViewModel)
}

protocol NewsViewModelInput {
    func fetchArticles()
}

protocol NewsViewModelOutput {
    var news: Observable<[NewsCellDataSource]> { get }
    var isLoader: Observable<Bool> { get }
}

protocol NewsListPViewModel: NewsViewModelInput, NewsViewModelOutput {}

class NewsListViewModel:NewsListPViewModel{
    
    var isLoader = Observable<Bool>(value: true)
    var news = Observable<[NewsCellDataSource]>(value: [])
    private let newApiURl = "https://newsapi.org/v2/top-headlines?country=us&apiKey=2ed7996e7c844109abdca49cd1623719"
    private let photoLoader: PhotoDownloader
    private let newUseCase: NewsListUseCase
    
    init(_ newUseCase: NewsListUseCase, downloader: PhotoDownloader) {
        self.newUseCase = newUseCase
        self.photoLoader = downloader
    }
    
    // MARK:- fetching articles
    func fetchArticles() {
        if let newsEndPoint = NewsEndPoint(self.newApiURl) {
            self.newUseCase.execute(newsEndPoint) { [weak self](result) in
                switch result {
                case .success(let newsModel):
                    self?.getAllNewsPhotoUrls(newsModel: newsModel)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func getAllNewsPhotoUrls(newsModel: NewsList){
        guard let newsList = newsModel.articles else { return }
        var celldata = [NewsCellDataSource]()
        for news in newsList {
            if let url = news.urlToImage{
                let photosRecord = PhotoRecord(urlStr: url)
                let cellDataSource = NewsListImageViewModel(photosRecord: photosRecord, downloader: self.photoLoader, news: news)
                celldata.append(cellDataSource)
            }
        }
        self.isLoader.value = false
        self.news.value = celldata
    }
    
}
