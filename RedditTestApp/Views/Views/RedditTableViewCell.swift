//
//  RedditTableViewCell.swift
//  RedditTestApp
//
//  Created by Damian Modernell on 22/03/2019.
//  Copyright © 2019 Damian Modernell. All rights reserved.
//

import UIKit

class RedditTableViewCell: UITableViewCell {

    @IBOutlet weak var unreadStatusView: UIView!
    @IBOutlet weak var numberOfCommentsLabel: UILabel!
    @IBOutlet weak var dismissRedditButton: UIButton!
    @IBOutlet weak var redditThumbImageView: UIImageView!
    @IBOutlet weak var redditAuthorNameLabel: UILabel!
    @IBOutlet weak var redditTitleLabel: UILabel!
    
    var viewModel:RedditCellViewModel? {
        didSet {
            redditTitleLabel.text = viewModel?.title
            redditAuthorNameLabel.text = viewModel?.author
            redditThumbImageView.image =  viewModel?.getImage(handler: { [weak self] (image) -> ()  in
                self?.redditThumbImageView.image = image
            })
            numberOfCommentsLabel.text = viewModel?.comments
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.unreadStatusView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        unreadStatusView.backgroundColor = viewModel?.readState == false ? UIColor.blue : UIColor.clear

        if selected {
            viewModel?.readState = true
        }

        // Configure the view for the selected state
    }

}
