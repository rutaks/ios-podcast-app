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
    
    
    
    let podcasts = [
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    //MARK:-Table View Setup
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let podcast = podcasts[indexPath.row]
        
        cell.textLabel?.numberOfLines = -1
        cell.textLabel?.text = "\(podcast.trackName)\n\(podcast.artistName)"
        cell.imageView?.image = UIImage(named: "appicon")
        
        return cell
    }
    
    //MARK:-API Search Implementation
    //TODO: Implement Api Request On Text Change
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let URL = "https://itunes.apple.com/search?term=\(searchText)"
        
        AF.request(URL).responseData { (resp) in
            if let err = resp.error {
                print("Failure")
                return
            }
            
            guard let data = resp.data else { return }
            let du = String(data: data, encoding: .utf8)
            print(du ?? "")
        }
        
        print(searchText)
    }
    
}
