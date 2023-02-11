//
//  EventsViewModel.swift
//  SportApp
//
//  Created by Fatma on 08/02/2023.
//

import Foundation

class EventsViewModel
{
    var bindResultToEvents : (() -> ()) = {}

    var responce : [Event]!    {
        didSet {
            bindResultToEvents()
        }
    }

    func getEvents(startDate : String , endDate : String)
    {
        EventsNetworkManager.fetchResult(eventURL: "https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId=205&from=\(startDate)&to=\(endDate)&APIkey=488b4a38e00ac0ede3209ae390d9a0f67f156ceb01507f6dfc1b8276d83cc402"){result in
            self.responce = result?.result
        }
    }
}
