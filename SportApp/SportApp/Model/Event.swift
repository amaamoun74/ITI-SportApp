//
//  Event.swift
//  SportApp
//
//  Created by ahmed on 03/02/2023.
//

import Foundation
class Event: Codable {
    var event_key :Double?
    var event_date:String?
    var event_time:String?
    var event_home_team:String?
    var home_team_key:Double?
    var event_away_team:String?
    var away_team_key:Double?
    var event_halftime_result:String?
    var event_final_result:String?
    var event_ft_result:String?
    var event_penalty_result:String?
    var event_status:String?
    var country_name:String?
    var league_name:String?
    var league_key:Double?
    var league_round:String?
    var league_season:String?
    var event_live:String?
    var event_stadium:String?
    var event_referee:String?
    var home_team_logo:String?
    var away_team_logo:String?
    var event_country_key:Int?
    var league_logo:String?
    var country_logo:String?
    var event_home_formation:String?
    var event_away_formation:String?
    var fk_stage_key:Double?
    var stage_name:String?
    var league_group: String?
    var event_endPoint: String?
    
    var event_first_player : String?
    var event_second_player : String?
    var event_first_player_logo : String?
    var event_second_player_logo : String?
    
}
