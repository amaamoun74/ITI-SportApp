//
//  LatestResultsViewModel.swift
//  SportApp
//
//  Created by Fatma on 07/02/2023.
//

import Foundation

class LatestResultsViewModel
{
    var bindResultToLatestResults : (() -> ()) = {}

    var responce : [Event]!    {
        didSet {
            bindResultToLatestResults()
        }
    }

    func getLatestResults()
    {
        NetworkServiceForEvent.fetchResult(eventURL: "https://apiv2.allsportsapi.com/football?met=Fixtures&leagueId=205&from=2023-01-18&to=2024-01-18&APIkey=488b4a38e00ac0ede3209ae390d9a0f67f156ceb01507f6dfc1b8276d83cc402"){result in
            self.responce = result?.result
        }
    }
}
