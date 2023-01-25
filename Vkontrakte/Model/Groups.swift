//
//  Groups.swift
//  Vkontrakte
//
//  Created by Andrey Pozdnyakov on 02.11.2022.
//

import UIKit

class AllGroups {
    let image: UIImage?
    let name: String

    init(image: UIImage? = nil, name: String) {
        self.image = image
        self.name = name
    }
}


struct ResponseGroups: Decodable{
    var response: Groups
}

struct Groups: Decodable{
    var items: [Group]
}

struct Group: Decodable{
    var id: Int
    var photo: String?
    var name: String

    enum CodingKeys: String, CodingKey {
        case id
        case photo = "photo_50"
        case name

    }

}
