//
//  DataCaching.swift
//  SportApp
//
//  Created by ahmed on 05/02/2023.
//

import Foundation
import CoreData
class DataCaching {
    static let sharedInstance = DataCaching()
    private init(){}
    
    func fetchSavedLeagues(appDelegate : AppDelegate) -> [League] {
        var leagueArray: [League] = []
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SavedLeague")
        
        do {
            let fetchedLeagueArray = try managedContext.fetch(fetchRequest)
            for item in (fetchedLeagueArray)
            {
                let league = League()
                league.league_name = item.value(forKey:"league_name") as? String
                league.league_logo = item.value(forKey: "league_logo") as? String
                league.league_key = item.value(forKey: "league_key") as? Int
                league.country_key = item.value(forKey: "country_key") as? Int
                league.country_name = item.value(forKey: "country_name") as? String
                league.country_logo = item.value(forKey: "country_logo") as? String
                league.League_endpoint = item.value(forKey: "endpoint") as? String
                leagueArray.append(league)
            }
        } catch let error {
            print("fetch all leagues error :", error)
        }
        return leagueArray
    }
    
    func deleteLeagueFromFavourites(appDelegate: AppDelegate, league_key: Int , complition : (Error?) -> Void?){
        let managedContext = appDelegate.persistentContainer.viewContext
        do{
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedLeague")
            fetchRequest.predicate = NSPredicate(format: "league_key == %i", league_key )
            let league = try managedContext.fetch(fetchRequest)
            
            managedContext.delete((league as! [NSManagedObject]).first!)
            
            try managedContext.save()
            print("league deleted")
            complition(nil)
        } catch let error as NSError{
            complition("Error in deleting" as? Error )
            print("Error in deleting")
            print(error.localizedDescription)
        }
    }
    
    func saveLeagueToFavourites(event : Event, appDelegate : AppDelegate) -> Void
    {
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "SavedLeague", in: managedContext)
        let league = NSManagedObject(entity: entity!, insertInto: managedContext)
        league.setValue(event.league_key ?? 0, forKey: "league_key")
        league.setValue(event.league_name, forKey: "league_name")
        league.setValue(event.league_logo , forKey: "league_logo")
        league.setValue(event.event_country_key ?? 0, forKey: "country_key")
        league.setValue(event.country_name, forKey: "country_name")
        league.setValue(event.country_logo , forKey: "country_logo")
        league.setValue(event.event_endPoint, forKey: "endpoint")
        league.setValue(true , forKey: "league_state")
        do{
            try managedContext.save()
            print("Saved!")
        }catch let error{
            print(error.localizedDescription)
        }
    }
    func isFavouriteLeague (leagueKey: Int, appDelegate : AppDelegate) -> Bool
    {
 //       var league : League = League()
        var state : Bool = false
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "SavedLeague")
        let pred = NSPredicate(format: "league_key == %i", leagueKey )
        fetchRequest.predicate = pred
            do{
                let fetchedLeagueArray = try managedContext.fetch(fetchRequest)
                for item in (fetchedLeagueArray)
                {
                    state = (item.value(forKey: "league_state") as? Bool ?? false)
                    print("\(state)")
                }
            }catch let error{
                print(error.localizedDescription)
            }
        
        if state == true
        {
            return true
        }
        else
        {
            return false
        }
    }

    
}
