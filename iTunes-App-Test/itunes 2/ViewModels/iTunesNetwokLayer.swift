//
//  iTunesNetwokLayer.swift
//  iTunes App 1
//
//  Created by Yogesh Tekwani on 5/25/23.
//

import Foundation
import UIKit

protocol NetworkProtocol {
    func getData(urlReq: URLRequest, completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void)
}

class Network: NetworkProtocol {
    func getData(urlReq: URLRequest, completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: urlReq, completionHandler:{ data, response, error in
            completion(data, response as? HTTPURLResponse, error)
        })
        task.resume()
    }
}

class NetworkClient {
    
    var network: NetworkProtocol
    
    init(network: NetworkProtocol = Network()){
        self.network = network
    }
    
    
    func requestData(searchTerm: String,completionHandler: @escaping (ResultsModel?) -> ()) {
        let searchTerm = searchTerm.replacingOccurrences(of: " " , with: "+")
        let url = URL(string: "https://itunes.apple.com/search?term=\(searchTerm)")
        
        guard let url = url else {
            print("Incorrect URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        network.getData(urlReq: request, completion: { data, response, error in
            
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
        })
        
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
        
        
        //Request
        let request = URLRequest(url: url)
        
        
        //Parameters
        network.getData(urlReq: request, completion: {(data, httpRequestHeader, error) in
            if let error = error {
                print(error)
                completionHandler(nil)
            }
            
            if let data = data {
                let image = UIImage(data: data)
                completionHandler(image)
            }
        })
        
    }
}
