//
//  User.swift
//  Currency Convert
//
//  Created by Mahmoud Shurrab on 15/01/2021.
//

import Foundation

class CurrenciesResponseModel: Codable {
    let success: Bool?
    let terms, privacy: String?
    let currencies: [String: String]?
    let error: ResponseError?
}

class CurrencyModel: Codable {
    var key, name: String?
}

class ResponseError: Codable {
    let code: Int?
    let type, info: String?
}

