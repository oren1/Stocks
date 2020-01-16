//
//  CandlesViewModel.swift
//  Stocks
//
//  Created by oren shalev on 15/01/2020.
//  Copyright © 2020 oren shalev. All rights reserved.
//

import Foundation
import UIKit

protocol CandlesViewModelProtocol {
    func showActivityIndicator()
    func hideActivityIndicator()
}

class CandlesViewModel {
   
    var stock: Stock
    var candles: [Candle]! {
        didSet {
            self.candlesDidChange?()
        }
    }
    var candlesDidChange : (() -> ())?
    var reuseIdentifier = "CandleTableViewCell"
    var delegate : CandlesViewModelProtocol?
    
    
    
    init(stock: Stock) {
        self.stock = stock
        candles = []
    }
    
    
   @objc func segmentedControlChange(_ sender: UISegmentedControl) {

        switch sender.selectedSegmentIndex {
             case 0:
            self.getCandlesForTimeInterval(interval: "1min")

             case 1:
                self.getCandlesForTimeInterval(interval: "5min")
        default: break

             }

    }
    
    
    func getCandlesForTimeInterval(interval: String) {

        self.delegate?.showActivityIndicator()
        NetworkManager.getCandlesFor(stock: stock, and: interval) { (candles) in
            self.candles = candles
            self.delegate?.hideActivityIndicator()
        }
    }
    
    
}
