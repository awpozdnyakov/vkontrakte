//
//  LikeControl.swift
//  Vkontrakte
//
//  Created by Andrey Pozdnyakov on 07.11.2022.
//

import UIKit

class LikeControl: UIControl {

    @IBOutlet var likePicture: UIImageView!
    
    var isLiked: Bool = false
    
    override func awakeFromNib() {
        likePicture.backgroundColor = .clear
        likePicture.tintColor = .red
    }
}
