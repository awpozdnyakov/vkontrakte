//
//  TestRealm.swift
//  Vkontrakte
//
//  Created by Andrey Pozdnyakov on 08.01.2023.
//
import Foundation
import RealmSwift

class Entity: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var lastName = ""
    
    override class func primaryKey() -> String? {
        "id "
    }
}


