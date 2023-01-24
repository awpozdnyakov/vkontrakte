//
//  AllPhotoController.swift
//  Vkontrakte
//
//  Created by Andrey Pozdnyakov on 30.11.2022.
//

import UIKit

class AllPhotoController: UIViewController {

    public var friendsImage = [UIImage]()
    
    @IBOutlet var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}


extension AllPhotoController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        friendsImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionCell
        
        cell.friendsPhoto.image = friendsImage[indexPath.row]
        
        return cell
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowBigPhoto",
           let selectedPhoto = collectionView.indexPathsForSelectedItems?.first,
           let bigPhotoVC = segue.destination as? BigPhotoController {
            
            bigPhotoVC.photos = friendsImage
            bigPhotoVC.selectedPhotoIndex = selectedPhoto.item
        }
    }
    
}

