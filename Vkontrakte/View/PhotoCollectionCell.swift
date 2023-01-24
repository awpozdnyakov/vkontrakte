//
//  PhotoCollectionCell.swift
//  Vkontrakte
//
//  Created by Andrey Pozdnyakov on 03.11.2022.
//

import UIKit

class PhotoCollectionCell: UICollectionViewCell {
    
    @IBOutlet var friendsPhoto: UIImageView!
    
    @IBOutlet var likeControl: LikeControl!
    @IBOutlet weak var containerView: UIView!
    
    
    override func awakeFromNib() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap ))
        tap.numberOfTapsRequired = 2
        containerView.addGestureRecognizer(tap)
    }

    @objc func handleTap(_: UITapGestureRecognizer) {
        likeControl.isLiked.toggle()

        if likeControl.isLiked {
            likeControl.likePicture.image = UIImage(systemName: "suit.heart.fill")
        } else {
            likeControl.likePicture.image = nil
        }
    }

}
