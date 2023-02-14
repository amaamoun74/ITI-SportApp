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
    }
}
    
        
    
