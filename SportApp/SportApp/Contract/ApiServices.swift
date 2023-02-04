//
//  ApiServices.swift
//  SportApp
//
//  Created by ahmed on 04/02/2023.
//

import Foundation
protocol ApiService {
    func getAllLeagues(endPoint: String, completion: @escaping ((AllLeagueResponse?, Error?) -> Void))
}
