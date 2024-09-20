//
//  CountryName.swift
//  NaverSens
//
//  Created by 박제형 on 9/19/24.
//

import Foundation

struct CountryList: Codable {
    let total: Int
    let list: [List]
}

struct List: Codable {
    let code: String
    let country: String
    let description: String
}
