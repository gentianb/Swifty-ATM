//
//  DataSource.swift
//  Swifty ATM
//
//  Created by Gentian Barileva on 3/22/18.
//  Copyright © 2018 Gentian Barileva. All rights reserved.
//

import Foundation
import Firebase
import SVProgressHUD

class DataSource{
    static let instance = DataSource()
    //let generalOptsRef = AdminOptionGeneralBalanceViewController()
    
    var standardUsersFIRDict: Dictionary<String, String> = [String: String]()
    var adminUsersFIRDict: Dictionary<String, String> = [String: String]()
    var userArray: [StandardUser] = [StandardUser]()
    var userArrayCopy: [StandardUser] = [StandardUser]()
    var adminArray: [AdminUser] = [AdminUser]()
    var adminArrayCopy: [AdminUser] = [AdminUser]()
    var editStandardUserIndex = Int()
    var editAdmindUserIndex = Int()
    var standardUserLoggedInIndex: Int = 0
    
    let adminOptions = [
        AdminOptions.init(optionTitle: "General Balance", optionSubTitle: "Can view users with various balances."),
        AdminOptions.init(optionTitle: "Search Users", optionSubTitle: "Via Name, Surname or both."),
        AdminOptions.init(optionTitle: "Edit Users", optionSubTitle: "Here you can add Admins, Standard users, edit or delete them .")]
    
    func startStandardUserFIRObserve(){
        
        Database.database().reference().child("Users").observe(.childAdded, with: { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            self.standardUsersFIRDict[snapshotValue["userAccountNumber"]!] = snapshotValue["userAccountPIN"]!
            print(snapshot.key)
            
            let usrNm = snapshotValue["userName"]!
            let usrSrn = snapshotValue["userSurname"]!
            let usrAccNr = snapshotValue["userAccountNumber"]!
            let usrPIN = snapshotValue["userAccountPIN"]!
            let usrBlnc = snapshotValue["userBalance"]!
            
            let user = StandardUser()
            user.userAccountNumber = usrAccNr
            user.userAccountPIN = usrPIN
            user.userBalance = Int(usrBlnc)!
            user.userName = usrNm
            user.userSurname = usrSrn
            user.userFireBaseID = snapshot.key
            
            self.userArray.append(user)
            self.userArrayCopy.append(user)
            
            // self.generalOptsRef.retrieveNewData()
            
            //userAccountNumber" : "10201", "userAccountPIN" : "1111", "userName" : "Test", "userSurname" : "Tset", "userBalance" : "50" ])
            print("Data Added")
        })
    }
    
    func startAdminUserFIRObserve(){
        
        Database.database().reference().child("Admins").observe(.childAdded, with: { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            self.adminUsersFIRDict[snapshotValue["userName"]!] = snapshotValue["userPassword"]!
            print(snapshot.key)
            
            let usrNm = snapshotValue["userName"]!
            let usrPw = snapshotValue["userPassword"]!
            
            
            let user = AdminUser()
            user.userName = usrNm
            user.userPassword = usrPw
            user.userFireBaseID = snapshot.key
            
            self.adminArray.append(user)
            self.adminArrayCopy.append(user)
            
            // self.generalOptsRef.retrieveNewData()
            
            //userAccountNumber" : "10201", "userAccountPIN" : "1111", "userName" : "Test", "userSurname" : "Tset", "userBalance" : "50" ])
            print(usrNm)
        })
    }
    
    func refreshData(){
        userArrayCopy = userArray
        print("data refreshed!")
    }
    
