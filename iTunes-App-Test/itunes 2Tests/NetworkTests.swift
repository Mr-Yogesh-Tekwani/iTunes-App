//
//  NetworkTests.swift
//  itunes 2Tests
//
//  Created by Yogesh on 7/7/23.
//

import Foundation
import XCTest
@testable import itunes_2

class NetworkTests: XCTestCase {
    
    func testApiCall() throws{
        let networkClient = NetworkClient(network: MockNetwork())
        
        let callCompletedSignal = expectation(description: "testCallApi")
        
        var result : ResultsModel? = nil
        
        networkClient.requestData(searchTerm: "Taylor", completionHandler: {data in
            result = data
            callCompletedSignal.fulfill()
        })
        
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(result)
        
        let resArray = try XCTUnwrap(result?.results)
        XCTAssertEqual(resArray[0].artistName, "Molly Black" )
        
    }
    
}
