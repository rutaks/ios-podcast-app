//
//  PodcastCell.swift
//  Apple Podcast Clone
//
//  Created by Awesome Mac on 19/10/2019.
//  Copyright © 2019 Rutaks. All rights reserved.
//

import Foundation
import UIKit

class PodcastCell: UITableViewCell {
    
    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var episodeCountLabel: UILabel!
    
    var podcast: Podcast! {
        didSet {
            trackNameLabel.text = podcast.trackName
            artistName.text = podcast.artistName
        }
    }
}
