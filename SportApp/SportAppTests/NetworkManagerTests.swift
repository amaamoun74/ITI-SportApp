//
//  NetworkManagerTests.swift
//  SportAppTests
//
//  Created by Fatma on 14/02/2023.
//

import XCTest
@testable import SportApp

final class NetworkManagerTests: XCTestCase {
    
   // let networkService: NetworkServices = NetworkServices()

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

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
 
 /*   func testFetchAllLeagues(){
          let expectaion = expectation(description: "Waiting for the API to get Leagues List")
          NetworkManager.getAllLeagues(endPoint: <#T##String#>, completion: <#T##(JsonResponse<League>?, Error?) -> Void#>){ leagues in
              guard let result = leagues else {
                  XCTFail()
                  expectaion.fulfill()
                  return
              }
              XCTAssertNotEqual(result.result?.count, 0, "API Failed")
              expectaion.fulfill()
          }
          waitForExpectations(timeout: 3 , handler: nil)
      }
      
      func testFetchUpcomingEvents(){
          let expectaion = expectation(description: "Waiting for the API to get Upcoming Events")
          NetworkServices.fetchUpcomingEventsData(sportName: "football", leagueID:4) { result in
              guard let result = result else{
                  XCTFail()
                  expectaion.fulfill()
                  return
              }
              XCTAssertNotEqual(result.result?.count, 0, "API Failed")
              expectaion.fulfill()
          }
          waitForExpectations(timeout: 3 , handler: nil)
          
      }
      func testFetchLatestResults(){
          let expectaion = expectation(description: "Waiting for the API to get Latest Events")
          NetworkServices.fetchLatestResultsData(sportName: "football", leagueID:4) { result in
              guard let result = result else{
                  XCTFail()
                  expectaion.fulfill()
                  return
              }
              XCTAssertNotEqual(result.result?.count, 0, "API Failed")
              expectaion.fulfill()
          }
          waitForExpectations(timeout: 3 , handler: nil)
      }*/
      
      func testFetchTeams() {
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
          waitForExpectations(timeout: 3 , handler: nil)
      }
}
