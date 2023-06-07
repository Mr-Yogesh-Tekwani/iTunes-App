//
//  SecondViewControllerViewModel.swift
//  itunes 2
//
//  Created by Sahil Mirchandani on 6/7/23.
//

import Foundation
import UIKit

class SecondViewControllerViewModel{
    
    func makeView() -> SecondViewController {
        let viewController = SecondViewController(secondViewModel: self)
        return viewController
    }
    
    init(searchTerm: String){
        self.searchTerm = searchTerm
        fetchData()
    }
    
    var searchTerm: String?
    var kindDict: [String:[ResultsData]] = [:]
    
    var data: ResultsModel? {
        didSet{
            makeCategoryData()
        }
    }
    
    func makeCategoryData(){
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
    }
    
    func fetchData(){
        if let searchTerm = searchTerm {
            requestData(searchTerm: searchTerm, completionHandler: { artistData in
                self.data = artistData
                
            } )
        }
    }
    
    func getHeadingCount() -> Int {
        return kindDict.keys.count
    }
    
    func getHeadingData(section: Int) -> String {
        return kindDict.keys.sorted()[section]
    }
    
    func getRowCount(section: Int) -> Int{
        let key = kindDict.keys.sorted()[section]
        return kindDict[key]!.count
    }
    
    
    func getRowData(rownumber: Int, section: Int) -> ResultsData {
        let key = kindDict.keys.sorted()[section]
        let resultData = kindDict[key]
        return resultData![rownumber]
    }
    
    
    
    
}
