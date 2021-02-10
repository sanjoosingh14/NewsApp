import UIKit

class NewsListCoordinator: Coordinator {
    var childCoordinators: [String : Coordinator] = [:]
    private let router: RouterProtocol
    var isCompleted: ((String?) -> ())?
    
    init(router: RouterProtocol) {
        self.router = router
    }
    
    func start() {
        let newsUseCase = DefaultNewsListUseCase(NewsListRepository(NetworkRouter()))
        let newsViewModel = NewsListViewModel(newsUseCase, downloader: PhotoDownloader())
        if let newsListViewCon = NewsListViewController.instantiate(with: newsViewModel){
            newsListViewCon.delegate = self
            self.router.push(newsListViewCon, isAnimated: true, onNavigateBack: isCompleted, coordinator: String(describing: NewsListCoordinator.self))
        }
    }
    
    func openNewsDetailScreen(_ dataSource: News){
        let newsDetail = NewsDetailCoordinator(router: self.router, dataSource: dataSource)
        childCoordinators[String(describing: NewsDetailCoordinator.self)] = newsDetail
        newsDetail.isCompleted = { [weak self] coordinator in
            guard let self = self, let coordinator = coordinator else { return }
            self.childCoordinators.removeValue(forKey: coordinator)
        }
        newsDetail.start()
    }
    
}
