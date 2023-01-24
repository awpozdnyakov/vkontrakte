//
//  News.swift
//  Vkontrakte
//
//  Created by Andrey Pozdnyakov on 11.11.2022.
//

import UIKit

class News {
    let image: UIImage?
    let information: String
    
    init(image: UIImage? = nil, information: String) {
        self.image = image
        self.information = information
    }
}
