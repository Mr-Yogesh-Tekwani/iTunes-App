//
//  iTunesNetwokLayer.swift
//  iTunes App 1
//
//  Created by Yogesh Tekwani on 5/25/23.
//

import Foundation
import UIKit
func requestData(searchTerm: String,completionHandler: @escaping (ResultsModel?) -> ()) {
    let searchTerm = searchTerm.replacingOccurrences(of: " " , with: "+")
    let url = URL(string: "https://itunes.apple.com/search?term=\(searchTerm)")
    
    guard let url = url else {
        print("Incorrect URL")
        return
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    URLSession.shared.dataTask(with: request) {(data, _ , error) in
        if let error = error {
            print(error)
            completionHandler(nil)
        }
        
        if let data = data {
            let decoder = JSONDecoder()
            do{
                let artistData = try decoder.decode(ResultsModel.self, from: data)
                completionHandler(artistData)
            }catch{
                completionHandler(nil)
            }
        }
    }.resume()
}
func requestImage(urls: String? ,completionHandler: @escaping (UIImage?) -> ()) {
    guard let urls = urls else {
        completionHandler(nil)
        return
    }
  //URL
    let url = URL(string: urls)
    
    guard let url = url else {
        completionHandler(nil)
        print("Incorrect URL")
        return
    }
    
    //Headers
    
  //Request
    var request = URLRequest(url: url)
    
  
  //Parameters
    URLSession.shared.dataTask(with: request) {(data, httpRequestHeader, error) in
        if let error = error {
            print(error)
            completionHandler(nil)
        }
        
        if let data = data {
            let decoder = JSONDecoder()
            let image = UIImage(data: data)
            print("got image")
            completionHandler(image)
        }
    }.resume()
    
}
