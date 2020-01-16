//
//  Stock.swift
//  Stocks
//
//  Created by oren shalev on 14/01/2020.
//  Copyright © 2020 oren shalev. All rights reserved.
//

import Foundation

struct Stock : Decodable {
    
    enum CodingKeys: String, CodingKey {
      case name, symbol = "stk", imageUrl = "img", priority
    }
    
    var name : String
    var symbol : String
    var imageUrl : String
    var priority : String
    
}
