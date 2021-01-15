//
//  Currency.swift
//  Currency Convert
//
//  Created by Mahmoud Shurrab on 15/01/2021.
//

import Foundation

class CurrencyChangeRateResponseModel: Codable {
    let success: Bool?
    let terms, privacy: String?
    let timestamp: Int?
    let source: String?
    let quotes: [String: Double]?
    let error: ResponseError?
}

class ChangeRateModel: Codable {
    var key: String?
    var rate: Double?
}

struct CurrencyViewModel {
    var currencyName: String
    var changeRate: String
    
    init(changeRateModel: ChangeRateModel, amount: Double){
        currencyName = (changeRateModel.key ?? "")+":"
        changeRate = "\((changeRateModel.rate ?? 0) * amount)"
    }
}
