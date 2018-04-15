//
//  StandardUserViewController.swift
//  Swifty ATM
//
//  Created by Gentian Barileva on 3/19/18.
//  Copyright © 2018 Gentian Barileva. All rights reserved.
//

import UIKit

class StandardUserViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var logTxtView: UITextView!
    let currentUser = DataSource.instance.userArrayCopy[DataSource.instance.standardUserLoggedInIndex]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.logTxtView.layoutManager.allowsNonContiguousLayout = false

        // Do any additional setup after loading the view.
        welcomeLabel.text = "Welcome \(currentUser.userName)  \(currentUser.userSurname)"
        self.hideKeyboardWhenTappedOutsideOfTxtFields()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func viewBalanceButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "\(currentUser.userName)'s Balance", message: "Current Balance is: \(currentUser.userBalance)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
        }))
        self.present(alert, animated: true)
        addTextToLog(text: "\(currentUser.userName)'s Balance is: \(currentUser.userBalance).")
    }
    
    @IBAction func withdrawButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Withdraw Option", message: "Please input your desires sum:", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            if let field = alertController.textFields![0] as? UITextField {
                if let number = Int(field.text!){
                    if number>self.currentUser.userBalance{
                        print("that its too much using another alert!")
                        
                        let alert2 = UIAlertController(title: "Warning!", message: "Current Balance is lower than the desired sum, are you sure you want to proceed?", preferredStyle: .alert)
                        alert2.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (_) in
                            
                            self.currentUser.userBalance -= number
                            let alert3 = UIAlertController(title: "Current Balance", message: "Current Balance is: \(self.currentUser.userBalance)", preferredStyle: .alert)
                            DataSource.instance.updateStandardUserAt(location: DataSource.instance.standardUserLoggedInIndex)
                            alert3.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                                self.addTextToLog(text: "Requested withdraw of \(number), current balance \(self.currentUser.userBalance).")
                                print("We proceeded, and have negative balance")
                                
                            }))
                            self.present(alert3, animated: true)
                        }))
                        alert2.addAction(UIAlertAction(title: "No", style: .default, handler: { (_) in
                            print("We dont want to proceed!")
                            self.addTextToLog(text: "Action canceled.")
                        }))
                        self.present(alert2, animated: true)

                    }else{
                        self.currentUser.userBalance -= number
                        DataSource.instance.updateStandardUserAt(location: DataSource.instance.standardUserLoggedInIndex)
                        let alert2 = UIAlertController(title: "Current Balance", message: "Current Balance is: \(self.currentUser.userBalance)", preferredStyle: .alert)
                        alert2.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                            print("We have positive balance")
                            self.addTextToLog(text: "Requested withdraw of \(number), current balance \(self.currentUser.userBalance).")

                        }))
                        self.present(alert2, animated: true)

                    }}else{
                    self.addTextToLog(text: "Invalid input.")
                }
            } else {
                print("abort xd")
                self.addTextToLog(text: "Invalid input.")
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Number"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func depositButton(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Deposit", message: "Enter the sum you want to deposit:", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { (_) in
            if let field = alertController.textFields![0] as? UITextField {
                if let number = Int(field.text!){
                    self.currentUser.userBalance += number
                    DataSource.instance.updateStandardUserAt(location: DataSource.instance.standardUserLoggedInIndex)
                    self.addTextToLog(text: "Requested deposit of \(number), current balance \(self.currentUser.userBalance).")

                }
                else{
                    print("its not a number!")
                    self.addTextToLog(text: "Invalid input.")

                }
            } else {
                
                self.addTextToLog(text: "Invalid input.")
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Number"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    func addTextToLog(text txt: String)
    {
        logTxtView.text = logTxtView.text! + "\n\(txt)"
        let stringLength: Int = logTxtView.text.count
        self.logTxtView.scrollRangeToVisible(NSMakeRange(stringLength-1, 0))

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
