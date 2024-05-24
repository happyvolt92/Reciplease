//
//  RecipleaseTests.swift
//  RecipleaseTests
//
//    Created by elodie gage on 15/02/2024.
//    
//

import XCTest
@testable import Reciplease

class RecipleaseServiceTestcase: XCTestCase {

    func testGetRecipeShouldPostFailedCallbackIfError() {
        let reciplease = RecipleaseService(session: AlamofireSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        reciplease.request(from: 0, to: 1, ingredients: ["tomatoes"]) { (data, error) in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
            guard let error = error as? ErrorCases else {
                XCTAssert(false)
                return
            }
            if case ErrorCases.failure = error {
                XCTAssert(true)
            } else {
                XCTAssert(false)
            }
            expectation.fulfill()
        }
            wait(for: [expectation], timeout: 0.10)
    }
    
    func testGetRecipeShouldPostFailedCallbackIfNoData() {
        let reciplease = RecipleaseService(session: AlamofireSessionFake(data: nil, response: FakeResponseData.responseOK, error: nil))
       
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        reciplease.request(from: 0, to: 1, ingredients: ["tomatoes"]) { (data, error) in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
            guard let error = error as? ErrorCases else {
                XCTAssert(false)
                return
            }
            if case ErrorCases.noData = error {
                XCTAssert(true)
            } else {
                XCTAssert(false)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.10)
    }
    
    func testGetRecipeShouldPostFailedCallbackIncorrectResponse() {
        let reciplease = RecipleaseService(session: AlamofireSessionFake(data: FakeResponseData.recipleaseCorrectData, response: FakeResponseData.responseKO, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        reciplease.request(from: 0, to: 1, ingredients: ["tomatoes"]) { (data, error) in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
            guard let error = error as? ErrorCases else {
                XCTAssert(false)
                return
            }
            if case ErrorCases.wrongResponse(statusCode: 500) = error {
                XCTAssert(true)
            } else {
                XCTAssert(false)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.10)
    }
    
    func testGetRecipeShouldPostFailedCallbackIncorrectData() {
        let reciplease = RecipleaseService(session: AlamofireSessionFake(data: FakeResponseData.IncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        reciplease.request(from: 0, to: 1, ingredients: ["tomatoes"]) { (data, error) in
            XCTAssertNil(data)
            XCTAssertNotNil(error)
            guard let error = error as? ErrorCases else {
                XCTAssert(false)
                return
            }
            if case ErrorCases.errorDecode = error {
                XCTAssert(true)
            } else {
                XCTAssert(false)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.10)
    }
    
    func testGetRecipeShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        let reciplease = RecipleaseService(session: AlamofireSessionFake(data: FakeResponseData.recipleaseCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        
        reciplease.request(from: 0, to: 1, ingredients: ["tomatoes"]) { (data, error) in
            let label: String = "Roasted Tomatoes Recipe"
            let uri: String = "http://www.edamam.com/ontologies/edamam.owl#recipe_9ba58f5a699c07a57e377b963405639b"
            
            XCTAssertEqual(label, data?.hits[0].recipe.label)
            XCTAssertEqual(uri, data?.hits[0].recipe.uri)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.10)
    }
}
