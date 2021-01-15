//
//  CurrenciesProtocol.swift
//  Currency Convert
//
//  Created by Mahmoud Shurrab on 15/01/2021.
//

import Foundation

protocol CurrenciesViewProtocol: class {
    var presenter: CurrenciesPresenterProtocol! { get set }
    func showLoadingIndicator()
    func hideLoadingIndicator()
    func reloadData()
    var amount: Double { get }
    func showAlertWithMessage(message: String)
}

protocol CurrenciesPresenterProtocol: class {
    var view: CurrenciesViewProtocol? { get set }
    var numberOfRows: Int { get }
    func viewDidLoad()
    func configure(cell: CurrenciesCellView, indexPath: IndexPath)
    var currenciesListRows: Int { get }
    func getCurrenciesListRowKeyName(index: Int) -> String
    func getCurrenciesListRowKey(index: Int) -> String
    func getCurrenciesListRowName(index: Int) -> String
    func getCurrentCurrencyConvertRateRequest(currency: String)
}

protocol CurrenciesRouterProtocol {}

protocol CurrenciesInteractorInputProtocol {
    var presenter: CurrenciesInteractorOutputProtocol? { get set }
    func getCurrenciesList()
    func getCurrencyChangeRate(currency: String)
}

protocol CurrenciesInteractorOutputProtocol: class {
    func currenciesListFetchedSuccessfully(response: CurrenciesResponseModel)
    func currenciesListFetchingFailed(withError error: Error)
    func currencyChangeRateListFetchedSuccessfully(response: CurrencyChangeRateResponseModel)
    func currencyChangeRateListFetchingFailed(withError error: Error)
}

protocol CurrenciesCellView {
    func configure(viewModel: CurrencyViewModel)
}
