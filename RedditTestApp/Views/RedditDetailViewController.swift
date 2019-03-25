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
            self.setupDetaiView()
        }
    }
    
    func setupDetaiView() {
        if redditTitleLabel != nil {
            redditTitleLabel.text = viewModel?.title
            redditAuthorLabel.text = viewModel?.author
        }
        self.viewModel?.getImage(handler: {[weak self] (image) in
            self?.redditThumbImageView.image = image
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        super.viewWillAppear(animated)
    }
}

