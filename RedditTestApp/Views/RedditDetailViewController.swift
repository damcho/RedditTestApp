//
//  DetailViewController.swift
//  RedditTestApp
//
//  Created by Damian Modernell on 20/03/2019.
//  Copyright © 2019 Damian Modernell. All rights reserved.
//

import UIKit

class RedditDetailViewController: UIViewController {

    @IBOutlet weak var redditAuthorLabel: UILabel!
    @IBOutlet weak var redditThumbImageView: UIImageView!
    @IBOutlet weak var redditTitleLabel: UILabel!
    var viewModel:RedditDetailViewModel? {
        didSet {
            if redditTitleLabel != nil {
                redditTitleLabel.text = viewModel?.title
            }
        }
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
        redditTitleLabel.text = viewModel?.title

    }


   
}

