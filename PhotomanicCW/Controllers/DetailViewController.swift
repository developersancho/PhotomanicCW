//
//  DetailViewController.swift
//  PhotomanicCW
//
//  Created by developersancho on 29.10.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = image
        navigationItem.title = "Photo"
    }
}
