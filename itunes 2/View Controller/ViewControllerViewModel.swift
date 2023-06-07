//
//  ViewControllerViewModel.swift
//  itunes 2
//
//  Created by Sahil Mirchandani on 6/7/23.
//

import UIKit

class ViewControllerViewModel {

    weak var vc: ViewController?
    func makeView() -> ViewController {
        let viewController = ViewController(viewModel: self)
        vc = viewController
        return viewController
    }

    var favData: [ResultsData] = []

    // MARK: - Table View Functions
    func getRowCount() -> Int {
        return favData.count
    }

    func getRowData(rowNumber: Int) -> ResultsData {
        return favData[rowNumber]
    }

    // MARK: SearchBar Functions
    func searchBarEndButtonTapped(searchtext: String?) -> UIViewController {
        guard let text = searchtext , text != "" else {
            let alert = UIAlertController(title: "Error",
                                          message: "Please enter a search text",
                                          preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(action)
            return alert
        }
        let svcViewModel = SecondViewControllerViewModel(searchTerm : text)
        let svc = svcViewModel.makeView()
        svc.delegate = vc
        return svc
    }
    
    // MARK: - Fav
    func markFav(data: ResultsData) {
        favData.append(data)
    }
}
