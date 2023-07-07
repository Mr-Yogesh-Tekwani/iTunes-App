//
//  SecondVcViewModel.swift
//  itunes 2
//
//  Created by Yogesh on 7/7/23.
//

import Foundation
import UIKit



class SecondVcViewModel {
    
    var svc : SecondViewController?
    var networkClient = NetworkClient()
    var kindDict: [String:[ResultsData]] = [:]
    var data: ResultsModel? {
        didSet{
            var kindData: [String:[ResultsData]] = [:]
            for value in data?.results ?? [] {
                if let kind = value.kind {
                    if kindData[kind] != nil {
                        kindData[kind]?.append(value)
                    }else{
                        kindData[kind] = [value]
                    }
                }
            }
            kindDict = kindData
            svc?.kindDict = kindDict
            svc?.data = data
        }
    }
    
    func makeVc() -> UIViewController {
        let vc = SecondViewController()
        vc.svcViewModel = self
        self.svc = vc
        return vc
    }
    
    func searchSong(searchTerm : String, completion: @escaping (ResultsModel?) -> ()){
        networkClient.requestData(searchTerm: searchTerm, completionHandler: { artistData in
            self.data = artistData
            completion(artistData)
        } )
    }
    
    
}
