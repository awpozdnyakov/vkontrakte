//
//  AvatarView.swift
//  Vkontrakte
//
//  Created by Andrey Pozdnyakov on 07.11.2022.
//

import UIKit

class AvatarView: UIView {
    
    @IBOutlet var avatarImageView: UIImageView!
    @IBOutlet var shadowView: UIView!
  

    
    var shadowColor = UIColor.black
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shadowView.layer.shadowColor = shadowColor.cgColor
        shadowView.layer.shadowOffset = .zero
        shadowView.layer.shadowRadius = 5
        shadowView.layer.shadowOpacity = 0.6
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        avatarImageView.layer.cornerRadius = bounds.height/2
        shadowView.layer.cornerRadius = bounds.height/2
        
    }

}
