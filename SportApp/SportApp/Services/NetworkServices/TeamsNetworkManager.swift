//
//  TeamsNetworkManager.swift
//  SportApp
//
//  Created by Fatma on 08/02/2023.
//

import Foundation
import Alamofire

protocol APIServiceForTeams
{
    static func fetchResult(teamURL : String, handeler: @escaping (TeamDetailsResponse?)->Void)
}

class TeamsNetworkManager : APIServiceForTeams
{
    static func fetchResult(teamURL : String, handeler: @escaping (TeamDetailsResponse?)->Void)
    {
        let request = AF.request(teamURL)
        request.responseDecodable (of: TeamDetailsResponse.self) {(olddata) in
            guard let data = olddata.value
            else{
                handeler(nil)
                return
            }
            handeler(data)
        }
    }
}
