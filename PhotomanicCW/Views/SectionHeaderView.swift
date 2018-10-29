//
//  SectionHeaderView.swift
//  PhotomanicCW
//
//  Created by developersancho on 29.10.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//

import UIKit

class SectionHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var categoryTitleLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    var photoCategory: PhotoCategory! {
        didSet {
            categoryTitleLabel.text = photoCategory.title
            categoryImageView.image = UIImage(named: photoCategory.categoryImageName)
        }
    }
    
}
