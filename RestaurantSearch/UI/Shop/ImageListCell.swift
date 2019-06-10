//
//  ImageListCell.swift
//  RestaurantSearch
//
//  Created by 岩永彩里 on 2019/06/07.
//  Copyright © 2019 岩永 彩里. All rights reserved.
//

import Foundation
import Alamofire

final class ImageListCell: UICollectionViewCell {
    var onReuse: (() -> Void)?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        onReuse?()
    }
}
