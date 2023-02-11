//
//  EventsNetworkManager.swift
//  SportApp
//
//  Created by Fatma on 08/02/2023.
//

import Foundation
import Alamofire

protocol APIServiceForEvent
{
    static func fetchResult(eventURL : String, handeler: @escaping (EventResponse?)->Void)
}


class EventsNetworkManager : APIServiceForEvent
{
    static func fetchResult(eventURL : String, handeler: @escaping (EventResponse?)->Void)
    {
        let request = AF.request(eventURL)
        request.responseDecodable (of: EventResponse.self) {(olddata) in
            guard let data = olddata.value
            else{
                handeler(nil)
                return
            }
            handeler(data)
        }
        
       /* let url = URL(string: eventURL)
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
        task.resume()*/
    }
}
    
        
    
