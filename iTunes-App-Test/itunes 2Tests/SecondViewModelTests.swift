//
//  SecondViewModelTests.swift
//  itunes 2Tests
//
//  Created by Yogesh on 7/7/23.
//

import Foundation
import XCTest
@testable import itunes_2

class SecondViewModelTests: XCTestCase {

    func testInit() throws {
        let viewModel = SecondVcViewModel()
        XCTAssertNil(viewModel.svc)
        _ = try XCTUnwrap(viewModel.networkClient as NetworkClient)
        _ = try XCTUnwrap(viewModel.kindDict as [String:[ResultsData]])
        XCTAssertNil(viewModel.data)
        
    }
    
    func testMakeVc() throws {
        let viewModel = SecondVcViewModel()
        let vc = try XCTUnwrap(viewModel.makeVc() as? SecondViewController)
        XCTAssertNotNil(vc.svcViewModel)
        XCTAssertEqual(viewModel.svc, vc)
    }

}
