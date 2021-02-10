
import UIKit

class NewsListViewController: UIViewController, ViewModelBased {
   
    typealias ViewModel = NewsListViewModel
    var viewModel: NewsListViewModel?
    weak var delegate: NewsListCoordinator?
    
    @IBOutlet weak var tableview_news: UITableView!
    @IBOutlet weak var loader_view: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "US Top Headlines"
        self.tableview_news.alpha = 0
        self.setupBinding()
        viewModel?.fetchArticles()
    }
    
    //MARK:- Setup Views
    private func setUpTableViewCell(){
        tableview_news.delegate = self
        tableview_news.dataSource = self
        tableview_news.register(NewsListImageViewTableViewCell.self, forCellReuseIdentifier: String(describing: NewsListImageViewTableViewCell.self))
        self.tableview_news.alpha = 0
    }
    
    // MARK:- Setup Binding
    fileprivate func setupBinding(){
        viewModel?.isLoader.addObserver(fireNow: true, {[weak self](val) in
            if val {
                self?.loader_view.startAnimating()
            }else{
                self?.loader_view.stopAnimating()
            }
        })
        self.setUpTableViewCell()
        viewModel?.news.addObserver({ [weak self](_) in
            DispatchQueue.main.async {
                self?.tableview_news?.reloadData()
                if self?.viewModel?.news.value.count ?? 0 > 0{
                    self?.tableview_news.alpha = 1
                }
            }
        })
    }
    
}

extension NewsListViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return viewModel?.news.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let dataSource = viewModel?.news.value, dataSource.count > 0 {
            let dataSourceModel = dataSource[indexPath.row]
            return dataSourceModel.cellForTableView(tableView: tableView, atIndexPath: indexPath)
        }
        return UITableViewCell()
    }
}

extension NewsListViewController: UITableViewDelegate{
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let dataSource = viewModel?.news.value, dataSource.count > 0 {
            let dataSourceModel = dataSource[indexPath.row]
            return dataSourceModel.getheightOfCell(tableViewWidth: tableView.frame.width) 

        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let dataSource = viewModel?.news.value, dataSource.count > 0 {
            let dataSourceModel = dataSource[indexPath.row]
            if let dataSource = dataSourceModel as? NewsListImageViewModel{
               self.delegate?.openNewsDetailScreen(dataSource.newsModel)
            }
        }
            
    }

}

