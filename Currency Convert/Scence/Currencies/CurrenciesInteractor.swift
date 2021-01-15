//
//  CurrenciesInteractor.swift
//  Currency Convert
//
//  Created by Mahmoud Shurrab on 15/01/2021.
//

import Foundation

class CurrenciesInteractor: CurrenciesInteractorInputProtocol {
    weak var presenter: CurrenciesInteractorOutputProtocol?
    
    private let currenciesWorker = CurrenciesWorker()
    
    func getCurrenciesList() {
        currenciesWorker.getCurrenciesList{ [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let currenciesListResponse):
                self.presenter?.currenciesListFetchedSuccessfully(response: currenciesListResponse)
            case .failure(let error):
                self.presenter?.currenciesListFetchingFailed(withError: error)
            }
        }
    }
    
    func getCurrencyChangeRate(currency: String){
        currenciesWorker.getCurrencyChangeRateList(currency: currency){ [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let currencyChangeRateListResponse):
                self.presenter?.currencyChangeRateListFetchedSuccessfully(response: currencyChangeRateListResponse)
            case .failure(let error):
                self.presenter?.currencyChangeRateListFetchingFailed(withError: error)
            }
        }
    }
}
