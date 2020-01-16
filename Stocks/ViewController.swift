//
//  ViewController.swift
//  Stocks
//
//  Created by oren shalev on 14/01/2020.
//  Copyright © 2020 oren shalev. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController {

    lazy var stocks : [Stock] = {
        let stockDictionary = [
                   [ "name":"JPMorgan", "stk":"JPM", "img":"https://www.interbrand.com/assets/00000001535.png","priority":"100" ],
                   [ "name":"Bank of America", "stk":"BAC", "img":"https://www.charlotteobserver.com/latest-news/uiy86c/picture6131838/alternates/FREE_1140/E8VhA.So.138.jpg","priority":"99" ],
                   [ "name":"Citigroup", "stk":"C", "img":"https://pentagram-production.imgix.net/wp/592ca89f19a1d/ps-citibank-01.jpg","priority":"80" ],
                   [ "name":"Wells Fargo", "stk":"IIS", "img":"https://motorsportsnewswire.com/wp-content/uploads/2019/08/Wells-Fargo-Company-logo-678.jpg","priority":"15" ],
                   [ "name":"Morgan Stanley", "stk":"MS", "img":"https://www.spglobal.com/_assets/images/leveragedloan/2012/07/morgan-stanley-logo.jpg","priority":"15"  ]
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
    
    let reuseIdentifier = "stock cell"
    
    private let sectionInsets = UIEdgeInsets(top: 20.0,
                                             left: 10.0,bottom: 20.0,right: 10.0)
    
    private let itemsPerRow: CGFloat = 2
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "All the stocks in the world"
        collectionView.delegate = self
        collectionView.dataSource = self
        
       self.collectionView.reloadData()
        
    }


}


extension ViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let stock = stocks[indexPath.row]

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let candlesViewController = storyboard.instantiateViewController(withIdentifier: "CandlesViewController") as! CandlesViewController
        
        candlesViewController.viewModel = CandlesViewModel(stock: stock)
        
        self.navigationController?.pushViewController(candlesViewController, animated: true)
        
    }
}

extension ViewController : UICollectionViewDataSource {
     func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
    }
    
     func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
      return stocks.count
    }
    
    
     func collectionView(
      _ collectionView: UICollectionView,
      cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let stock = self.stocks[indexPath.row]
        let cell = collectionView
          .dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! StockCollectionViewCell
        
      
      cell.nameLabel.text = stock.name

      if let url = URL(string: stock.imageUrl) {
          cell.imageView.download(from: url)
          cell.imageView.contentMode = .center

      }

        return cell
        
    }
}

// MARK: - Collection View Flow Layout Delegate
extension ViewController : UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
    let availableWidth = view.bounds.width - paddingSpace
    let widthPerItem = Int(availableWidth / itemsPerRow)
    let height = widthPerItem
    let size = CGSize(width:widthPerItem, height: height)
    return size
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.left
  }
}
