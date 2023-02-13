//
//  SavingData.swift
//  SportApp
//
//  Created by Fatma on 11/02/2023.
//

import Foundation
import CoreData

protocol SavingData{
    func saveLeagueToFavourites(event : Event, appDelegate : AppDelegate) -> Void
}
