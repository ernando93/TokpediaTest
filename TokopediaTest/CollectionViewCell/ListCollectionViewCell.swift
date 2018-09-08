//
//  ListCollectionViewCell.swift
//  TokopediaTest
//
//  Created by Ernando on 9/7/18.
//  Copyright © 2018 HappyCoding. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SDWebImage
import ListPlaceholder

class ListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageTitle: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelPrice: UILabel!
    
    func cellConfigure(withData data: DataModel) {
        self.contentView.showLoader()
        setupSubView(withURL: data.imageUri, withTitle: data.name, andPrice: data.price)
    }

}

//MARK: Setup SubView
extension ListCollectionViewCell {
    func setupSubView(withURL url: String, withTitle title: String, andPrice price: String) {
        setupImageTitle(withURL: url)
        setupLabelTitle(withTitle: title)
        setupLabelPrice(withPrice: price)
    }
    
    func setupImageTitle(withURL url: String) {
        self.contentView.showLoader()
        if url != "" {
            let sdImageoption: SDWebImageOptions = .allowInvalidSSLCertificates
            imageTitle.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "Placeholder"), options: sdImageoption) {(image, error, cahceType, nil) in
                self.contentView.hideLoader()
                if image == nil {
                    self.imageTitle.image = UIImage(named: "Placeholder")
                    self.contentView.hideLoader()
                }
            }
        } else {
            self.imageTitle.image = UIImage(named: "Placeholder")
            self.contentView.hideLoader()
        }
    }
    
    func setupLabelTitle(withTitle title: String) {
        labelTitle.text = title
    }
    
    func setupLabelPrice(withPrice price: String) {
        labelPrice.text = price
    }
}
