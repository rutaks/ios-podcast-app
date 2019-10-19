//
//  File.swift
//  Apple Podcast Clone
//
//  Created by Awesome Mac on 19/10/2019.
//  Copyright © 2019 Rutaks. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    let URL = "https://itunes.apple.com/search"
    
    static let shared = APIService()
    
    func fetchPodcasts(searchText: String, completionHandler: @escaping ([Podcast]) -> ()) {
        let params = ["term" : searchText, "media" : "podcast"]
        
        AF.request(URL,method: .get, parameters: params, encoding: URLEncoding.default, headers: nil).responseData { (resp) in
            if let err = resp.error {
                print("Failure", err)
                return
            }
            
            guard let data = resp.data else { return }
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
                completionHandler(searchResult.results)
            } catch let err {
                print("Failed To Decode:", err)
            }
        }
    }
}
