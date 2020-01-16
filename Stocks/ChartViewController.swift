//
//  ChartViewController.swift
//  Stocks
//
//  Created by oren shalev on 16/01/2020.
//  Copyright © 2020 oren shalev. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController {

    var candles : [Candle]!
    @IBOutlet weak var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateGraph()
        // Do any additional setup after loading the view.
    }
    
    func updateGraph() {
        
        var lineChartEntry = [ChartDataEntry]()
        
        for i in 0..<candles.count {
            
            let candle = candles[i]
            let close = Double(candle.close)!

            let value = ChartDataEntry(x: Double(i), y: close)
            
            lineChartEntry.append(value)
        }
        
        let line1 = LineChartDataSet(entries: lineChartEntry, label: "line 1")
        line1.colors = [NSUIColor.blue]

        
        let data = LineChartData()
       
        data.addDataSet(line1)

        lineChartView.data = data
    }

}
