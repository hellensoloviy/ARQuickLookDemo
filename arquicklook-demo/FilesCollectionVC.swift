//
//  FilesCollectionVC.swift
//  arquicklook-demo
//
//  Created by Hellen Soloviy on 3/5/19.
//  Copyright © 2019 HellySolovii. All rights reserved.
//

import Foundation
import UIKit
import QuickLook

class FilesCollectionVC: UICollectionViewController {
    
    // MARK: - Properties
    private let sectionInsets = UIEdgeInsets(top: 20.0, left: 40.0, bottom: 50.0, right: 40.0)
    
    //search results will be limited to 20
    private var data: [String] = ["cupandsaucer", "tulip"]
    private let itemsPerRow: CGFloat = 1
    private var selectedIndexPath: IndexPath = IndexPath(item: 0, section: 0)
    
    // MARK: - UICollectionViewDataSource
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        collectionView.allowsMultipleSelection = false
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FileCollectionViewItem.identifier, for: indexPath) as! FileCollectionViewItem
        //config the cell
        cell.backgroundColor = .gray
//        let fileUrl = Bundle.main.url(forResource: data[indexPath.row], withExtension: "usdz")!
        cell.imageView.image = UIImage(named: "\(data[indexPath.row]).jpg")
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = QLPreviewController()
        controller.delegate = self
        controller.dataSource = self
        self.present(controller, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        selectedIndexPath = indexPath
        return true
    }
}

// MARK: - Collection View Flow Layout Delegate
extension FilesCollectionVC : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

// MARK: - QLPreview

extension FilesCollectionVC: QLPreviewControllerDelegate {
    func previewController(_ controller: QLPreviewController, transitionViewFor item: QLPreviewItem) -> UIView? {
        let cell = collectionView.cellForItem(at: selectedIndexPath)!
        return cell.contentView
    }
    
}

extension FilesCollectionVC: QLPreviewControllerDataSource {
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }
    
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
//        let cell = collectionView.cellForItem(at: indexPath) as! QLPreviewItem
        
        let fileUrl = Bundle.main.url(forResource: data[selectedIndexPath.row], withExtension: "usdz")!
        return fileUrl as QLPreviewItem
    }
    
}
