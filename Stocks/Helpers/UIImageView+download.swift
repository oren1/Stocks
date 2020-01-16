//
//  UIImageView+download.swift
//  TopSeries
//
//  Created by oren shalev on 10/12/2019.
//  Copyright © 2019 oren shalev. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

extension UIImageView {
    func download(from url: URL, contentMode mode: UIView.ContentMode = .scaleToFill) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        
        let processor = ResizingImageProcessor(referenceSize: self.frame.size, mode: .aspectFill)
                     |> RoundCornerImageProcessor(cornerRadius: 0)
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: url,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        {
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        
    }
    
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        download(from: url, contentMode: mode)
    }
}
