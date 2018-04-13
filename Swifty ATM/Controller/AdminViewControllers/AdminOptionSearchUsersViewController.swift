//
//  AdminOptionSearchUsersViewController.swift
//  Swifty ATM
//
//  Created by Gentian Barileva on 3/22/18.
//  Copyright © 2018 Gentian Barileva. All rights reserved.
//

import UIKit

class AdminOptionSearchUsersViewController: UIViewController, UISearchBarDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let userArrayCopy = DataSource.instance.userArrayCopy
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search Users"
        // Do any additional setup after loading the view.
        searchBar.delegate = self
        
        tableView.dataSource = self
        tableView.delegate = self
        
        DataSource.instance.searchWith(searchString: searchBar.text!, andCase: searchBar.selectedScopeButtonIndex)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
        DataSource.instance.searchWith(searchString: searchBar.text!, andCase: searchBar.selectedScopeButtonIndex)
        tableView.reloadData()
    }

}

extension AdminOptionSearchUsersViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataSource.instance.userArrayCopy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? SearchUsersOptionCell{
            cell.updateInfo(info: "\(userArrayCopy[indexPath.row].userAccountNumber) \(userArrayCopy[indexPath.row].userAccountPIN) \(userArrayCopy[indexPath.row].userBalance) \(userArrayCopy[indexPath.row].userName) \(userArrayCopy[indexPath.row].userSurname)")
            return cell
        }
        return SearchUsersOptionCell()
    }
}
