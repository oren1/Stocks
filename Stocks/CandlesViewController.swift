//
//  CandlesViewController.swift
//  Stocks
//
//  Created by oren shalev on 15/01/2020.
//  Copyright © 2020 oren shalev. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class CandlesViewController: UIViewController, CandlesViewModelProtocol {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    var activityIndicatorView : NVActivityIndicatorView!
    var viewModel: CandlesViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Graph", style: .plain, target: self, action: #selector(graphButtonTapped))

        
        self.segmentedControl.addTarget(viewModel, action: #selector(viewModel.segmentedControlChange(_:)), for: .valueChanged)
        
        self.viewModel.candlesDidChange = {
            self.tableView.reloadData()
        }
        
       activityIndicatorView = NVActivityIndicatorView(frame: self.view.bounds, type: .lineScale, color: .blue, padding: 160)

        viewModel.getCandlesForTimeInterval(interval: "1min")
    }
    
    
    
    func showActivityIndicator() {
        tableView.isHidden = true
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.startAnimating()
    }
    
    func hideActivityIndicator() {
        tableView.isHidden = false
        activityIndicatorView.removeFromSuperview()
        activityIndicatorView.stopAnimating()

    }

    
    @objc func graphButtonTapped() {
         let storyboard = UIStoryboard(name: "Main", bundle: nil)

          let chartViewController = storyboard.instantiateViewController(withIdentifier: "ChartViewController") as! ChartViewController
          
             chartViewController.candles = viewModel.candles
             self.navigationController?.pushViewController(chartViewController, animated: true)
     }
    
}



extension CandlesViewController : UITableViewDataSource, UITableViewDelegate {
    
    // number of rows in table view
     
     func numberOfSections(in tableView: UITableView) -> Int {
             return 1
     }
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
        return viewModel.candles.count
     }

     // create a cell for each table view row
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.reuseIdentifier, for: indexPath) as! CandleTableViewCell
        
        let candle = viewModel.candles[indexPath.row]
        
        cell.timeLabel.text = "Time: \(candle.time)"
        cell.openLabel.text = "Open: \(candle.open)"
        cell.highLabel.text = "High: \(candle.high)"
        cell.lowLabel.text = "Low: \(candle.low)"
        cell.closeLabel.text = "Close: \(candle.close)"
        cell.volumeLabel.text = "Volume: \(candle.volume)"
        
        return cell
     }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175
    }
}
