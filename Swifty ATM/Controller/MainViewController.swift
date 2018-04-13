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
        navigationItem.title = "SWIFTY ATM"
        // Do any additional setup after loading the view, typically from a nib.
        }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.34, green:0.32, blue:1.00, alpha:1.0)
        hiddenTapsForAdminLogIn = 0
        print(DataSource.instance.adminOptions[0].optionTitle + " \(DataSource.instance.adminOptions[0].optionSubTitle)")
        

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
        var isSuccessfulLogIn = false
        //for user in DataSource.instance.userArrayCopy
        for (index, user) in DataSource.instance.userArrayCopy.enumerated(){
            print(user.userAccountNumber + "   " + userIdTxtField.text!)
            if user.userAccountNumber == userIdTxtField.text!{
                if String(user.userAccountPIN) == passwordTxtField.text!{
                    DataSource.instance.standardUserLoggedInIndex = index
                    performSegue(withIdentifier: "goToStandardVC", sender: self)
                    print("success")
                    isSuccessfulLogIn = true
                    break
                }else{
                    print(user.userAccountPIN + "   " + passwordTxtField.text!)
                    print("fail pw")
                }
            }else{
                print("fail uid")
            }
        }
        if !isSuccessfulLogIn{
            shakeAndChangeColorOfFields()
        }
    }
    
    func shakeAndChangeColorOfFields(){
        self.userIdTxtField.layer.borderColor = UIColor.red.cgColor
        self.passwordTxtField.layer.borderColor = UIColor.red.cgColor
        self.userIdTxtField.shake(20, withDelta: 5, speed: 0.02)
        self.passwordTxtField.shake(20, withDelta: 5, speed: 0.02)

    }
    func test(){
        
    }
//    @IBAction func alertTest(_ sender: Any) {
////        let alert = UIAlertController(title: "Attention", message: "Are you sure you want to withdraw more than you have available?", preferredStyle: .alert)
////        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
////            print("Yes Pressed")
////        }))
////        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (_) in
////            print("No Pressed")
////        }))
////
////
////        self.present(alert, animated: true)
//
//        let alertController = UIAlertController(title: "Email?", message: "Please input your email:", preferredStyle: .alert)
//
//        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
//            if let field = alertController.textFields![0] as? UITextField {
//                if let number = Int(field.text!){
//                    print("its a number! \(number)")
//                }
//                else{
//                    print("its not a number!")
//                }
//                // store and use entered data
//
//            } else {
//
//                print("please enter email id")
//            }
//        }
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
//
//        alertController.addTextField { (textField) in
//            textField.placeholder = "Email"
//        }
//
//        alertController.addAction(confirmAction)
//        alertController.addAction(cancelAction)
//
//        self.present(alertController, animated: true, completion: nil)
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }

}

