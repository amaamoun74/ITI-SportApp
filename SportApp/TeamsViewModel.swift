//
//  TeamsViewModel.swift
//  SportApp
//
//  Created by Fatma on 08/02/2023.
//

import Foundation

class TeamsViewModel
{
    var bindResultToTeamDetailsVC : (() -> ()) = {}

    var responce : [Team]!    {
        didSet {
            bindResultToTeamDetailsVC()
        }
    }
    
    func getTeams(endPoint: String, leagueId: Int )
        {
           TeamsNetworkManager.fetchResult(teamURL: "https://apiv2.allsportsapi.com/\(endPoint)/?met=Teams&?met=Leagues&leagueId=\(leagueId)&APIkey=488b4a38e00ac0ede3209ae390d9a0f67f156ceb01507f6dfc1b8276d83cc402"){result in
                self.responce = result?.result
            }
        }
}

