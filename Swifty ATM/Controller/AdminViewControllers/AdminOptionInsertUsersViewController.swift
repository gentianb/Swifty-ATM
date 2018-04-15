//
//  AdminOptionInsertUserViewController.swift
//  Swifty ATM
//
//  Created by Gentian Barileva on 3/22/18.
//  Copyright © 2018 Gentian Barileva. All rights reserved.
//

import UIKit

class AdminOptionInsertUsersViewController: UIViewController {
    
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Insert Users"
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self

    }
    
    @IBAction func insertButtonPressed(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            performSegue(withIdentifier: "goToInsertPopUp", sender: self)
        case 1:
            performSegue(withIdentifier: "goToCreateAdmin", sender: self)
        default:
            break
        }
    }
    
    @IBAction func segmentPressed(_ sender: Any) {
        tableView.reloadData()
        print(segmentControl.selectedSegmentIndex)
    }
    override func viewWillAppear(_ animated: Bool) {
        DataSource.instance.refreshData()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func unwindfromInsertUserVC(unwindSegue: UIStoryboardSegue){
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}


extension AdminOptionInsertUsersViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            return DataSource.instance.userArrayCopy.count
        case 1:
            return DataSource.instance.adminArrayCopy.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            createButton.setTitle("Create Standard User", for: .normal)
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? InsertUsersCell{
                cell.updateInfo(info: "\(DataSource.instance.userArrayCopy[indexPath.row].userAccountNumber) \(DataSource.instance.userArrayCopy[indexPath.row].userAccountPIN) \(DataSource.instance.userArrayCopy[indexPath.row].userBalance) \(DataSource.instance.userArrayCopy[indexPath.row].userName) \(DataSource.instance.userArrayCopy[indexPath.row].userSurname)")
                return cell}
        case 1:
            createButton.setTitle("Create Admin User", for: .normal)
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? InsertUsersCell{
                cell.updateInfo(info: "\(DataSource.instance.adminArrayCopy[indexPath.row].userName) \(DataSource.instance.adminArrayCopy[indexPath.row].userPassword)")
                return cell}
        default:
            break
        }
        //        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? InsertUsersCell{
        //            cell.updateInfo(info: "\(DataSource.instance.userArrayCopy[indexPath.row].userAccountNumber) \(DataSource.instance.userArrayCopy[indexPath.row].userAccountPIN) \(DataSource.instance.userArrayCopy[indexPath.row].userBalance) \(DataSource.instance.userArrayCopy[indexPath.row].userName) \(DataSource.instance.userArrayCopy[indexPath.row].userSurname)")
        //            return cell
        //        }
        return InsertUsersCell()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            //print(DataSource.instance.userArrayCopy[indexPath.row].userFireBaseID)
            DataSource.instance.removeFIRBaseValueAndLocalValue(at: indexPath.row, case: self.segmentControl.selectedSegmentIndex)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            // tableView.delete
        }
        let editAction = UITableViewRowAction(style: .default, title: "Edit") { (rowAction, indexPath) in
            //edit some shit here
            if self.segmentControl.selectedSegmentIndex == 0{
                DataSource.instance.editStandardUserIndex = indexPath.row
                self.performSegue(withIdentifier: "showEditVC", sender: self)
            }else{
                DataSource.instance.editAdmindUserIndex = indexPath.row
                self.performSegue(withIdentifier: "goToEditAdmin", sender: self)
            }
        }
        editAction.backgroundColor = UIColor.orange
        return [deleteAction, editAction]
    }
}
