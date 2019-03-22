//
//  RedditTableViewCell.swift
//  RedditTestApp
//
//  Created by Damian Modernell on 22/03/2019.
//  Copyright © 2019 Damian Modernell. All rights reserved.
//

import UIKit

class RedditTableViewCell: UITableViewCell {

    @IBOutlet weak var numberOfCommentsLabel: UILabel!
    @IBOutlet weak var dismissRedditButton: UIButton!
    @IBOutlet weak var redditThumbImageView: UIImageView!
    @IBOutlet weak var redditAuthorNameLabel: UILabel!
    @IBOutlet weak var redditTitleLabel: UILabel!
    
    var viewModel:RedditCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
