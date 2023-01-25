//
//  Friends.swift
//  Vkontrakte
//
//  Created by Andrey Pozdnyakov on 06.01.2023.
//

import Foundation



//Friends
struct ResponseFriends: Decodable{
    var response: Friends
}

struct Friends: Decodable{
    var items: [Friend]
}

struct Friend: Decodable{
    var id: Int
    var photo: String?
    var name: String
    var surname: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case photo = "photo_50"
        case name = "first_name"
        case surname = "last_name"
        
    }

}


//FriendsPhoto
struct ResponsePhotos: Decodable{
    var response: Photos
}

struct Photos: Decodable{
    var items: [Photo]
}

struct Photo: Decodable{
    var sizez: [Size]?
}

struct Size: Decodable{
    var url: String?
}
