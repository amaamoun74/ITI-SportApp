//
//  Mocking.swift
//  SportApp
//
//  Created by ahmed on 13/02/2023.
//

import Foundation
class Mocking {
    static let sharedInstance = Mocking()
    let mockResponse = "{\"success\": 1,\"result\":[]}"
    let mockLeague = "{\"league_key\": \"205\",\"league_name\": \"Coppa Italia\",\"country_key\": \"5\",\"country_name\": \"Italy\",\"league_logo\": \"https://apiv2.allsportsapi.com/logo/logo_leagues/205_coppa-italia.png\",\"country_logo\": \"https://apiv2.allsportsapi.com/logo/logo_country/5_italy.png\"}"
    
    let mockEvent = "{\"event_key\": \"59409\",\"event_date\": \"2021-05-18\",\"event_time\": \"20:30\",\"event_home_team\": \"Lazio\",\"home_team_key\": \"93\",\"event_away_team\": \"Torino\",\"away_team_key\": \"4973\",\"event_halftime_result\": \"0 - 0\",\"event_final_result\": \"0 - 0\",\"event_ft_result\": \"0 - 0\",\"event_penalty_result\": \"\",\"event_status\": \"Finished\",\"country_name\": \"Italy\",\"league_name\": \"Serie A\",\"league_key\": \"207\",\"league_round\": \"Round 25\",\"league_season\": \"2020/2021\"}"
    private init(){}
    
    
    func fetchJsonData(compilationHandler: @escaping(JsonResponse<League>?, Error?) -> Void) {
        let data = Data(mockResponse.utf8)
        
        do{
            let result = try JSONDecoder().decode(JsonResponse<League>.self, from: data)
            compilationHandler(result , nil)
        }
        catch {
            compilationHandler(nil , error)
        }
    }
    
    func fetchLeagueData(compilationHandler: @escaping(League?, Error?) -> Void) {
        let data = Data(mockLeague.utf8)
        
        do{
            let result = try JSONDecoder().decode(League.self, from: data)
            compilationHandler(result , nil)
        }
        catch {
            compilationHandler(nil , error)
        }
    }
    
    func fetchEventData(compilationHandler: @escaping(Event?, Error?) -> Void) {
        let data = Data(mockEvent.utf8)
        
        do{
            let result = try JSONDecoder().decode(Event.self, from: data)
            compilationHandler(result , nil)
        }
        catch {
            compilationHandler(nil , error)
        }
    }

}
