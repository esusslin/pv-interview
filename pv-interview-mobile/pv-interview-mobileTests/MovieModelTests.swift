//
//  MovieModelTests.swift
//  pv-interview-mobile
//
//  Created by Levi Flippo on 6/29/17.
//  Copyright © 2017 Levi Flippo. All rights reserved.
//

import XCTest
@testable import pv_interview_mobile

class MovieModelTests: XCTestCase {
    var movie: MovieModel?
    
    override func setUp() {
        super.setUp()
        movie = MovieModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testCanAssignMovieModelTitle() {
        movie!.title = "title"
        XCTAssertEqual(movie!.title, "title")
    }
    
    func testCanAssignMovieModelReleaseDate() {
        movie!.release_date = "Jan 1991"
        XCTAssertEqual(movie!.release_date, "Jan 1991")
    }
    
}
