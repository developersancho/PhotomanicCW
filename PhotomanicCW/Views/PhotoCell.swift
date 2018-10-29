//
//  PhotoCell.swift
//  PhotomanicCW
//
//  Created by developersancho on 29.10.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//

import UIKit

protocol PhotoCellDelegate: class {
    func delete(cell: PhotoCell)
}

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var deleteButtonBackgroundView: UIVisualEffectView!
    weak var delegate: PhotoCellDelegate?
    
    var imageName: String! {
        didSet {
            photoImageView.image = UIImage(named: imageName)
            deleteButtonBackgroundView.layer.cornerRadius = deleteButtonBackgroundView.bounds.width/2.0
            deleteButtonBackgroundView.layer.masksToBounds = true
            deleteButtonBackgroundView.isHidden = !isEditing
        }
    }
    
    var isEditing: Bool = false {
        didSet {
            deleteButtonBackgroundView.isHidden = !isEditing
        }
    }
    
    @IBAction func deleteButtonDidTap(_ sender: Any) {
        delegate?.delete(cell: self)
    }
    
    
}
