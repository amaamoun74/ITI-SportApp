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
    override func setUp(){
        network = NetworkManager()
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
    
  /*  func testNetworkCall(){
        let expectation = expectation(description: "API Call")
        self.network?.getAllLeagues(endPoint: "football") { leaguesResult, error in
            if let leagues = self.leaguesResult {
                XCTAssertNotEqual(leagues.result?.count , 0 , "API Error")
                expectation.fulfill()
                
            }
            else if let error = self.error {
                XCTAssertNotNil(error)
            }
            else
            {
                XCTFail("Empty data reponse")
                expectation.fulfill()
            }
            waitForExpectations(timeout: 8) { error in
                print(error ?? "error")
            }
        }
    }*/
}
