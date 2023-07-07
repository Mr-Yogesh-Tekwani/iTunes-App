//
//  MockNetwork.swift
//  itunes 2Tests
//
//  Created by Yogesh on 7/7/23.
//

import Foundation
import XCTest

@testable import itunes_2

class MockNetwork: NetworkProtocol {
    
    func getData(urlReq: URLRequest, completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        guard let url = urlReq.url,
              let _ = urlReq.url?.absoluteString.contains("https://itunes.apple.com/search?term=")
        else{
            completion(nil, nil, nil)
            return
        }
        
        let bundle = Bundle(for: MockNetwork.self)
        
        if let path = bundle.path(forResource: "iTunesResults", ofType: "json") {
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
                
                completion(data, response, nil)
                
            } catch {
                completion(nil, nil, nil)
            }
        } else{
            completion(nil, nil, nil)
        }
        
    }
}
