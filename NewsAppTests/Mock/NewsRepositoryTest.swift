//
//  NewsRepositoryTest.swift
//  NewsAppTests
//
//  Created by Miraah on 01/02/21.
//  Copyright © 2021 Self. All rights reserved.
//

import XCTest
@testable import NewsApp

class NetworkRepositoryImplTests: XCTestCase {
    
    var mockURLSession: MockURLSession!
    var sut: NetworkRepositoryImpl!
    
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        sut = NetworkRepositoryImpl(urlSession: mockURLSession)
    }
    
    override func tearDown() {
        mockURLSession = nil
        sut = nil
        super.tearDown()
    }
    
    func test_fetchData_calls_completionWithSuccessResult_whenDataIsReturnedFromSession() {
        // GIVEN
        let mockURL = URL(string: "https://cn-news-info-api.herokuapp.com/likes/_")!
        let expectation = self.expectation(description: #function)
        sut.fetchRequest(mockURL) { result in
            // THEN (Partly defined before WHEN because of asynchronous nature of test)
            switch result {
            case .success(let data):
                XCTAssertEqual(data, Data())
            case .failure(let error):
                XCTFail("Unexpected failure with error: \(error)")
            }
            expectation.fulfill()
        }
        
        // WHEN
        mockURLSession.capturedCompletion?(Data(), nil, nil)
        
        // THEN (continued)
        waitForExpectations(timeout: 1, handler: nil)
    }
}
