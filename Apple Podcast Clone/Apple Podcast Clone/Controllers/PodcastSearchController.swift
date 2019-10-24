//
//  PodcastSearchController.swift
//  Apple Podcast Clone
//
//  Created by Awesome Mac on 19/10/2019.
//  Copyright © 2019 Rutaks. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD

class PodcastSearchController: UITableViewController, UISearchBarDelegate {
    
    var podcasts = [Podcast]()
    var isSearching: Bool = false
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
        tableView.tableFooterView = UIView()
        let nib = UINib(nibName: "PodcastCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
    }
    
    //MARK:-Table View Setup
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if(!isSearching){
            let label = UILabel()
            label.text = "Please Enter A Search Term"
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
            return label
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return isSearching ? 0 : 250
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! PodcastCell
        let podcast = podcasts[indexPath.row]
        cell.podcast = podcast
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    
    //MARK:-API Search Implementation
    //TODO: Implement Api Request On Text Change
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count != 0 {
            isSearching = false
            SVProgressHUD.show()
        }
        APIService.shared.fetchPodcasts(searchText: searchText) { (podcasts) in
            self.isSearching=true
            self.podcasts = podcasts
            self.tableView.reloadData()
            SVProgressHUD.dismiss()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        SVProgressHUD.dismiss()
    }
    
}
