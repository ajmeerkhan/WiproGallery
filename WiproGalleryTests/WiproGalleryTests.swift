//
//  WiproGalleryTests.swift
//  WiproGalleryTests
//
//  Created by Ajmeer khan on 31/05/19.
//  Copyright © 2019 Wirpo. All rights reserved.
//

import XCTest
@testable import WiproGallery

class WiproGalleryTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNetworkLayer () {
        let result = expectation(description: "NetworkLayer is Perfect")
        
        if let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"){
            NetworkApi().callApi(url: url) { (data, error) in
                XCTAssertNil(error)
                XCTAssertNotNil(data, "Data Found")
                result.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10.0) { (error) in
            XCTAssertNil(error, "Time Out")
        }
    }
}
