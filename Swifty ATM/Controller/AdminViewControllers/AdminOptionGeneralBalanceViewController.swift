//
//  AdminOptionGeneralBalanceViewController.swift
//  Swifty ATM
//
//  Created by Gentian Barileva on 3/22/18.
//  Copyright © 2018 Gentian Barileva. All rights reserved.
//

import UIKit


class AdminOptionGeneralBalanceViewController: UIViewController {
    
   override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "General Balance"
        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
        
        tableView.delegate = self
        tableView.dataSource = self
    
    }
    
    @IBOutlet weak var tableView: UITableView!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DataSource.instance.refreshData()
    }
    
    @IBAction func segmentPressed(_ sender: UISegmentedControl) {
        DataSource.instance.sortBy(case: sender.selectedSegmentIndex)
        tableView.reloadData()
    }
    
    @objc func logOut(){
        print("log out")
        performSegue(withIdentifier: "goBackToMain", sender: self)
    }
}

extension AdminOptionGeneralBalanceViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataSource.instance.userArrayCopy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? GeneralOptionsCell{
            cell.updateInfo(info: "\(DataSource.instance.userArrayCopy[indexPath.row].userAccountNumber) \(DataSource.instance.userArrayCopy[indexPath.row].userAccountPIN) \(DataSource.instance.userArrayCopy[indexPath.row].userBalance) \(DataSource.instance.userArrayCopy[indexPath.row].userName) \(DataSource.instance.userArrayCopy[indexPath.row].userSurname)")
            return cell
        }
        return GeneralOptionsCell()
    }
}
