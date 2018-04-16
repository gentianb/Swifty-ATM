//
//  AdminUserViewController.swift
//  Swifty ATM
//
//  Created by Gentian Barileva on 3/20/18.
//  Copyright © 2018 Gentian Barileva. All rights reserved.
//

import UIKit

class AdminOptionsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        print("a hin qdoher? ---------")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOut))
        DataSource.instance.startStandardUserFIRObserve()
        //ndoshta kta duhet me e qit ne viewWillAppear
    }
    @objc func logOut(){
        print("log out")
        performSegue(withIdentifier: "goBackToMain", sender: self)
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
}
extension AdminOptionsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataSource.instance.adminOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AdminOptionsCell{
            cell.updateLabel(with: DataSource.instance.adminOptions[indexPath.row].optionTitle, and: DataSource.instance.adminOptions[indexPath.row].optionSubTitle)
            return cell
        }
        return AdminOptionsCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            performSegue(withIdentifier: "goToGeneral", sender: self)
        case 1:
            performSegue(withIdentifier: "goToSearch", sender: self)
        case 2:
            performSegue(withIdentifier: "goToInsert", sender: self)
        default:
            print(indexPath.row)
        }
    }
}

