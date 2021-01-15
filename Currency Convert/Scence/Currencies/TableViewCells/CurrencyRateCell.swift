//
//  CurrencyRateCell.swift
//  Currency Convert
//
//  Created by Mahmoud Shurrab on 15/01/2021.
//

import UIKit

class CurrencyRateCell: UITableViewCell, CurrenciesCellView {
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var amount: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(viewModel: CurrencyViewModel) {
        currency.text = viewModel.currencyName
        amount.text = viewModel.changeRate
    }
}
