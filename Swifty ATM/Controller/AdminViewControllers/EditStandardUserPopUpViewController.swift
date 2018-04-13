//
//  InsertMenu.swift
//  Swifty ATM
//
//  Created by Gentian Barileva on 4/7/18.
//  Copyright © 2018 Gentian Barileva. All rights reserved.
//

import UIKit
import SVProgressHUD

class EditStandardUsersPopUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: AddUsersTextField!
    @IBOutlet weak var accountPINTextField: AddUsersTextField!
    @IBOutlet weak var accountBalanceTextField: AddUsersTextField!
    @IBOutlet weak var surnameTextField: AddUsersTextField!
    @IBOutlet weak var accountIDTextField: AddUsersTextField!
    
    lazy var updateButton = UIButton(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60))
    
    let refUserArrayCopy = DataSource.instance.userArrayCopy
    let refEditStandardUserIndex = DataSource.instance.editAdmindUserIndex
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        accountPINTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        accountBalanceTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        surnameTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        accountIDTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        
        updateButton.backgroundColor = UIColor.orange
        updateButton.setTitle("Update User", for: .normal)
        updateButton.setTitleColor(UIColor.white, for: .normal)
        updateButton.addTarget(self, action: #selector(CreateStandardUsersPopUpViewController.insertUsersToFIRBase), for: .touchUpInside)
        updateButton.isHidden = true
        updateButton.isEnabled = false
        
        nameTextField.inputAccessoryView = updateButton
        accountPINTextField.inputAccessoryView = updateButton
        accountBalanceTextField.inputAccessoryView = updateButton
        surnameTextField.inputAccessoryView = updateButton
        accountIDTextField.inputAccessoryView = updateButton
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        nameTextField.text = refUserArrayCopy[refEditStandardUserIndex].userName
        accountPINTextField.text = String(refUserArrayCopy[refEditStandardUserIndex].userAccountPIN)
        accountBalanceTextField.text = String(refUserArrayCopy[refEditStandardUserIndex].userBalance)
        surnameTextField.text = refUserArrayCopy[refEditStandardUserIndex].userSurname
        accountIDTextField.text = refUserArrayCopy[refEditStandardUserIndex].userAccountNumber
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func insertUsersToFIRBase(){
        view.endEditing(true)
        
        refUserArrayCopy[refEditStandardUserIndex].userName = nameTextField.text!
        refUserArrayCopy[refEditStandardUserIndex].userAccountPIN = accountPINTextField.text!
        refUserArrayCopy[refEditStandardUserIndex].userBalance = Int(accountBalanceTextField.text!)!
        refUserArrayCopy[refEditStandardUserIndex].userSurname = surnameTextField.text!
        refUserArrayCopy[refEditStandardUserIndex].userAccountNumber = accountIDTextField.text!
    
        DataSource.instance.updateStandardUserAt(location: refEditStandardUserIndex)
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
            let name = nameTextField.text, !name.isEmpty,
            let accPIN = accountPINTextField.text, !accPIN.isEmpty,
            let accBal = accountBalanceTextField.text, !accBal.isEmpty,
            let surname = surnameTextField.text, !surname.isEmpty,
            let accID = accountIDTextField.text, !accID.isEmpty
            else {
                updateButton.isEnabled = false
                updateButton.isHidden = true
                return
        }
        updateButton.isHidden = false
        updateButton.isEnabled = true
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
