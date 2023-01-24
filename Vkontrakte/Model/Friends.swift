//
//  Friends.swift
//  Vkontrakte
//
//  Created by Andrey Pozdnyakov on 03.11.2022.
//

import UIKit

class Friend {
    let image: UIImage?
    let name: String
    var photos: [UIImage] = []
    
    init(image: UIImage? = nil, name: String, photos: [UIImage]) {
        self.image = image
        self.name = name
        self.photos = photos
    }
}
