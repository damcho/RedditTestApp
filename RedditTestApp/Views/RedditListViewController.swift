//
//  MasterViewController.swift
//  RedditTestApp
//
//  Created by Damian Modernell on 20/03/2019.
//  Copyright © 2019 Damian Modernell. All rights reserved.
//

import UIKit

class RedditListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    var detailViewController: RedditDetailViewController? = nil
    let viewModel = RedditListViewModel()
    var queryObj = RedditQueryObject()
    
    @IBOutlet weak var redditsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupViewModel()
        self.refreshReddits()
    }
    
    func setupView() {
        self.redditsTableView.refreshControl = UIRefreshControl()
        self.redditsTableView.refreshControl?.addTarget(self, action: #selector(refreshReddits), for: .valueChanged)
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? RedditDetailViewController
            detailViewController?.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
            detailViewController?.navigationItem.leftItemsSupplementBackButton = true
        }
    }
    
    @IBAction func dismissAllButtonTapped(_ sender: Any) {
        self.viewModel.removeAllReddits()
    }
    
    @objc func refreshReddits() {
        self.queryObj.after = nil
        viewModel.getTopReddits(queryObj:queryObj )
    }
    
    func setupViewModel() {
        viewModel.redditsFetchedWithSuccess = {[weak self] () -> () in
            self?.redditsTableView.reloadData()
            self?.redditsTableView.refreshControl?.endRefreshing()
        }
        
        viewModel.redditsFetchedWithFailed = { [weak self] ( error:RedditApiError ) -> () in
            self?.showAlertView(msg: error.localizedDescription)
        }
        
        viewModel.redditRemovedAtIndex = { [weak self] (index) -> () in
            self?.redditsTableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .left)
        }
    }
    
    // MARK: - Table View
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row >= self.viewModel.redditsCount() - 1{
                viewModel.getTopReddits(queryObj:queryObj )
                return
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.redditsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let redditCell = tableView.dequeueReusableCell(withIdentifier: "redditcell", for: indexPath) as! RedditTableViewCell
        redditCell.viewModel = self.viewModel.getRedditCellViewModelAt(index: indexPath.row)
        return redditCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.detailViewController != nil {
            guard let celLViewModel = self.viewModel.getRedditCellViewModelAt(index: indexPath.row) else {
                return
            }
            
            detailViewController?.viewModel = RedditDetailViewModel(redditModel:celLViewModel.redditModel!)
            let detailNavigationController = detailViewController?.navigationController
            
            splitViewController?.showDetailViewController(detailNavigationController!, sender: nil)
        }
    }
    
}

