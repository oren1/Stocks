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


    let controllerViewModel = ControllerViewModel()

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
        
        let stock = controllerViewModel.stocks[indexPath.row]

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
        return controllerViewModel.stocks.count
    }
    
    
     func collectionView(
      _ collectionView: UICollectionView,
      cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        
        let stock = self.controllerViewModel.stocks[indexPath.row]
        let cell = collectionView
            .dequeueReusableCell(withReuseIdentifier: controllerViewModel.reuseIdentifier, for: indexPath) as! StockCollectionViewCell
        
      
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
    let paddingSpace = controllerViewModel.sectionInsets.left * (controllerViewModel.itemsPerRow + 1)
    let availableWidth = view.bounds.width - paddingSpace
    let widthPerItem = Int(availableWidth / controllerViewModel.itemsPerRow)
    let height = widthPerItem
    let size = CGSize(width:widthPerItem, height: height)
    return size
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return controllerViewModel.sectionInsets
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return controllerViewModel.sectionInsets.left
  }
}
