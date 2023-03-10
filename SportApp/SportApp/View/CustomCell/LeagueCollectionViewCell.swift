//
//  LeagueCollectionViewCell.swift
//  SportApp
//
//  Created by Fatma on 04/02/2023.
//

import UIKit

class LeagueCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var teamImage: UIImageView!
        
    @IBOutlet weak var upcomingEventFirstTeam: UILabel!
    
    @IBOutlet weak var upcomingEventSecondTeam: UILabel!
    
    @IBOutlet weak var upcomingEventDate: UILabel!
    
    @IBOutlet weak var upcomingEventTime: UILabel!
    
    @IBOutlet weak var upcomingVs: UILabel!
    
    @IBOutlet weak var latestResultsFirstTeam: UILabel!
    
    @IBOutlet weak var latestResultsSecondTeam: UILabel!
    
    @IBOutlet weak var latestResultsResult: UILabel!
    
    @IBOutlet weak var latestResultsDate: UILabel!
    
    @IBOutlet weak var latestResultsTime: UILabel!
    
    @IBOutlet weak var latestResultHomeTeamImage: UIImageView!
    
    @IBOutlet weak var latestResultAwayTeamImage: UIImageView!
    
    @IBOutlet weak var upcomingEventHomeTeamImage: UIImageView!
    
    @IBOutlet weak var upcomingEventAwayTeamImage: UIImageView!
}
