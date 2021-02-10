import UIKit

protocol Storyboarded: AnyObject {
    static var storyboard: UIStoryboard? { get }
}

extension Storyboarded {
    static var storyboard: UIStoryboard? {
      return UIStoryboard(name: "Main", bundle: nil)
    }
}

extension UIViewController: Storyboarded {
    static func instantiate() -> Self? {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: String(describing: self)) as? Self else {
            return nil
        }
      return vc
    }
}

protocol ViewModelBased: AnyObject {
    associatedtype ViewModel
    var viewModel: ViewModel? { get set }
}

extension ViewModelBased where Self: UIViewController {
    static func instantiate (with viewModel: ViewModel) -> Self? {
        let viewController = Self.instantiate()
        viewController?.viewModel = viewModel
        return viewController
    }
}

protocol NibLoadable {
    associatedtype CustomViewType
    static func loadFromNib() -> CustomViewType
}

extension NibLoadable where Self: UIView {
    static func loadFromNib() -> Self? {
        let nib = UINib(nibName: String(describing: self), bundle: nil)
        guard let customView = nib.instantiate(withOwner: self, options: nil).first as? Self else {
            return nil
        }
        return customView
    }
}
