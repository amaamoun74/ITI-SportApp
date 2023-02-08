//
//  NetworkServiceForEvent.swift
//  SportApp
//
//  Created by Fatma on 07/02/2023.
//

import Foundation

protocol APIServiceForEvent
{
    static func fetchResult(eventURL : String, handeler: @escaping (EventResponse?)->Void)
}


class NetworkServiceForEvent : APIServiceForEvent
{
    static func fetchResult(eventURL : String, handeler: @escaping (EventResponse?)->Void)
    {
        let url = URL(string: eventURL)
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
                let re = try JSONDecoder().decode(EventResponse.self, from: data)
                handeler(re)
                
            }catch _ {
                handeler(nil)
                
            }
        }
        task.resume()
    }

}
