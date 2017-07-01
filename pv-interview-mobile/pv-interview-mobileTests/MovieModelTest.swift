//
//  MovieModelTest.swift
//  pv-interview-mobile
//
//  Created by Levi Flippo on 6/29/17.
//  Copyright © 2017 Levi Flippo. All rights reserved.
//

import XCTest
@testable import pv_interview_mobile

class MovieModelTest: XCTestCase {
    var movie: MovieModel?
    
    override func setUp() {
        super.setUp()
      //  movie = MovieModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func canAssignMovieModelTitle() {
        movie!.title = "title"
        XCTAssertEqual(movie!.title, "title")
    }
    
    func canAssignMovieModelReleaseDate() {
        movie!.release_date = "Jan 1991"
        XCTAssertEqual(movie!.release_date, "Jan 1991")
    }

    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
