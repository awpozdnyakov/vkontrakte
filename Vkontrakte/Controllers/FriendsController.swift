//
//  FriendsController.swift
//  Vkontrakte
//
//  Created by Andrey Pozdnyakov on 02.11.2022.
//

import UIKit

class FriendsController: UITableViewController {
    
    
    let friends = [
        Friend(image: UIImage.init(named: "dron_ava"),
               name: "Ilya Dronov",
               photos: [UIImage(named: "dron_1")!,
                        UIImage(named: "dron_2")!,
                        UIImage(named: "dron_3")!,
                        UIImage(named: "dron_4")!,
                        UIImage(named: "dron_5")!]),
        Friend(image: UIImage.init(named: "kar_ava"),
               name: "Karandash",
               photos: [UIImage(named: "kar_1")!,
                        UIImage(named: "kar_2")!,
                        UIImage(named: "kar_3")!,
                        UIImage(named: "kar_4")!,
                        UIImage(named: "kar_5")!]),
        Friend(image: UIImage.init(named: "andr_ava"),
               name: "Andrew Pozdnyakov",
               photos: [UIImage(named: "andr_1")!,
                        UIImage(named: "andr_2")!,
                        UIImage(named: "andr_3")!,
                        UIImage(named: "andr_4")!,
                        UIImage(named: "andr_5")!]),
        Friend(image: UIImage.init(named: "chir_ava"),
               name: "Alex Chirkov",
               photos: [UIImage(named: "chir_1")!,
                        UIImage(named: "chir_2")!,
                        UIImage(named: "chir_3")!,
                        UIImage(named: "chir_4")!,
                        UIImage(named: "chir_5")!]),
        Friend(image: UIImage.init(named: "nat_ava"),
               name: "Nata Li",
               photos: [UIImage(named: "nat_1")!,
                        UIImage(named: "nat_2")!,
                        UIImage(named: "nat_3")!,
                        UIImage(named: "nat_4")!,
                        UIImage(named: "nat_5")!])
    ]
    
    var sortedFriends = [Character: [Friend]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sortedFriends = sort(friends: friends)
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
        
        let friend: Friend = friends[indexPath.row]
        
        cell.imageFriendsCell.image = friend.image
        cell.labelFriendsCell.text = friend.name

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
            
            destinationVC.friendsImage = friend.photos
            destinationVC.title = friend.name
        }
        
    }
    
}

     
