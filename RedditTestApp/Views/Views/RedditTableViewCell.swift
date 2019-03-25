//
//  RedditTableViewCell.swift
//  RedditTestApp
//
//  Created by Damian Modernell on 22/03/2019.
//  Copyright © 2019 Damian Modernell. All rights reserved.
//

import UIKit

class RedditTableViewCell: UITableViewCell {

    @IBOutlet weak var redditPostTimeLabel: UILabel!
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
            viewModel?.getImage(handler: { [weak self] (image) -> ()  in
                self?.redditThumbImageView.image = image
            })
            numberOfCommentsLabel.text = viewModel?.comments
            unreadStatusView.backgroundColor = viewModel?.readState == false ? UIColor.blue : UIColor.clear
            redditPostTimeLabel.text = viewModel?.redditPostTime
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.redditThumbImageView.image = UIImage(named: "defaultRedditImage")
        self.unreadStatusView.layer.cornerRadius = 7.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            viewModel?.readState = true
        }
        unreadStatusView.backgroundColor = viewModel?.readState == false ? UIColor.blue : UIColor.clear
    }
    
    @IBAction func dismissCellTapped(_ sender: Any) {
        self.viewModel?.dismissCellTapped()
    }

}
