//
//  ControllerViewModel.swift
//  Stocks
//
//  Created by oren shalev on 19/04/2020.
//  Copyright © 2020 oren shalev. All rights reserved.
//

import Foundation
import UIKit

class ControllerViewModel {
    
    let reuseIdentifier = "stock cell"
    
    public let sectionInsets = UIEdgeInsets(top: 20.0,
                                             left: 10.0,bottom: 20.0,right: 10.0)
    
    public let itemsPerRow: CGFloat = 2
    
        lazy var stocks : [Stock] = {
            let stockDictionary = [
                       [ "name":"JPMorgan", "stk":"JPM", "img":"https://www.interbrand.com/assets/00000001535.png","priority":"100" ],
                       [ "name":"Bank of America", "stk":"BAC", "img":"https://www.charlotteobserver.com/latest-news/uiy86c/picture6131838/alternates/FREE_1140/E8VhA.So.138.jpg","priority":"99" ],
                       [ "name":"Citigroup", "stk":"C", "img":"https://pentagram-production.imgix.net/wp/592ca89f19a1d/ps-citibank-01.jpg","priority":"80" ],
                       [ "name":"Wells Fargo", "stk":"IIS", "img":"https://motorsportsnewswire.com/wp-content/uploads/2019/08/Wells-Fargo-Company-logo-678.jpg","priority":"15" ],
                       [ "name":"Morgan Stanley", "stk":"MS", "img":"https://www.spglobal.com/_assets/images/leveragedloan/2012/07/morgan-stanley-logo.jpg","priority":"15"  ],
                     ]
            
            do {
                let data = try JSONSerialization.data(withJSONObject: stockDictionary, options: [])
                let decoder = JSONDecoder()
                var stocks = try decoder.decode([Stock].self, from: data)
                stocks.sort { Int($0.priority)! >= Int($1.priority)! }

                return stocks
                }
                catch {
                    print("error parsing stocks")
                    return []
                }
            
    }()
}

