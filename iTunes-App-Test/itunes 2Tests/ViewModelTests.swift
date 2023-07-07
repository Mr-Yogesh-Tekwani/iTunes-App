//
//  ViewModelTests.swift
//  itunes 2Tests
//
//  Created by Yogesh on 7/7/23.
//

import Foundation
import XCTest
@testable import itunes_2

class ViewModelTests: XCTestCase {
    
    func testInit() throws {
        let vc = ViewControllerViewModel()
        XCTAssertNil(vc.viewController)
        _ = try XCTUnwrap(vc.favData as? [ResultsModel])
        _ = try XCTUnwrap((vc.networkClient as NetworkClient))
    }
    
    
    func testMakeVc() throws {
        let viewModel = ViewControllerViewModel()
        let vc = try XCTUnwrap(viewModel.makeVc() as? ViewController)
        XCTAssertNotNil(vc.viewModel)
        XCTAssertEqual(viewModel.viewController, vc)
    }
    
}
