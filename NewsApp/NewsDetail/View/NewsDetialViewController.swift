
import UIKit

class NewsDetialViewController: UIViewController, ViewModelBased {

    typealias ViewModel = NewsDetailViewModel
    var viewModel: NewsDetailViewModel?
    weak var delegate: NewsDetailCoordinator?
    
    @IBOutlet weak var tableview_detail: UITableView!
    @IBOutlet weak var loader_view: UIActivityIndicatorView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.startBinding()
        self.viewModel?.downloadDetails()
    }
    
    
    //MARK:- Setup Views
    private func setUpTableViewCell(){
        tableview_detail.delegate = self
        tableview_detail.dataSource = self
        tableview_detail.register(DescriptionTableViewCell.self, forCellReuseIdentifier: String(describing: DescriptionTableViewCell.self))
        tableview_detail.register(AdditionalInfoTableViewCell.self, forCellReuseIdentifier: String(describing: AdditionalInfoTableViewCell.self))
        tableview_detail.register(ImageTableViewCell.self, forCellReuseIdentifier: String(describing: ImageTableViewCell.self))
    }
    
    func startBinding() {
        viewModel?.isLoader.addObserver(fireNow: true, {[weak self](val) in
             if val {
                 self?.loader_view.startAnimating()
             }else{
                 self?.loader_view.stopAnimating()
             }
         })
        self.setUpTableViewCell()
        viewModel?.newsDataSource.addObserver({ [weak self] _ in
           DispatchQueue.main.async {
                self?.tableview_detail?.reloadData()
            }
        })
    }
}

extension NewsDetialViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return viewModel?.newsDataSource.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let dataSource = viewModel?.newsDataSource.value, dataSource.count > 0 {
            let dataSourceModel = dataSource[indexPath.row]
            return dataSourceModel.cellForTableView(tableView: tableView, atIndexPath: indexPath)
        }
        return UITableViewCell()
    }
}

extension NewsDetialViewController: UITableViewDelegate{
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let dataSource = viewModel?.newsDataSource.value, dataSource.count > 0 {
            let dataSourceModel = dataSource[indexPath.row]
            return dataSourceModel.getheightOfCell(tableViewWidth: tableView.frame.width)

        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