    func addStandardUser(userName: String, userSurname: String, userAccNumber: String, userAccPIN: String, userBalance: String){
        let ref = Database.database().reference().child("Users/\(userAccNumber)")
        //        ref.childByAutoId().setValue(["userAccountNumber" : "\(userAccNumber)", "userAccountPIN" : "\(userAccPIN)", "userName" : "\(userName)", "userSurname" : "\(userSurname)" , "userBalance" : "\(userBalance)"])
        ref.setValue(["userAccountNumber" : "\(userAccNumber)", "userAccountPIN" : "\(userAccPIN)", "userName" : "\(userName)", "userSurname" : "\(userSurname)" , "userBalance" : "\(userBalance)"]) { (err, ref) in
            SVProgressHUD.setStatus("Success")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
    
    func addAdminUser(userName: String, userPassword: String){
        let ref = Database.database().reference().child("Admins")
        //        ref.childByAutoId().setValue(["userAccountNumber" : "\(userAccNumber)", "userAccountPIN" : "\(userAccPIN)", "userName" : "\(userName)", "userSurname" : "\(userSurname)" , "userBalance" : "\(userBalance)"])
        ref.childByAutoId().setValue(["userName" : "\(userName)", "userPassword" : "\(userPassword)"]) { (err, ref) in
            SVProgressHUD.setStatus("Success")
            SVProgressHUD.dismiss(withDelay: 2)
        }
    }
    
    
    func updateStandardUserAt(location: Int){
        let ref = Database.database().reference().child("Users")
        
        ref.child(userArrayCopy[location].userFireBaseID).setValue(
            ["userAccountNumber" : "\(userArrayCopy[location].userAccountNumber)",
                "userAccountPIN" : "\(userArrayCopy[location].userAccountPIN)",
                "userName" : "\(userArrayCopy[location].userName)",
                "userSurname" : "\(userArrayCopy[location].userSurname)" ,
                "userBalance" : "\(userArrayCopy[location].userBalance)"]) { (err, ref) in
                    SVProgressHUD.setStatus("Success")
                    SVProgressHUD.dismiss(withDelay: 2)
        }
    }
    func updateAdminUserAt(location: Int){
        let ref = Database.database().reference().child("Admins")
        ref.child(adminArrayCopy[location].userFireBaseID).setValue(
            ["userName" : "\(adminArrayCopy[location].userName)",
                "userPassword" : "\(adminArrayCopy[location].userPassword)"]) { (err, ref) in
                    SVProgressHUD.setStatus("Success")
                    SVProgressHUD.dismiss(withDelay: 2)
        }
    }
    
    func removeFIRBaseValueAndLocalValue(at valId: Int,case caseNum: Int){
        switch caseNum {
        case 0:
            Database.database().reference().child("Users").child(userArrayCopy[valId].userFireBaseID).removeValue()
            userArrayCopy.remove(at: valId)
        case 1:
            Database.database().reference().child("Admins").child(adminArrayCopy[valId].userFireBaseID).removeValue()
            adminArrayCopy.remove(at: valId)
        default:
            break
        }
        
    }
    
    func sortBy(case num: Int){
        userArrayCopy = userArray
        switch num {
        case 1:
            //if ==0
            for (index, _) in userArrayCopy.enumerated().reversed() {
                if(userArrayCopy[index].userBalance==0){
                    //
                }else{
                    userArrayCopy.remove(at: index)
                }
            }
        case 2:
            //if >0
            for (index, _) in userArrayCopy.enumerated().reversed() {
                if(userArrayCopy[index].userBalance>0){
                    //
                }else{
                    userArrayCopy.remove(at: index)
                }
            }
        case 3:
            //if <0
            for (index, _) in userArrayCopy.enumerated().reversed() {
                if(userArrayCopy[index].userBalance<0){
                    //
                }else{
                    userArrayCopy.remove(at: index)
                }
            }
        default:
            return
        }
    }
    func searchWith(searchString: String, andCase searchCase: Int){
        userArrayCopy = userArray
        print(searchCase)
        //0 name , 1 surname, 2 both
        switch searchCase {
        case 0:
            if searchString == ""{
                userArrayCopy = [StandardUser]()
                return
            }
            for (index, _) in userArrayCopy.enumerated().reversed() {
                if(userArrayCopy[index].userName.lowercased().range(of: searchString.lowercased()) != nil){
                    //
                }else{
                    userArrayCopy.remove(at: index)
                }
            }
            
            
        case 1:
            for (index, _) in userArrayCopy.enumerated().reversed() {
                if(userArrayCopy[index].userSurname.lowercased().range(of: searchString.lowercased()) != nil){
                    //
                }else{
                    userArrayCopy.remove(at: index)
                }
            }
        case 2:
            for (index, _) in userArrayCopy.enumerated().reversed() {
                let tempUserInfo = (userArrayCopy[index].userName + " " + userArrayCopy[index].userSurname).lowercased()
                
                if( tempUserInfo.elementsEqual(searchString.lowercased())){
                    print("a o ka hin")
                    //
                }else{
                    userArrayCopy.remove(at: index)
                }
            }
        default:
            return
        }
    }
    
    //MARK: New Login Method and update methods for Standard User
    
    func logInStandardUserWith(id location: String, password: String, userLogInState: @escaping (Bool) -> ()){
        
        Database.database().reference().child("Users/\(location)").observe(.value) { (snapshot) in
            //print(snapshot.value!)
            if snapshot.value! is NSNull{
                print("null value")
                userLogInState(false)
            }
            else{
                let snapshotTest = snapshot.value as! Dictionary<String, String>
                print(snapshotTest["userAccountPIN"]!)
                print(password)
                if snapshotTest["userAccountPIN"]! == password{
                    print("Log in sucessful!")
                    
                    //save the user in a array
                    
                    self.standardUsersFIRDict[snapshotTest["userAccountNumber"]!] = snapshotTest["userAccountPIN"]!
                    print(snapshot.key)
                    
                    let usrNm = snapshotTest["userName"]!
                    let usrSrn = snapshotTest["userSurname"]!
                    let usrAccNr = snapshotTest["userAccountNumber"]!
                    let usrPIN = snapshotTest["userAccountPIN"]!
                    let usrBlnc = snapshotTest["userBalance"]!
                    
                    let user = StandardUser()
                    user.userAccountNumber = usrAccNr
                    user.userAccountPIN = usrPIN
                    user.userBalance = Int(usrBlnc)!
                    user.userName = usrNm
                    user.userSurname = usrSrn
                    user.userFireBaseID = snapshot.key
                    
                    self.userArray.append(user)
                    self.userArrayCopy.append(user)
                    userLogInState(true)
                }
                else{
                    userLogInState(false)
                }
            }}
    }
    
    func removeStandardUserObserverAndClearLocalData(){
        Database.database().reference().child("Users").removeAllObservers()
        userArray = [StandardUser]()
        userArrayCopy = [StandardUser]()
    }
    
}
