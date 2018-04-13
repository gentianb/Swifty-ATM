//
//  AdminUserViewController.swift
//  Swifty ATM
//
//  Created by Gentian Barileva on 3/20/18.
//  Copyright © 2018 Gentian Barileva. All rights reserved.
//

import UIKit

class AdminOptionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DataSource.instance.adminOptions.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? UserCell{
            cell.updateLabel(with: DataSource.instance.adminOptions[indexPath.row].optionTitle, and: DataSource.instance.adminOptions[indexPath.row].optionSubTitle)
            return cell
        }
        return UserCell()
        
    }
}
