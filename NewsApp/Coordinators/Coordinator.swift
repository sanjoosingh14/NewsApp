import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [String: Coordinator] { get }
    func start()
}
