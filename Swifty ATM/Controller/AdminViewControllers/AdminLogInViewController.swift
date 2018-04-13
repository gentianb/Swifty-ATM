//
//  AdminUserViewController.swift
//  Swifty ATM
//
//  Created by Gentian Barileva on 3/19/18.
//  Copyright © 2018 Gentian Barileva. All rights reserved.
//

import UIKit
import Firebase
import UITextField_Shake

class AdminLogInViewController: UIViewController {


    @IBOutlet weak var userNameTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataSource.instance.startAdminUserFIRObserve()

//        navigationController?.navigationBar.tintColor = UIColor.blue
//        UINavigationBar.appearance().tintColor = UIColor.blue
//        self.navigationController?.navigationBar.backgroundColor = UIColor.black
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.barTintColor = UIColor.black
        //navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        navigationItem.title = "ADMIN LOG IN"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    //used this way for standard users login but don't know how to retain the user id without iterating again through the array of users, so it's pointless, but here it works ok since every admin is the same permision wise
    @IBAction func logInPressed(_ sender: Any) {
        if DataSource.instance.adminUsersFIRDict[userNameTxtField.text!] != nil{
            if DataSource.instance.adminUsersFIRDict[userNameTxtField.text!]! == passwordTxtField.text!{
                print("Passed everything!")
                performSegue(withIdentifier: "goToAdminOptions", sender: self)
            }
            else{
                print("you messed the password")
                shakeAndChangeColorOfFields()
            }
        }
        else{
            print("you messed the userId")
            shakeAndChangeColorOfFields()
            
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func shakeAndChangeColorOfFields(){
        self.userNameTxtField.layer.borderColor = UIColor.red.cgColor
        self.passwordTxtField.layer.borderColor = UIColor.red.cgColor
        self.userNameTxtField.shake(20, withDelta: 5, speed: 0.02)
        self.passwordTxtField.shake(20, withDelta: 5, speed: 0.02)
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
