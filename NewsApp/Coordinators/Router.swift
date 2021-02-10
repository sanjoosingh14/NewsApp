import UIKit

protocol Drawable {
    var viewController: UIViewController? { get }
}

extension UIViewController: Drawable {
    var viewController: UIViewController? { return self }
}

typealias NavigationBackClosure = ((String?) -> ())

protocol RouterProtocol: class {
    func push(_ drawable: Drawable, isAnimated: Bool, onNavigateBack: NavigationBackClosure?, coordinator: String?)
    func present(_ drawable: Drawable, isAnimated: Bool, onNavigateBack: NavigationBackClosure?, coordinator: String?)
    func pop(_ isAnimated: Bool)
    func popToRoot(_ isAnimated: Bool)
    func dismiss(_ isAnimated: Bool)
    func getTopViewController() -> UIViewController?
}

class Router : NSObject, RouterProtocol {
    
    let navigationController: UINavigationController
    private var closures: [String: NavigationBackClosure] = [:]
    private var coordinators: [String: String] = [:]

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self
    }

    func push(_ drawable: Drawable, isAnimated: Bool, onNavigateBack closure: NavigationBackClosure?, coordinator: String?) {
        guard let viewController = drawable.viewController else {
            return
        }
        if let coordinator = coordinator {
            self.coordinators[viewController.description] = coordinator
        }
        
        if let closure = closure {
            closures.updateValue(closure, forKey: viewController.description)
        }
        navigationController.pushViewController(viewController, animated: isAnimated)
    }
    
    func present(_ drawable: Drawable, isAnimated: Bool, onNavigateBack closure: NavigationBackClosure?, coordinator: String?) {
        guard let viewController = drawable.viewController else {
            return
        }
        
        if let coordinator = coordinator {
            self.coordinators[viewController.description] = coordinator
        }
        
        if let closure = closure {
            closures.updateValue(closure, forKey: viewController.description)
        }
        navigationController.present(viewController, animated: true, completion: nil)
    }

    private func executeClosure(_ viewController: UIViewController) {
        guard let closure = closures.removeValue(forKey: viewController.description) else { return }
        guard let coordinator = coordinators.removeValue(forKey: viewController.description) else { return }
        closure(coordinator)
    }
    
    func pop(_ isAnimated: Bool) {
        navigationController.popViewController(animated: isAnimated)
    }
    
    func popToRoot(_ isAnimated: Bool) {
        navigationController.popToRootViewController(animated: isAnimated)
    }
    
    func dismiss(_ isAnimated: Bool) {
        navigationController.dismiss(animated: isAnimated, completion: nil)
        guard let previousController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(previousController) else {
                return
        }
        executeClosure(previousController)
    }
    
    func getTopViewController() -> UIViewController? {
        return navigationController.viewControllers.last
    }
}

extension Router : UINavigationControllerDelegate {

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let previousController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(previousController) else {
                return
        }
        executeClosure(previousController)
    }
}
