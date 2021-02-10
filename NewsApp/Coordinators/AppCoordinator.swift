import UIKit

class AppCoordinator: Coordinator {
    var childCoordinators: [String : Coordinator] = [:]
    var isCompleted: ((String?) -> ())?
    private let navigationController: UINavigationController
    private let router: RouterProtocol
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.router = Router(navigationController: navigationController)
    }
    
    func start() {
        let newsListCoordinator = NewsListCoordinator(router: self.router)
        childCoordinators[String(describing: NewsListCoordinator.self)] = newsListCoordinator
        newsListCoordinator.isCompleted = { [weak self] coordinator in
            guard let self = self, let coordinator = coordinator else { return }
            self.childCoordinators.removeValue(forKey: coordinator)
        }
        newsListCoordinator.start()
    }
}
