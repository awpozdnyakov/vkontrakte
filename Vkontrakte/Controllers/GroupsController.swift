//
//  GroupsController.swift
//  Vkontrakte
//
//  Created by Andrey Pozdnyakov on 02.11.2022.
//

import UIKit
import Alamofire
import SDWebImage


class GroupsController: UITableViewController {

    let session = Session.shared
    let service = Service()
    
    var groups = [Group]()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        service.getGroups(token: session.token) {
            groups in
            self.groups = groups
            self.tableView.reloadData()
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GroupsCell", for: indexPath) as? GroupsCell else {
            preconditionFailure("Group cell can not")
        }

        let group = groups[indexPath.row]
        cell.labelGroupsCell.text = group.name
        
        if let photo = group.photo{
            cell.imageGroupsCell.sd_setImage(with: URL(string: photo))
        }
      
        return cell
    }
    
//    @IBAction func addSelectedGroup(segue: UIStoryboardSegue) {
//        if let sourceVC = segue.source as? AllGroupsController,
//           let indexPath = sourceVC.tableView.indexPathForSelectedRow {
//            let group = sourceVC.filteredGroups[indexPath.row]
//
//            if !groups.contains(where: {$0.name == group.name}) {
//                groups.append(group)
//
//                tableView.reloadData()
//            }
//        }
//    }
    
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}



//extension GroupsController {
//    
//    func getGroups() {
//        
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "api.vk.com"
//        urlComponents.path = "/method/groups.get"
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
//            do {
//                let result = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
//                print("=======================")
//                print(result)
//                print("=======================")
//            } catch {
//                print(error)
//            }
//        }.resume()
//    }
//}
