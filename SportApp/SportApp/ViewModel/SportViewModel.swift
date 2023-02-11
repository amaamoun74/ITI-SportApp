//
//  SportViewModel.swift
//  SportApp
//
//  Created by ahmed on 11/02/2023.
//

import Foundation
class SportViewModel {
    
    var bindingData: ( ([SportModel] ,String?) -> Void) = {_, _ in }

    var sportList : [SportModel]? {
        didSet{
            bindingData(sportList ?? [SportModel] (), nil)
        }
    }
    var error: String? {
        didSet{
            bindingData([SportModel] (), error)
        }
    }

    func getSportList(){
        SportManager.sharedInstance.getSportList { sports in
            guard let sports = sports else {
                self.error = "Error while Fetching Sports"
                return
            }
            self.sportList = sports
        }
        
    }
}
