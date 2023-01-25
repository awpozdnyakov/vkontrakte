//
//  AllGroupsController.swift
//  Vkontrakte
//
//  Created by Andrey Pozdnyakov on 03.11.2022.
//

import UIKit

class AllGroupsController: UIViewController {

    @IBOutlet var tableView: UITableView! {
        didSet{
            tableView.dataSource = self
        }
    }

    @IBOutlet weak var searchBarAllGroups: UISearchBar! {
        didSet {
            searchBarAllGroups.delegate = self
        }
    }

    var filteredGroups = [AllGroups]()

    let groups = [
        AllGroups(image: UIImage.init(named: "Tesla"), name: "TeslaHead"),
        AllGroups(image: UIImage.init(named: "Tuning"), name: "AutoDiagnozz chip-tuning"),
        AllGroups(image: UIImage.init(named: "Solyanka"), name: "Solyanka"),
        AllGroups(image: UIImage.init(named: "Jest"), name: "Жесть по-архангельски"),
        AllGroups(image: UIImage.init(named: "Swift"), name: "The Swift Developers")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        filteredGroups = groups

//        searchGroups()

    }
}

extension AllGroupsController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredGroups.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllGroupsCell", for: indexPath)

        var content = cell.defaultContentConfiguration()

        content.image = filteredGroups[indexPath.row].image
        content.text = filteredGroups[indexPath.row].name

        content.imageProperties.maximumSize = CGSize(width: 100, height: 100)
        content.imageToTextPadding = CGFloat(20)
        content.textProperties.font = UIFont(name: "Kefa", size: 17)!

        cell.contentConfiguration = content

        return cell
    }
}


extension AllGroupsController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText.isEmpty {
            filteredGroups = groups
        } else {
            filteredGroups = groups.filter {$0.name.contains(searchText)}
        }

        tableView.reloadData()

    }
}



//extension AllGroupsController {
//    
//    func searchGroups() {
//        
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "api.vk.com"
//        urlComponents.path = "/method/groups.search"
//        urlComponents.queryItems = [
//            URLQueryItem(name: "q", value: "iOS-developer"),
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
