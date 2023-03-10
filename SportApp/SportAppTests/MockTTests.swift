//
//  MockTTests.swift
//  SportAppTests
//
//  Created by ahmed on 13/02/2023.
//

import XCTest
@testable import SportApp
final class MockTTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }


    func testJsonMock() {
        Mocking.sharedInstance.fetchJsonData { result, error in
            guard let league = result else {
                XCTAssertNil(result)
                return
            }
            XCTAssertNotNil(league , "API Error")
        }
    }
    
    func testLeagueMock(){
        Mocking.sharedInstance.fetchLeagueData { result, error in
            guard let league = result else {
                XCTAssertNil(result)
                return
            }
            XCTAssertNotNil(league , "API Error")
        }
    }
    
    func testEventMock(){
        Mocking.sharedInstance.fetchEventData{ result, error in
            guard let league = result else {
                XCTAssertNil(result)
                return
            }
            XCTAssertNotNil(league , "API Error")
        }
    }
    
    func testTeamMock(){
        Mocking.sharedInstance.fetchTeamData { result, error in
            guard let league = result else {
                XCTAssertNil(result)
                return
            }
            XCTAssertNotNil(league , "API Error")
        }
    }
    
    func testPlayerMock(){
        Mocking.sharedInstance.fetchPlayerData { result, error in
            guard let league = result else {
                XCTAssertNil(result)
                return
            }
            XCTAssertNotNil(league , "API Error")
        }
    }
    
    func testCoachMock(){
        Mocking.sharedInstance.fetchCoachData { result, error in
            guard let league = result else {
                XCTAssertNil(result)
                return
            }
            XCTAssertNotNil(league , "API Error")
        }
    }
}
