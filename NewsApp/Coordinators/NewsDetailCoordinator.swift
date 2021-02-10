import UIKit

class NewsDetailCoordinator: Coordinator {
    var childCoordinators: [String : Coordinator] = [:]
    weak var parentCoordinator: Coordinator?
    private let router: RouterProtocol
    private let dataSource: News
    var isCompleted: ((String?) -> ())?

    
    init(router: RouterProtocol, dataSource: News) {
        self.router = router
        self.dataSource = dataSource
    }
    
    func start() {
        let detailUseCase = DefaultNewsDetailUseCase(NewsDetailRepository(NetworkRouter()))
        let detailViewModel = NewsDetailViewModel(detailUseCase, downloader: PhotoDownloader(),newsDetail: dataSource)
        if let newsDetail = NewsDetialViewController.instantiate(with: detailViewModel) {
            newsDetail.delegate = self
            self.router.push(newsDetail, isAnimated: true, onNavigateBack: isCompleted, coordinator: String(describing: NewsDetailCoordinator.self))
        }
    }
    
}
