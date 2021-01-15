//
//  CurrenciesRouter.swift
//  Currency Convert
//
//  Created by Mahmoud Shurrab on 15/01/2021.
//

import UIKit

class CurrenciesRouter: CurrenciesRouterProtocol {
    
    weak var viewController: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = UIStoryboard(name: "Currencies", bundle: nil).instantiateViewController(withIdentifier: "\(CurrenciesViewController.self)") as! CurrenciesViewController
        let interactor = CurrenciesInteractor()
        let router = CurrenciesRouter()
        let presenter = CurrenciesPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.viewController = view 
        return view
    }
}
