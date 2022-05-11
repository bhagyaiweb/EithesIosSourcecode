//
//  ChooseCategoryVC.swift
//  Eithes
//
//  Created by sumit bhardwaj on 30/07/21.
//  Copyright © 2021 Iws. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView


class ChooseCategoryVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
   // var namesArray = ["Traffic Stop","Public Assault","Private Assault","Injury Blood Loss ","Car Accident","Police Brutality","Medical Alert","Abduction","Harassment"]
    var dataArray:[JSON]?

    var selectedIcndex = 0
    var selectedCategory = "Traffic Stop"
    var category_id = "1"
    var token : String?
    var channelName : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCategoryData()
        tableView.register(UINib(nibName: "ChooseCategoryCell", bundle: nil), forCellReuseIdentifier: "ChooseCategoryCell")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.dataArray?.removeAll()
    }
    

    
   func getCategoryData() {
        if  !Reachability.isConnectedToNetwork() {
            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                return
        }
       let userid : String =  UserDefaults.standard.object(forKey: "userid") as! String ?? "0"
        
        let parameter:[String:String] = [
            "user_id": userid
        ]
        
        print("\nThe parameters for Dashboard : \(parameter)\n")
        
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.categoryList, dataDict: parameter, { (json) in
                            print(json)
                            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                            if json["status"].stringValue == "200" {

                                if let data = json["data"].array{
                                    self.dataArray = data
                                    
                                    print("DATAOFCATAGEORYLIST",self.dataArray!)
                                    
                                    DispatchQueue.main.async {
                                        self.tableView.reloadData()

                                    }
                                    //    if let feed = data["feeds"]?.array{
//                                        self.feeds = feed
//                                    }
                           
                                }
                      
                            }else {
                                Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
                                    return
                                })
                            }
//
                        }) { (error) in
                            print(error)
                            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChooseCategoryCell") as? ChooseCategoryCell
        
        if selectedIcndex == indexPath.row{
            
            cell?.lbl.backgroundColor = .blue
            self.selectedCategory = cell?.lbl.text ?? ""
            self.category_id = "\(self.dataArray?[indexPath.row]["category_id"].intValue ?? 0)"
        }else{
            cell?.lbl.backgroundColor = .black
        }
        
        cell?.selectionStyle = .none
        
        cell?.lbl.text = self.dataArray?[indexPath.row]["name"].string
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         selectedIcndex = indexPath.row
         tableView.reloadData()
    }

    
    
    @IBAction func closeBtn(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func sosButton(_ sender: Any) {
        if  !Reachability.isConnectedToNetwork() {
            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                return
        }
        var channelName = randomAlphaNumericString(length: 8)
        
        print(channelName)
        
        let parameter:[String:String] = [
            "zipcode": UserData.ZipCode,
            "user_id": "2",
            "category_id" : category_id,
            "category_name" : selectedCategory,
            "lat" : "32.33333",
            "lng" : "29.00333",
            "appID" :"5d5dd39d0ce547a5a9a3278663b8457a",
            "appCertificate" : "caca5b8fe77145efb2acde599f2e7ae6",
            "channelName" : channelName
        ]

        print("\nThe parameters for Dashboard : \(parameter)\n")

        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)

        DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.startSos, dataDict: parameter, { (json) in
                            print(json)
                            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()

                            if json["status"].stringValue == "200" {

                                if let data = json["data"].dictionary{
                                    self.token  = data["token"]?.stringValue
                                    self.channelName  = data["token"]?.stringValue

                                    print("PRINT TOKEN",self.token)
                               // let contrll = SosStartVC()
                                   // self.present(contrll, animated: true)
//                                    let vc = self.storyboard?.instantiateViewController(identifier: "SosStartVC")
//                                    vc?.modalPresentationStyle = .fullScreen
//                                    self.present(vc!, animated: true, completion: nil)
                                    
                                    DispatchQueue.main.async {
//                                        let vc = self.storyboard?.instantiateViewController(identifier: "SosStartVC")
//                                    vc?.modalPresentationStyle = .fullScreen
//                                self.present(vc!, animated: true, completion: nil)
                                                                            
                                        let livesteam = liveStreamViewController()
                                      //  livesteam.modalPresentationStyle = .fullScreen
                                        self.present(livesteam, animated: true, completion: nil)
                                    }
//                                    if let feed = data["feeds"]?.array{
//                                        self.feeds = feed
//
//                                    }

                                }

                            }else {
                                Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
                                    return
                                })
                            }
//
                        }) { (error) in
                            print(error)
                            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        }
        
//        let vc = liveStreamViewController()
//        UIApplication.shared.windows.first?.rootViewController = vc
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
        
    }
    
    func randomAlphaNumericString(length: Int) -> String {
        let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let allowedCharsCount = UInt32(allowedChars.count)
        var randomString = ""
        
        for _ in 0 ..< length {
            let randomNum = Int(arc4random_uniform(allowedCharsCount))
            let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
            let newCharacter = allowedChars[randomIndex]
            randomString += String(newCharacter)
        }
        
        return randomString
    }
}
