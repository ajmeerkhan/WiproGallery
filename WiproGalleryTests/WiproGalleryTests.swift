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
    
    private var rootWindow: UIWindow!
    var viewController :ViewController!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        rootWindow = UIWindow(frame: UIScreen.main.bounds)
        viewController = ViewController()
        UIApplication.shared.keyWindow?.rootViewController = viewController
        viewController.viewWillAppear(false)
        viewController.viewDidAppear(false)
        
        XCTAssertNotNil(viewController.view)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNetworkLayer () {
        let result = expectation(description: "NetworkLayer is Perfect")
        
        if let url = URL(string: "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"){
            NetworkApi().fetchGallery(url: url) { (data, error) in
                XCTAssertNil(error)
                XCTAssertNotNil(data, "Data Found")
                result.fulfill()
            }
        }
        
        waitForExpectations(timeout: 10.0) { (error) in
            XCTAssertNil(error, "Time Out")
        }
    }
    
    func testCollectionViewInViewController () {
        
        let row :Row = Row.init(title: "row1", description: "rowdesc1", imageHref: "imagurl")
        let row1 :Row = Row.init(title: "row1", description: "rowdesc1", imageHref: "imagurl")
        let row2 :Row = Row.init(title: "row1", description: "rowdesc1", imageHref: "imagurl")

        let rows = [row,row1,row2]
        viewController.galleryContent = rows
        
        viewController.collectionView.reloadData()
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.5))
        
        let cells = viewController.collectionView.visibleCells as! [GalleryCell]
        XCTAssertEqual(cells.count, rows.count, "Cells count should match rows.count")
        
        for index in 0...cells.count - 1 {
            let cell = cells[index]
            XCTAssertEqual(cell.headerLabel.text, rows[index].title, "Title should be matching")
        }
    }
}
