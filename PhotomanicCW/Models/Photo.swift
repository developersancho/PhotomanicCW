//
//  Photo.swift
//  PhotomanicCW
//
//  Created by developersancho on 29.10.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//

import Foundation

struct PhotoCategory {
    var categoryImageName: String
    var title: String
    var imageNames: [String]
}

class PhotosLibrary {
    
    class func fetchPhotos() -> [PhotoCategory] {
        var categories = [PhotoCategory]()
        let photosData = PhotosLibrary.downloadPhotoData()
        
        for(categoryTitle, dict) in photosData {
            if let dict = dict as? [String: Any] {
                let categoryImageName = dict["categoryImageName"] as! String
                if let imageNames = dict["imageNames"] as? [String] {
                    let newCategory = PhotoCategory(categoryImageName: categoryImageName, title: categoryTitle, imageNames: imageNames)
                    categories.append(newCategory)
                }
            }
        }
        
        return categories
    }
    
    class func downloadPhotoData() -> [String: Any] {
        return [
            "Family" : [
                "categoryImageName" : "family",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "f", numberOfImages: 9),
            ],
            "Foods" : [
                "categoryImageName" : "foods",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "fo", numberOfImages: 8),
            ],
            "Travel" : [
                "categoryImageName" : "travel",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "t", numberOfImages: 8),
            ],
            "Nature" : [
                "categoryImageName" : "nature",
                "imageNames" : PhotosLibrary.generateImage(categoryPrefix: "n", numberOfImages: 9),
            ]
        ]
    }
    
    private class func generateImage(categoryPrefix: String, numberOfImages: Int) -> [String] {
        var imageNames = [String]()
        
        for i in 1...numberOfImages {
            imageNames.append("\(categoryPrefix)\(i)")
        }
        
        return imageNames
    }
    
}
