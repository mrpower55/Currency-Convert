//
//  CurrenciesViewController.swift
//  Currency Convert
//
//  Created by Mahmoud Shurrab on 15/01/2021.
//

import UIKit

var currentCurrency: String = ""

class CurrenciesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, CurrenciesViewProtocol {
    var presenter: CurrenciesPresenterProtocol!
    
    @IBOutlet weak var currencyChangeRateTableView : UITableView!
    
    @IBOutlet weak var amountTextField : UITextField!
    @IBOutlet weak var currencyTextField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter.viewDidLoad()
        
        createPickerView()
        dismissPickerView()
    }
    
    private func setupTableView() {
        currencyChangeRateTableView.dataSource = self
        currencyChangeRateTableView.delegate = self
        
        currencyChangeRateTableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyRateCell", for: indexPath) as! CurrencyRateCell
        presenter.configure(cell: cell, indexPath: indexPath)
        return cell
    }
    
    func showLoadingIndicator() {
        LoadingIndicatorView.show("Loading")
    }
    
    func hideLoadingIndicator() {
        LoadingIndicatorView.hide()
    }
    
    func reloadData() {
        self.currencyChangeRateTableView.reloadData()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter.currenciesListRows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return presenter.getCurrenciesListRowKeyName(index: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currentCurrency = presenter.getCurrenciesListRowKey(index: row)
        currencyTextField.text = currentCurrency
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        currencyTextField.inputView = pickerView
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissAmountField))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        amountTextField.inputAccessoryView = toolBar
        
        let toolBar2 = UIToolbar()
        toolBar2.sizeToFit()
        
        let button2 = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.getCurrencyConvertRate))
        toolBar2.setItems([button2], animated: true)
        toolBar2.isUserInteractionEnabled = true
        currencyTextField.inputAccessoryView = toolBar2
    }
    
    @objc func dismissAmountField(){
        view.endEditing(true)
        
        if currentCurrency != "" {
            presenter.getCurrentCurrencyConvertRateRequest(currency: currentCurrency)
        }
    }
    
    @objc func getCurrencyConvertRate() {
        view.endEditing(true)
        currentCurrency = currencyTextField.text ?? ""
        
        if amountTextField.text != "" {
            presenter.getCurrentCurrencyConvertRateRequest(currency: currentCurrency)
        }
    }
    
    var amount: Double {
        return Double(amountTextField.text ?? "0.0") ?? 0.0
    }
    
    func showAlertWithMessage(message: String){
        let alert = UIAlertController(title: "", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

