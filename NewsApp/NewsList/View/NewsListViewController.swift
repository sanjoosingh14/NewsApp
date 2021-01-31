//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by Miraah on 30/01/21.
//  Copyright © 2021 Self. All rights reserved.
//

import UIKit

class NewsListViewController: UIViewController {
    var viewModel = NewsListViewModel()
    
    @IBOutlet weak var tableview_news: UITableView!
    @IBOutlet weak var loader_view: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "US Top Headlines"
        loader_view.alpha = 1
        loader_view.startAnimating()
        self.view.bringSubviewToFront(loader_view)

        self.setUpTableViewCell()
        self.startBinding()
        viewModel.fetchNewsFromApi()
    }
    
    //MARK:- Setup Views
    private func setUpTableViewCell(){
        tableview_news.delegate = self
        tableview_news.dataSource = self
        tableview_news.register(NewsListImageViewTableViewCell.self, forCellReuseIdentifier: String(describing: NewsListImageViewTableViewCell.self))
        self.tableview_news.alpha = 0
    }
    
    func startBinding() {
        viewModel.newsDataSource.addObserver({ [weak self] _ in
            self?.tableview_news?.reloadData()
            if self?.viewModel.newsDataSource.value?.count ?? 0 > 0{
                self?.tableview_news.alpha = 1
                self?.loader_view.alpha = 0
                self?.loader_view.stopAnimating()
            }
        })
    }
}

extension NewsListViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return viewModel.newsDataSource.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let dataSource = viewModel.newsDataSource.value, dataSource.count > 0 {
            let dataSourceModel = dataSource[indexPath.row]
            return dataSourceModel.cellForTableView(tableView: tableView, atIndexPath: indexPath, actionDelegate: self) 
        }
        return UITableViewCell()
    }
}

extension NewsListViewController: UITableViewDelegate{
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let dataSource = viewModel.newsDataSource.value, dataSource.count > 0 {
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

extension NewsListViewController: cellActionDelegate {
    func clickAction(with type: clickEventType, and newsData: News?) {
        print(type)
        if let news = newsData{
            if let newDetailVC: NewsDetialViewController =
                self.storyboard?.instantiateViewController(withIdentifier: "NewsDetialViewController") as? NewsDetialViewController {
            let viewmodel = NewsDetailViewModel.init(with: news)
            newDetailVC.viewModel = viewmodel
            self.navigationController?.pushViewController(newDetailVC, animated: true)
            }
        }
        
    }
}
