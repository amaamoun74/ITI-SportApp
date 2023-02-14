//
//  NetworkingTests.swift
//  SportAppTests
//
//  Created by ahmed on 14/02/2023.
//

import XCTest
@testable import SportApp
final class NetworkingTests: XCTestCase {
    
    var network : NetworkManager?
    var apiServces : ApiService?
    override func setUp(){
        network = NetworkManager()
        apiServces = NetworkManager()

       
    }
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        network = nil
    }
    
    func testFetchAllLeagues(){
    let expectation = expectation(description: "waitinng for data")
        apiServces?.getAllLeagues(endPoint: "football") { league,error  in
        guard let league = league else{
            XCTFail()
            expectation.fulfill()
            return
        }
        XCTAssertNotNil(league)
            XCTAssertNotEqual(league.result?.count, 0, "API failed")
        expectation.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
}
    
    func testbasketballFetchAllLeagues(){
    let expectation = expectation(description: "waitinng for data")
        apiServces?.getAllLeagues(endPoint: "basketball") { league,error  in
        guard let league = league else{
            XCTFail()
            expectation.fulfill()
            return
        }
        XCTAssertNotNil(league)
            XCTAssertNotEqual(league.result?.count, 0, "API failed")
        expectation.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
}
    func testTennisFetchAllLeagues(){
    let expectation = expectation(description: "waitinng for data")
        apiServces?.getAllLeagues(endPoint: "tennis") { league,error  in
        guard let league = league else{
            XCTFail()
            expectation.fulfill()
            return
        }
        XCTAssertNotNil(league)
            XCTAssertNotEqual(league.result?.count, 0, "API failed")
        expectation.fulfill()
    }
    waitForExpectations(timeout: 12, handler: nil)
}
 
    func testCrickitFetchAllLeagues(){
    let expectation = expectation(description: "waitinng for data")
        apiServces?.getAllLeagues(endPoint: "cricket") { league,error  in
        guard let league = league else{
            XCTFail()
            expectation.fulfill()
            return
        }
        XCTAssertNotNil(league)
            XCTAssertNotEqual(league.result?.count, 0, "API failed")
        expectation.fulfill()
    }
    waitForExpectations(timeout: 5, handler: nil)
}
 
    func testFetchFootballTeams() {
              let expectaion = expectation(description: "Waiting for the API to get ")
              TeamsNetworkManager.fetchResult(teamURL: "https://apiv2.allsportsapi.com/football/?met=Teams&?met=Leagues&leagueId=205&APIkey=488b4a38e00ac0ede3209ae390d9a0f67f156ceb01507f6dfc1b8276d83cc402"){ result in
                  
                  guard let result = result else{
                      XCTFail()
                      expectaion.fulfill()
                      return
                  }
                  XCTAssertNotEqual(result.result?.count, 0, "API Failed")
                  expectaion.fulfill()
              }
              waitForExpectations(timeout: 12 , handler: nil)
          }
    
    func testFetchBasktballTeams() {
              let expectaion = expectation(description: "Waiting for the API to get ")
              TeamsNetworkManager.fetchResult(teamURL: "https://apiv2.allsportsapi.com/basketball/?met=Teams&?met=Leagues&leagueId=892&APIkey=488b4a38e00ac0ede3209ae390d9a0f67f156ceb01507f6dfc1b8276d83cc402"){ result in
                  
                  guard let result = result else{
                      XCTFail()
                      expectaion.fulfill()
                      return
                  }
                  XCTAssertNotEqual(result.result?.count, 0, "API Failed")
                  expectaion.fulfill()
              }
              waitForExpectations(timeout: 12 , handler: nil)
          }
    
    func testFetchEvent() {
              let expectaion = expectation(description: "Waiting for the API to get ")
        EventsNetworkManager.fetchResult(eventURL: "https://apiv2.allsportsapi.com/football/?met=met=Fixtures&leagueId=3&from=2023-01-18&to=2024-01-25&APIkey=488b4a38e00ac0ede3209ae390d9a0f67f156ceb01507f6dfc1b8276d83cc402"){ result in
                  
                  guard let result = result else{
                      XCTAssertNil(result)

                      expectaion.fulfill()
                      return
                  }
                  XCTAssertNotEqual(result.result?.count, 0, "API Failed")
                  expectaion.fulfill()
              }
              waitForExpectations(timeout: 12 , handler: nil)
          }
}
