//
//  NetworkServiceForTeams.swift
//  SportApp
//
//  Created by Fatma on 07/02/2023.
//

import Foundation

protocol APIServiceForTeams
{
    static func fetchResult(handeler: @escaping (TeamDetailsResponse?)->Void)
}


class NetworkServiceForTeams : APIServiceForTeams
{
    static func fetchResult(handeler: @escaping (TeamDetailsResponse?)->Void)
    {
        let url = URL(string: "https://apiv2.allsportsapi.com/football/?&met=Teams&teamId=&APIkey=488b4a38e00ac0ede3209ae390d9a0f67f156ceb01507f6dfc1b8276d83cc402")
        guard let myurl = url else{
            return
        }
        let request = URLRequest(url: myurl)
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request) { dataaa, response, error in
            guard let data = dataaa else{
               handeler(nil)
               return
                 }
            do{
                let re = try JSONDecoder().decode(TeamDetailsResponse.self, from: data)
                handeler(re)
                
            }catch _ {
                handeler(nil)
                
            }
        }
        task.resume()
    }

}
