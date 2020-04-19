//
//  Candle.swift
//  Stocks
//
//  Created by oren shalev on 14/01/2020.
//  Copyright © 2020 oren shalev. All rights reserved.
//

import Foundation

struct Candle {
    
    var time : String
    var open : String
    var high : String
    var low : String
    var close : String
    var volume : String
}

class ObservableCandle : NSObject{
    
    var time : String
    var open : String
    var high : String
    var low : String
    var close : String
    var volume : String
    
    init(time : String, open : String, high : String, low : String, close : String, volume : String) {
        
        self.time = time
        self.open = open
        self.high = high
        self.low = low
        self.close = close
        self.volume = volume
    }
    
}
