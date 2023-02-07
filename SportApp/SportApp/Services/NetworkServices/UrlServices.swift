//
//  UrlServices.swift
//  SportApp
//
//  Created by ahmed on 04/02/2023.
//

import Foundation
struct UrlServices {
    var endPoint: String = ""
    var url: String {
        return  "https://apiv2.allsportsapi.com/\(endPoint)/?met=Leagues&APIkey=488b4a38e00ac0ede3209ae390d9a0f67f156ceb01507f6dfc1b8276d83cc402"
    }
}
