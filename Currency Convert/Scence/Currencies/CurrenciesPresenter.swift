//
//  CurrenciesPresenter.swift
//  Currency Convert
//
//  Created by Mahmoud Shurrab on 15/01/2021.
//

import Foundation

class CurrenciesPresenter: CurrenciesPresenterProtocol, CurrenciesInteractorOutputProtocol {
    weak var view: CurrenciesViewProtocol?
    private let interactor: CurrenciesInteractorInputProtocol
    private let router: CurrenciesRouterProtocol
    private var currenciesList = [CurrencyModel]()
    private var currencyChangeRateList = [ChangeRateModel]()
    
    var numberOfRows: Int {
        return currencyChangeRateList.count
    }
    
    init(view: CurrenciesViewProtocol, interactor: CurrenciesInteractorInputProtocol, router: CurrenciesRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view?.showLoadingIndicator()
        interactor.getCurrenciesList()
    }
    
    func currenciesListFetchedSuccessfully(response: CurrenciesResponseModel) {
        view?.hideLoadingIndicator()
        self.currenciesList = []
        
        if response.success! {
            for (key, value) in response.currencies ?? [:] {
                let currencyModel: CurrencyModel = CurrencyModel()
                currencyModel.key = key
                currencyModel.name = value
                self.currenciesList.append(currencyModel)
            }
            
            self.currenciesList = self.currenciesList.sorted { $0.name!.localizedCaseInsensitiveCompare($1.name!) == ComparisonResult.orderedAscending }
        } else {
            view?.showAlertWithMessage(message: response.error?.info ?? "")
        }
    }
    
    func currenciesListFetchingFailed(withError error: Error) {
        view?.hideLoadingIndicator()
        view?.showAlertWithMessage(message: error.localizedDescription)
    }
    
    func currencyChangeRateListFetchedSuccessfully(response: CurrencyChangeRateResponseModel) {
        view?.hideLoadingIndicator()
        
        self.currencyChangeRateList = []
        
        if response.success! {
            for (key, value) in response.quotes ?? [:] {
                let changeRateModel: ChangeRateModel = ChangeRateModel()
                changeRateModel.key = key
                changeRateModel.rate = value
                self.currencyChangeRateList.append(changeRateModel)
            }
            
            self.currencyChangeRateList = self.currencyChangeRateList.sorted { $0.key!.localizedCaseInsensitiveCompare($1.key!) == ComparisonResult.orderedAscending }
        } else {
            view?.showAlertWithMessage(message: response.error?.info ?? "")
        }
        
        view?.reloadData()
    }
    
    func currencyChangeRateListFetchingFailed(withError error: Error) {
        view?.hideLoadingIndicator()
        view?.showAlertWithMessage(message: error.localizedDescription)
    }
    
    
    func configure(cell: CurrenciesCellView, indexPath: IndexPath) {
        let changeRate = currencyChangeRateList[indexPath.row]
        let viewModel = CurrencyViewModel(changeRateModel: changeRate, amount: view?.amount ?? 0.0)
        cell.configure(viewModel: viewModel)
    }
    
    var currenciesListRows: Int {
        return currenciesList.count
    }
    
    func getCurrenciesListRowKeyName(index: Int) -> String {
        return (currenciesList[index].key ?? "")+" - "+(currenciesList[index].name ?? "")
    }
    
    func getCurrenciesListRowKey(index: Int) -> String {
        return currenciesList[index].key ?? ""
    }
    
    func getCurrenciesListRowName(index: Int) -> String {
        return currenciesList[index].name ?? ""
    }
    
    func getCurrentCurrencyConvertRateRequest(currency: String){
        view?.showLoadingIndicator()
        interactor.getCurrencyChangeRate(currency: currency)
    }
}
