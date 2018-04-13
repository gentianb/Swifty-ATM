//
//  EditAdminUserPopUpViewController.swift
//  Swifty ATM
//
//  Created by Gentian Barileva on 4/10/18.
//  Copyright © 2018 Gentian Barileva. All rights reserved.
//

import UIKit
import SVProgressHUD

class EditAdminUserPopUpViewController: UIViewController {

    
    @IBOutlet weak var userNameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    let instance = DataSource.instance

    
    lazy var insertUserButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameTxtField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        passwordTxtField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        
        insertUserButton.backgroundColor = UIColor.orange
        insertUserButton.setTitle("Update Admin", for: .normal)
        insertUserButton.setTitleColor(UIColor.white, for: .normal)
        insertUserButton.addTarget(self, action: #selector(CreateStandardUsersPopUpViewController.insertUsersToFIRBase), for: .touchUpInside)
        insertUserButton.isHidden = true
        insertUserButton.isEnabled = false
        
        userNameTxtField.inputAccessoryView = insertUserButton
        passwordTxtField.inputAccessoryView = insertUserButton
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        userNameTxtField.text = instance.adminArrayCopy[instance.editAdmindUserIndex].userName
        passwordTxtField.text = instance.adminArrayCopy[instance.editAdmindUserIndex].userPassword
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func insertUsersToFIRBase(){
        
        view.endEditing(true)
        SVProgressHUD.show(withStatus: "Inserting")
        
        instance.adminArrayCopy[instance.editAdmindUserIndex].userName = userNameTxtField.text!
        instance.adminArrayCopy[instance.editAdmindUserIndex].userPassword = passwordTxtField.text!
        
        instance.updateAdminUserAt(location: instance.editAdmindUserIndex)
        
    }
    
    @IBAction func closeButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "unwindToInsertMenu", sender: self)
    }
    
    @objc func editingChanged(_ textField: UITextField) {
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let name = userNameTxtField.text, !name.isEmpty,
            let accPIN = passwordTxtField.text, !accPIN.isEmpty
            else {
                insertUserButton.isEnabled = false
                insertUserButton.isHidden = true
                return
        }
        insertUserButton.isHidden = false
        insertUserButton.isEnabled = true
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
