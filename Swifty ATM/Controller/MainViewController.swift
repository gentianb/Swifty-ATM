//
//  ViewController.swift
//  Swifty ATM
//
//  Created by Gentian Barileva on 3/19/18.
//  Copyright © 2018 Gentian Barileva. All rights reserved.
//

import UIKit
import UITextField_Shake

class MainViewController: UIViewController {


    @IBOutlet weak var userIdTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedOutsideOfTxtFields()
        navigationItem.title = "SWIFTY ATM"
        // Do any additional setup after loading the view, typically from a nib.
        }


    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.34, green:0.32, blue:1.00, alpha:1.0)
        hiddenTapsForAdminLogIn = 0
        print(DataSource.instance.adminOptions[0].optionTitle + " \(DataSource.instance.adminOptions[0].optionSubTitle)")
        DataSource.instance.removeStandardUserObserverAndClearLocalData()

    }
    private var hiddenTapsForAdminLogIn = 0
    
    @IBAction func adminViewBtn(_ sender: Any) {
        hiddenTapsForAdminLogIn += 1
        if hiddenTapsForAdminLogIn == 1{
            navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
            performSegue(withIdentifier: "goToAdminVC", sender: self)
        }
        
    }
    @IBAction func logInButton(_ sender: Any) {
/*
         for (index, element) in list.enumerated() {
         print("Item \(index): \(element)")
         }
 */
        
        DataSource.instance.logInStandardUserWith(id: userIdTxtField.text!, password: passwordTxtField.text!) { logInState in
            if logInState{
                print("Log in successful!")
                print(DataSource.instance.userArrayCopy.count)
                self.performSegue(withIdentifier: "goToStandardVC", sender: self)

            }
            else{
                print("failed login!")
                self.shakeAndChangeColorOfFields()
            }
        }
        
        
        //print(DataSource.instance.logInStandardUserWith(id: userIdTxtField.text!, password: passwordTxtField.text!))
//        var isSuccessfulLogIn = false
//        //for user in DataSource.instance.userArrayCopy
//        for (index, user) in DataSource.instance.userArrayCopy.enumerated(){
//            print(user.userAccountNumber + "   " + userIdTxtField.text!)
//            if user.userAccountNumber == userIdTxtField.text!{
//                if String(user.userAccountPIN) == passwordTxtField.text!{
//                    DataSource.instance.standardUserLoggedInIndex = index
//                    performSegue(withIdentifier: "goToStandardVC", sender: self)
//                    print("success")
//                    isSuccessfulLogIn = true
//                    break
//                }else{
//                    print(user.userAccountPIN + "   " + passwordTxtField.text!)
//                    print("fail pw")
//                }
//            }else{
//                print("fail uid")
//            }
//        }
//        if !isSuccessfulLogIn{
//            shakeAndChangeColorOfFields()
//        }
    }
    
    func shakeAndChangeColorOfFields(){
        self.userIdTxtField.layer.borderColor = UIColor.red.cgColor
        self.passwordTxtField.layer.borderColor = UIColor.red.cgColor
        self.userIdTxtField.shake(20, withDelta: 5, speed: 0.02)
        self.passwordTxtField.shake(20, withDelta: 5, speed: 0.02)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }
}
extension UIViewController {
    func hideKeyboardWhenTappedOutsideOfTxtFields() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
