//
//  SerachingVC.swift
//  Eithes
//
//  Created by Shubham Tomar on 23/03/20.
//  Copyright © 2020 Iws. All rights reserved.


import UIKit
import TweeTextField
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
import DropDown


class SerachingVC: UIViewController {
    

    
    @IBOutlet weak var catOutlet: UIButton!
    
    @IBOutlet weak var categoryListTF: TweeActiveTextField!
    
    var zipCodesArr = ["27212","201302","90001","376688","110096","201301"]

    var dataArray:[JSON]?
    var catNameArr : [String] = []
    var catIDArr : [Int] = []
    var catID : Int = 0
//    let dropDown = DropDown()
    let zipcodeDropdown = DropDown()
    let catDropdown = DropDown()

    

    
    @IBOutlet weak var locationBtn: UIButton!

    @IBOutlet weak var locationTF: TweeActiveTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.catOutlet.addSubview(catDropdown)

       // let height: CGFloat = self.dropDown.frame.size.height
       //    let width: CGFloat = self.dropDown.frame.size.width
       // dropDown.frame = CGRect(x: 0, y: 0, width: 30, height: 30)

        locationBtn.setTitle("", for: .normal)
        catOutlet.setTitle("", for: .normal)
//        dropDown.anchorView = (categoryListTF.text as? AnchorView)
//        dropDown.dataSource = zipCodesArr
////        self.locationTF.inputView = zipcodedropdown
//        self.categoryListTF.inputView = zipcodedropdown

      //  if (self.locationTF.text != nil) == isFirstResponder {
           
//            dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
//                self.locationTF?.text = zipCodesArr[index]
//             // }
//
//        }
        getcateogryList()

    }
    
   

    
    
    @IBAction func onPressclosedbtn(_ sender: UIButton)
    {
   // self.navigationController?.popViewController(animated: true)
        if (self.locationTF.text != "") && (self.categoryListTF.text != "") {
            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please click on search")
            
        }else{
            self.dismiss(animated: false, completion: nil)

        }
    }
    
    
    @IBAction func locationBtnAction(_ sender: UIButton) {
        
      
            zipcodeDropdown.anchorView = (locationTF as? AnchorView)
            
            zipcodeDropdown.dataSource = zipCodesArr
         //   zipcodeDropdown.direction = .top

            zipcodeDropdown.show()
            zipcodeDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.locationTF?.text = zipCodesArr[index]
             // }
        }
            
        
       
       
    }
    
    
    @IBAction func catBtnAction(_ sender: UIButton) {
        if (locationTF.text!.isEmpty){
            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please select zipcode!")
        }else{
            self.catOutlet.addSubview(catDropdown)

            catDropdown.anchorView = (categoryListTF as? AnchorView)

            catDropdown.dataSource = catNameArr
            
         //   catDropdown.updateConstraints()

            catDropdown.cellHeight = 50
            catDropdown.show()

            catDropdown.selectionAction = { [unowned self] (index: Int, item: String) in
                self.categoryListTF?.text = catNameArr[index]
             // }
        }
            
        }
        
    }
    
    @IBAction func searchBttnAction(_ sender: Any) {
        
        if (locationTF.text == "") && (categoryListTF.text == "") {
            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please Select Zipcode & Category!")
        }
        
        
        if  (categoryListTF.text == "") {
            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please Select Category!")
        }else{
            let vc1 = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "DashboarethisVC") as! DashboarethisVC
           //vc.modalPresentationStyle = .fullScreen
            vc1.zipcodeStr = (self.locationTF?.text!)!
           // vc1.categoryID = (self.categoryListTF?.text!)!
            self.catID
            vc1.categoryID = self.catID
           // vc1.zipcodeStr = vc1.self.pinCodeLbl?.text! ?? ""
           // self.locationTF?.text! = vc1.zipcodeStr
          //  self.categoryListTF.text! = vc1.categoryID
            print("LOCATION",(self.locationTF?.text!)!)
            print("LOCATION123",vc1.zipcodeStr!)
            (vc1.zipcodeStr!) = vc1.self.pinCodeLbl?.text! ?? ""
           // (vc1.zipcodeStr!).append(vc1.self.pinCodeLbl.text ?? "")
        //    print("actid", (vc1.self.pinCodeLbl?.text!))

            
            let  userDefaultstwitter  = UserDefaults.standard
            userDefaultstwitter.setValue((self.locationTF?.text!)!, forKey: "zipcodeuse")as? String
             UserDefaults.standard.synchronize()
            print("LOCATION1234",(self.locationTF?.text!)!)
        let strv =   UserDefaults.standard.object(forKey: "zipcodeuse") as? String
            print("CATEGORYpinlbl",strv!)
            print("CATEGORY",(self.categoryListTF?.text!)!)
            print("LOCATION",vc1.categoryID)
            print("CATIS",self.catID)
            self.present(vc1, animated: true, completion: nil)
        }
        
//        if  !Reachability.isConnectedToNetwork() {
//            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
//                return
//        }

     //   self.navigationController?.popViewController(animated: true)
    
    }
    
   
    
func getcateogryList()   {
         if  !Reachability.isConnectedToNetwork() {
             Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                 return
         }
        let userid : String =  UserDefaults.standard.object(forKey: "userid") as! String ?? "0"
         
         let parameter:[String:String] = [
             "user_id": userid
         ]
         
         print("\nThe parameters for Dashboard category1234: \(parameter)\n")
         
         let activityData = ActivityData()
         NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
         DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.categoryList, dataDict: parameter, { (json) in
                             print(json)
                             NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                             if json["status"].stringValue == "200" {

                                 if let data = json["data"].array{
                                     self.dataArray = data
                                
                                     print("DATAOFCATAGEORYLIST",self.dataArray!)
                                     print("CATNAME",self.catNameArr)

                                     for i in 0..<(self.dataArray!.count) {
                                       let newcode = data[i]["name"].stringValue
                                       self.catNameArr.append(newcode)
                                       print("CATNAMEARR",self.catNameArr)
                                         self.catID = data[i]["category_id"].intValue ?? 0
                                         self.catIDArr.append(self.catID)
                                         print("CATIDARR",self.catIDArr)
                               }
                                
//                                     DispatchQueue.main.async {
//                                        // self.zipcodedropdown.delegate = self
//                                        // self.zipcodedropdown.dataSource = self
//                                       //  self.zipcodedropdown.reloadAllComponents()
//
//                                     }
//
                                 }
                       
                             }else {
                                 Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
                                     return
                                 })
                             }
             
                         }) { (error) in
                             print(error)
                             NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                         }
     }
    
    
    
    
    
    
    
    
}
