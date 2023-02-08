//
//  TeamsViewModel.swift
//  SportApp
//
//  Created by Fatma on 07/02/2023.
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

    func getTeams()
    {
        NetworkServiceForTeams.fetchResult{result in
            self.responce = result?.result
        }
    }
}
