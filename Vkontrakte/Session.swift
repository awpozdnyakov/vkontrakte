//
//  Session.swift
//  Vkontrakte
//
//  Created by Andrey Pozdnyakov on 08.12.2022.
//

import Foundation


class Session{
    
    static let shared = Session()
    private init(){
        
    }
    
    var userID = 0
    var token = ""
    
//    func getToken(){
//        self.token = UUID().uuidString
//    }
    
}
