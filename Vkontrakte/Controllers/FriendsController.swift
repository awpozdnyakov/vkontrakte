//
//  FriendsController.swift
//  Vkontrakte
//
//  Created by Andrey Pozdnyakov on 02.11.2022.
//

import UIKit
import Alamofire
import SDWebImage



class FriendsController: UITableViewController {
    
    let session = Session.shared
    let service = Service()
    
    var friends = [Friend]()
    var sortedFriends = [Character: [Friend]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.getFriends(token: session.token) {
            friends in
            self.friends = friends
            self.sortedFriends = self.sort(friends: friends)
            self.tableView.reloadData()

            
        }
    }

        
    private func sort(friends: [Friend]) -> [Character: [Friend]] {

        var friendsDict = [Character: [Friend]]()

        friends.forEach() {friend in

            guard let firstChar = friend.name.first else {return}

            if var thisCharFriends = friendsDict[firstChar] {
                thisCharFriends.append(friend)
                friendsDict[firstChar] = thisCharFriends
            } else {
                friendsDict[firstChar] = [friend]
            }

        }
        return friendsDict
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sortedFriends.keys.count
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        let keySorted = sortedFriends.keys.sorted()
        let friends = sortedFriends[keySorted[section]]?.count ?? 0
        
        return friends
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell", for: indexPath) as? FriendsCell else {
            preconditionFailure("FriendsCell can not")
        }
        
        let firstChar = sortedFriends.keys.sorted()[indexPath.section]
        let friends = sortedFriends[firstChar]!

        let friend = friends[indexPath.row]
        cell.labelFriendsCell?.text = friend.name + " " + friend.surname

        if let photo = friend.photo{
            cell.imageFriendsCell.sd_setImage(with: URL(string: photo))
        }
        

        return cell
    }

    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(sortedFriends.keys.sorted()[section])
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FriendsPhoto",
           let destinationVC = segue.destination as? AllPhotoController,
           let indexPath = tableView.indexPathForSelectedRow {
            
            let firstChar = sortedFriends.keys.sorted()[indexPath.section]
            let friends = sortedFriends[firstChar]!
            let friend: Friend = friends[indexPath.row]
            
            destinationVC.title = friend.name + " " + friend.surname
        }
        
    }
    
}



//extension FriendsController {
//
//    func getFriends(completion: @escaping ((Result <Friend, Error>) -> ())) {
//
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "api.vk.com"
//        urlComponents.path = "/method/friends.get"
//        urlComponents.queryItems = [
//            URLQueryItem(name: "user_id", value: String(Session.shared.userID)),
//            URLQueryItem(name: "access_token", value: Session.shared.token),
//            URLQueryItem(name: "v", value: "5.131")
//        ]
//
//        guard let url = urlComponents.url else { return }
//
//        let request = URLRequest(url: url)
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print(error)
//            }
//            guard let data = data else {
//                return
//            }
//            let decoder = JSONDecoder()
//            do {
//                let result = try decoder.decode(Friend.self, from: data)
//                completion(.success(result))
//            } catch {
//                print(error)
//            }
//        }.resume()
//    }
//}

