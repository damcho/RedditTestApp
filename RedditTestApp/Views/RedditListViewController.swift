//
//  MasterViewController.swift
//  RedditTestApp
//
//  Created by Damian Modernell on 20/03/2019.
//  Copyright © 2019 Damian Modernell. All rights reserved.
//

import UIKit

class RedditListViewController: UITableViewController {

    var detailViewController: RedditDetailViewController? = nil
    let viewModel = RedditListViewModel()

    @IBOutlet var redditListTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViewModel()
        viewModel.getTopReddits(queryObj: RedditQueryObject())

        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? RedditDetailViewController
        }
    }
    
    func setupViewModel() {
        let completionSuccess = { (reddits:RedditsContainer? ) -> () in
     //       print(reddits)
            self.redditListTableView.reloadData()
        }
        
        viewModel.redditsFetchedWithSuccess = completionSuccess
        let completionFailure = { ( error:RedditApiError? ) -> () in
            print(error?.localizedDescription)
        }
        viewModel.redditsFetchedWithFailed = completionFailure
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }


    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = (segue.destination as! UINavigationController).topViewController as! RedditDetailViewController
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.redditsCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let redditCell = tableView.dequeueReusableCell(withIdentifier: "redditcell", for: indexPath) as! RedditTableViewCell
        redditCell.viewModel = self.viewModel.getRedditCellViewModelAt(index: indexPath.row)
        return redditCell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

