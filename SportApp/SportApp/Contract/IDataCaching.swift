//
//  IDataCaching.swift
//  SportApp
//
//  Created by ahmed on 05/02/2023.
//

import Foundation
import CoreData
protocol IDataCaching{
    
    func fetchSavedLeagues(appDelegate : AppDelegate, completion: @escaping(([League]?, Error?) -> Void ))
    func deleteLeagueFromFavourites(appDelegate: AppDelegate, item: League , completion: (Error?) -> Void)

}
