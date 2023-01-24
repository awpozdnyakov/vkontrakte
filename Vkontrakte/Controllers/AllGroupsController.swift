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
    
    var filteredGroups = [Groups]()
    
    let groups = [
        Groups(image: UIImage.init(named: "Tesla"), name: "TeslaHead"),
        Groups(image: UIImage.init(named: "Tuning"), name: "AutoDiagnozz chip-tuning"),
        Groups(image: UIImage.init(named: "Solyanka"), name: "Solyanka"),
        Groups(image: UIImage.init(named: "Jest"), name: "Жесть по-архангельски"),
        Groups(image: UIImage.init(named: "Swift"), name: "The Swift Developers")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        filteredGroups = groups
        
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
