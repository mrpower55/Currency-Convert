//
//  CurrenciesWorker.swift
//  Currency Convert
//
//  Created by Mahmoud Shurrab on 15/01/2021.
//

import Foundation

class CurrenciesWorker {
    private let networkLayer = NetworkLayer()
    
    func getCurrenciesList(completionHandler: @escaping (Result<CurrenciesResponseModel>) -> ()) {
        networkLayer.request(CurrenciesListRouter.get, decodeToType: CurrenciesResponseModel.self, completionHandler: completionHandler)
    }
    
    func getCurrencyChangeRateList(currency: String, completionHandler: @escaping (Result<CurrencyChangeRateResponseModel>) -> ()) {
        currentCurrency = currency
        networkLayer.request(CurrencyChangeRateRouter.get, decodeToType: CurrencyChangeRateResponseModel.self, completionHandler: completionHandler)
    }
}
