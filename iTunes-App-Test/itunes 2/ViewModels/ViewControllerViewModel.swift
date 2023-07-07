//
//  ViewControllerViewModel.swift
//  itunes 2
//
//  Created by Yogesh on 7/7/23.
//

import Foundation
import UIKit

class ViewControllerViewModel {
    
    weak var viewController : ViewController?
    var favData: [ResultsData] = []
    var networkClient = NetworkClient()
    
    func makeVc() -> UIViewController {
        let vc = ViewController()
        self.viewController = vc
        vc.viewModel = self
        return vc
    }
    
    
}
