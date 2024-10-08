//
//  CountryName.swift
//  NaverSens
//
//  Created by 박제형 on 9/19/24.
//

import Foundation

struct CountryList: Codable {
    let list: [List]
}

struct List: Codable {
    let code: String
    let name: String
    let englishName: String
    let countryCode: String
}

struct Request: Codable{
    let type: String
    let countentType: String
    let countryCode: String
    let from: String
    let subject: String
    let content: String
    let messages: [Messages]
    let files: [Files]
    let reserveTime: String
    let reserveTimeZone: String
}

struct Messages: Codable {
    let to: String
    let subject: String
    let content: String
}

struct Files: Codable {
    let fileId: String
}
