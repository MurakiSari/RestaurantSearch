//
//  ImageListCell.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/06/07.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import Foundation
import UIKit

// swiftlint:disable private_outlet

final class ImageListCell: UICollectionViewCell {
    var onReuse: (() -> Void)?
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
        imageView.layer.borderColor = nil
        imageView.layer.borderWidth = 0
        nameLabel.text = nil
        errorMessageLabel.text = nil
        
        onReuse?()
    }
}
