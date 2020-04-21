//
//  CandlesViewModel.swift
//  Stocks
//
//  Created by oren shalev on 15/01/2020.
//  Copyright © 2020 oren shalev. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxRelay

protocol CandlesViewModelProtocol {
    func showActivityIndicator()
    func hideActivityIndicator()
}

class CandlesViewModel : NSObject {
   
    var stock: Stock
    var candles: [Candle]! {
        didSet {
            self.candlesDidChange?()
        }
    }

    
    // Also make it with observable
    @objc dynamic var observableCandles : [ObservableCandle] = []
    
    
    // Lets implement this with RxSwift
    let rxCandles: BehaviorRelay<[Candle]> = BehaviorRelay(value: [])
    
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
        NetworkManager.getCandlesFor(stock: stock, and: interval) { (candles, observableCandles) in
            
            DispatchQueue.main.async {
                self.candles = candles
                self.observableCandles = observableCandles
                self.rxCandles.accept(candles)
                self.delegate?.hideActivityIndicator()
            }

        }
    }
    

}
