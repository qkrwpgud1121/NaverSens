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

struct Request: Encodable{
    let type: String
    let countryCode: String
    let from: String
    let content: String
    let messages: [SMSMessages]
}

struct SMSMessages: Encodable {
    let to: String
    let content: String
}

struct SMSResponse: Decodable {
    let requestId: String
    let requestTime: String
    let statusCode: String
    let statusName: String
}
