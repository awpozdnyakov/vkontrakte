//
//  Service.swift
//  Vkontrakte
//
//  Created by Andrey Pozdnyakov on 06.01.2023.
//

import Foundation
import Alamofire



class Service {
    
    let baseUrl = "https://api.vk.com/method"
    
    //Получение списка друзей
    func getFriends(token: String, completion: @escaping ([Friend]) -> ()){
        let url = baseUrl + "/friends.get"
        
        let param: Parameters = [
            "access_token":token,
            "count":10,
            "fields":"city, photo_50",
            "v":"5.131"
        ]
        
        AF.request(url, method: .post, parameters: param).response { result in
            if let data = result.data{
                if let friends = try? JSONDecoder().decode(ResponseFriends.self, from: data).response.items {
                    completion(friends)
                }
            }
        }
    }
    
    //Получение всех фото выбранного друга
    func getAllPhoto(token: String, completion: @escaping ([Photo]) -> ()){
        let url = baseUrl + "/photos.getAll"

        let param: Parameters = [
            "access_token":token,
            "owner_id":Friend.CodingKeys.id,
            "v":"5.131"
        ]

        AF.request(url, method: .post, parameters: param).response { result in
            if let data = result.data{
                if let photo = try? JSONDecoder().decode(ResponsePhotos.self, from: data).response.items {
                    completion(photo)
                }
            }
        }
    }
    //Получение групп пользователя
    func getGroups(token: String, completion: @escaping ([Group]) -> ()){
        let url = baseUrl + "/groups.get"

        let param: Parameters = [
            "access_token":token,
            "count":15,
            "extended":1,
            "v":"5.131"
        ]

        AF.request(url, method: .post, parameters: param).response { result in
            if let data = result.data{
                if let groups = try? JSONDecoder().decode(ResponseGroups.self, from: data).response.items {
                    completion(groups)
                }
            }
        }
    }
}
