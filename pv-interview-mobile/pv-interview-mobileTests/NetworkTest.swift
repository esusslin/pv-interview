//
//  NetworkTest.swift
//  pv-interview-mobile
//
//  Created by Levi Flippo on 6/29/17.
//  Copyright © 2017 Levi Flippo. All rights reserved.
//

import XCTest

@testable import pv_interview_mobile

class NetworkTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDoesHaveApiKey() {
        let networkManager = NetworkManager()
       // XCTAssertEqual(networkManager.apiKey, "4e5ae41d4d6af54849229c5da8960317")
    }
    
    func testGetTopRatedReturnsResponse() {
        let networkManager = NetworkManager()
        let response: String =  networkManager.getTopRated()
        print("************")
        print(response)
        XCTAssertNotNil(response)
    }
    
}
