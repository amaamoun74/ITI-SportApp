//
//  AllLeagueResponse.swift
//  SportApp
//
//  Created by ahmed on 03/02/2023.
//

import Foundation

class JsonResponse<T:Codable>: Codable
{
    var success: Int?
    var result :[T]?
}
