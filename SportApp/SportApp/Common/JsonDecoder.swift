//
//  JsonDecoder.swift
//  SportApp
//
//  Created by ahmed on 04/02/2023.
//

import Foundation

func convertFromJson<T: Codable>(data: Data) -> T? {
    let jsonDecoder = JSONDecoder()
    let decodedArray = try? jsonDecoder.decode(T.self, from: data)
    return decodedArray
}
