//
//  ViewController.swift
//  PhotomanicCW
//
//  Created by developersancho on 29.10.2018.
//  Copyright © 2018 developersancho. All rights reserved.
//

import UIKit

struct StoryBoard {
    static let photoCell = "PhotoCell"
    static let sectionHeaderView = "SectionHeaderView"
    static let showDetailWC = "ShowImageDetail"
    static let leftAndRightPadding: CGFloat = 2.0
    static let numberOfItemsPerRow: CGFloat = 3.0
}

class ViewController: UICollectionViewController {
    
    @IBOutlet weak var addBarButtonItem: UIBarButtonItem!
    
    var photoCategories: [PhotoCategory] = PhotosLibrary.fetchPhotos()
    
    // MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TO DO: change the layout of the collection view
        let collectionViewWidth = collectionView?.frame.width
        let itemWidth = (collectionViewWidth! - StoryBoard.leftAndRightPadding) / StoryBoard.numberOfItemsPerRow
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        navigationItem.leftBarButtonItem = editButtonItem
    }
    // MARK: - UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return photoCategories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoCategories[section].imageNames.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryBoard.photoCell, for: indexPath) as! PhotoCell
        
        let photoCategory = photoCategories[indexPath.section]
        let imageNames = photoCategory.imageNames
        let imageName = imageNames[indexPath.item]
        
        cell.imageName = imageName
        cell.delegate = self
        return cell
    }
    
    // Section Header View
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: StoryBoard.sectionHeaderView, for: indexPath) as! SectionHeaderView
        let category = photoCategories[indexPath.section]
        sectionHeaderView.photoCategory = category
        return sectionHeaderView
    }
    
    // MARK: UICollectionViewDelegate
    var selectedImage: UIImage!
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category = photoCategories[indexPath.section]
        selectedImage = UIImage(named: category.imageNames[indexPath.item])
        performSegue(withIdentifier: StoryBoard.showDetailWC, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == StoryBoard.showDetailWC {
            let detailVC = segue.destination as! DetailViewController
            detailVC.image = selectedImage
        }
    }
    @IBAction func addNewItemDidTap(_ sender: Any) {
        // 1 - get random image
        let firstCategoryImageNames = photoCategories[0].imageNames
        let randomIndex = Int(arc4random()) % firstCategoryImageNames.count
        let randomImageName = firstCategoryImageNames[randomIndex]
        
        // 2 - add the new image into your model
        photoCategories[0].imageNames.append(randomImageName)
        
        // 3 - update the collection because there's a change in your data source
        let insertedIndexPath = IndexPath(item: firstCategoryImageNames.count, section: 0)
        collectionView?.insertItems(at: [insertedIndexPath])
    }
    
    // MARK : Delete Item
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        addBarButtonItem.isEnabled = !editing
        if let indexPaths = collectionView?.indexPathsForVisibleItems {
            for indexPath in indexPaths {
                if let cell = collectionView?.cellForItem(at: indexPath) as? PhotoCell {
                 cell.isEditing = editing
                }
            }
        }
    }
    
}

extension ViewController: PhotoCellDelegate {
    func delete(cell: PhotoCell) {
        if let indexPath = collectionView?.indexPath(for: cell){
            // 1 - delete the photo from our data source
            photoCategories[indexPath.section].imageNames.remove(at: indexPath.item)
            // 2 - delete the photo cell at that index path from the collection view
            collectionView?.deleteItems(at: [indexPath])
        }
    }
}
