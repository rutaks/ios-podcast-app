//
//  PodcastSearchController.swift
//  Apple Podcast Clone
//
//  Created by Awesome Mac on 19/10/2019.
//  Copyright © 2019 Rutaks. All rights reserved.
//

import UIKit
import Alamofire

class PodcastSearchController: UITableViewController, UISearchBarDelegate {
    
    var podcasts = [
        Podcast(trackName: "1", artistName: "1"),
        Podcast(trackName: "1", artistName: "1"),
        Podcast(trackName: "1", artistName: "1")
    ]
    
    let cellId = "cellId"
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
    }
    
    //MARK:-View Setups
    
    fileprivate func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    fileprivate func setupTableView() {
        let nib = UINib(nibName: "PodcastCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
    }
    
    //MARK:-Table View Setup
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PodcastCell
        let podcast = podcasts[indexPath.row]
        cell.podcast = podcast
        
//
//        cell.textLabel?.numberOfLines = -1
//        cell.textLabel?.text = "\(podcast.trackName ?? "")\n\(podcast.artistName ?? "" )"
//        cell.imageView?.image = UIImage(named: "appicon")
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    
    //MARK:-API Search Implementation
    //TODO: Implement Api Request On Text Change
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        APIService.shared.fetchPodcasts(searchText: searchText) { (podcasts) in
            self.podcasts = podcasts
            self.tableView.reloadData()
        }
    }
    
}
