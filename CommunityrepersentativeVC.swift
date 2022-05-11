
//  CommunityrepersentativeVC.swift
//  Created by Shubham Tomar on 23/03/20.
//  Copyright © 2020 Iws. All rights reserved.
//CommunityRepresentativeElectedOffical
import UIKit
import NVActivityIndicatorView
import Alamofire
import SwiftyJSON
import Kingfisher
import MessageUI


class CommunityrepersentativeVC: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout ,UITableViewDelegate,UITableViewDataSource,MyCellDelegate1,MyCellDelegate2,CommuntyReprsentativeTablecellDelegate, MFMessageComposeViewControllerDelegate{
    func locationBtnTapped(cell: CommuntyReprsentativeTablecell) {
        print("locationBttnTapped")
    }
    
    func deletebtnTapped(cell: CommuntyReprsentativeTablecell) {
        print("deleteBttnTapped")
    }
    
    
    
    @IBOutlet weak var communityRepresentativeTable: UITableView!
    @IBOutlet weak var NameCollectionView: UICollectionView!
     var buttonTitleName = "Police Department Employee"
    @IBOutlet weak var ZipCodeLbl: UILabel!
    
    @IBOutlet weak var communtyReprsentativeTop: NSLayoutConstraint!
    var employeeNameaArray = ["Police Department Employee","Fire Department Employee","Elected Officials","Government Employee"]
    var namelbl = ["Adam Birkett","Nic Amaya","Zac Ong","Zac Ong","Justin Snyder","Adam Birkett","Zac Ong","Zac Ong","Adam Birkett","Adam Birkett"]
     var nameTitle = ""
    var placeNameArray = ["State","Town","City"]
    var backgroundImageArray = ["rectangle-1","Townrectangle-2","Cityrectangle"]
    var placeImageArray = ["map","town_map","CityMapImage"]
    var describedlbl = ["Govt elected officials in your State."," Govt elected officials in your Town.","Govt elected officials in your City."]
    var collection:Array<JSON>?
    var indexpath:IndexPath?
    var selectRow = 0
    var commuZipcodestr : String?
    
 var newcell = Tabcollectioncell()
  
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
        reginib()

       
        communityRepresentativeTable.delegate = self as UITableViewDelegate
        communityRepresentativeTable.dataSource = (self as UITableViewDataSource)
      //  self.communityRepresentativeTable.isHidden = false

       self.communityRepresentativeTable.separatorStyle = .none
        self.communityRepresentativeTable.tableFooterView = UIView()
        getPoliceDepartment()
        self.communityRepresentativeTable.reloadData()
        self.communityRepresentativeTable.isHidden = false
        self.communityRepresentativeTable.isUserInteractionEnabled = true

//        if  buttonTitleName == "Police Department Employee" {
//            getPoliceDepartment()
//            self.communityRepresentativeTable.isHidden = false
//            self.communityRepresentativeTable.reloadData()
//
//        }

//        getPoliceDepartment()
//        self.communityRepresentativeTable.isHidden = false
//        self.communityRepresentativeTable.reloadData()


     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.ZipCodeLbl.text = commuZipcodestr
       // reginib()
        //self.communityRepresentativeTable.reloadData()
        
                


 
    }
    
    @IBAction func onpressedSearchBtn(_ sender: Any)
    {
        let vc = UIStoryboard.init(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier: "SerachingVC") as? SerachingVC
        self.present(vc!, animated: true)        //self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func onPresssedBackArrowBtn(_ sender: Any)
    {
       // self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func onPressedSosBtn(_ sender: Any)
    {
      //  let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CommunityRepresentativeElectedOffical") as? CommunityRepresentativeElectedOffical
//        let cat = self.storyboard?.instantiateViewController(identifier: "CommunityRepresentativeElectedOffical")
//
//        self.present(cat!, animated: true)
      //   self.navigationController?.pushViewController(vc!, animated: true)
        
        
        let cat = self.storyboard?.instantiateViewController(identifier: "ChooseCategoryVC")
        cat?.modalPresentationStyle = .fullScreen
        self.present(cat!, animated: true, completion: nil)

        
    }
    
    func reginib()
            
        {
            let nib = UINib(nibName: "Tabcollectioncell", bundle: nil)
            NameCollectionView.register(nib, forCellWithReuseIdentifier: "Tabcollectioncell")
             let nib2 = UINib(nibName: "CommuntyReprsentativeTablecell", bundle: nil)
            communityRepresentativeTable.register(nib2, forCellReuseIdentifier: "CommuntyReprsentativeTablecell")
            let nib3 = UINib(nibName: "ElectedOfficalStateCell", bundle: nil)
       communityRepresentativeTable.register(nib3, forCellReuseIdentifier: "ElectedOfficalStateCell")
            
        }
    
     
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return employeeNameaArray.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Tabcollectioncell", for: indexPath) as! Tabcollectioncell
                  cell.shopLiftingBtn.layer.cornerRadius = 5
        self.nameTitle = employeeNameaArray[indexPath.row]
        cell.shopLiftingBtn.setTitle(self.nameTitle, for: .normal)
           cell.delegate = self
           if   self.selectRow == indexPath.row  {
               cell.shopLiftingBtn.backgroundColor = UIColor.blue
           }else {
            cell.shopLiftingBtn.backgroundColor = UIColor.gray
        }
                    return cell
       }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let layout = collectionViewLayout as! UICollectionViewFlowLayout
          layout.minimumLineSpacing = 5.0
          layout.minimumInteritemSpacing = 2.5
        let numberOfItemsPerRow: CGFloat = 2.0; print("")

          let itemWidthtop = (collectionView.bounds.width - layout.minimumLineSpacing) / numberOfItemsPerRow
          let itemWidthdown = (collectionView.bounds.width - layout.minimumLineSpacing) / numberOfItemsPerRow
          if collectionView == NameCollectionView{
            return CGSize(width: itemWidthtop/1.1, height: 30)
          }
          return CGSize(width: itemWidthdown, height: itemWidthdown)
      }
    
    
    func onpressedShopliftingBtn(cell:Tabcollectioncell)
    {
        
        let indexpath = self.NameCollectionView.indexPath(for: cell)
        self.selectRow = indexpath?.row ?? 0
        print("SelectedRow",selectRow)
        print("indexpathsdd",indexpath?.row)
        DispatchQueue.main.async {
                 self.NameCollectionView.reloadData()
            self.getPoliceDepartment()
             self.communityRepresentativeTable.isHidden = false
            self.buttonTitleName = cell.shopLiftingBtn.titleLabel!.text!

               }
               
        
//        if selectRow == 0 {
//
////            if cell.shopLiftingBtn.titleLabel?.text == "Police Department Employee"{
////            buttonTitleName = cell.shopLiftingBtn.titleLabel!.text!
////                self.getPoliceDepartment()
////                 self.communityRepresentativeTable.isHidden = true
////
////            }
//
//           // self.communityRepresentativeTable.isHidden = true
//
//        }
//
//        if selectRow == 1 {
//                self.getFireDepartment()
//            self.communityRepresentativeTable.isHidden = true
//
//        }
//
//        if selectRow == 2 {
//            buttonTitleName = cell.shopLiftingBtn.titleLabel!.text!
//            self.communityRepresentativeTable.isHidden = false
//            self.communityRepresentativeTable.reloadData()
//
//        }
//        if selectRow == 3 {
//            buttonTitleName = cell.shopLiftingBtn.titleLabel!.text!
//            self.communityRepresentativeTable.isHidden = false
//            self.communityRepresentativeTable.reloadData()
//
//        }
      
       
        
        
        
        
////
//          if cell.shopLiftingBtn.backgroundColor == UIColor.gray
//            {
//            if cell.shopLiftingBtn.titleLabel?.text == "Police Department Employee"
//            {
//            buttonTitleName = cell.shopLiftingBtn.titleLabel!.text!
//                            self.getPoliceDepartment()
//            }
//         else if cell.shopLiftingBtn.titleLabel?.text == "Fire Department Employee"
//         {
//             buttonTitleName = cell.shopLiftingBtn.titleLabel!.text!
//             self.getFireDepartment()
//
//         }
//        else if cell.shopLiftingBtn.titleLabel?.text == "Elected Officials"
//        {
//            buttonTitleName = cell.shopLiftingBtn.titleLabel!.text!
//            self.communityRepresentativeTable.isHidden = false
//            self.communityRepresentativeTable.reloadData()
//
//        }
//        else if cell.shopLiftingBtn.titleLabel?.text == "Government Employee"
//       {
//           buttonTitleName = cell.shopLiftingBtn.titleLabel!.text!
//           self.communityRepresentativeTable.isHidden = false
//           self.communityRepresentativeTable.reloadData()
//
//       }
//         }
//        else
//         {
//             self.communityRepresentativeTable.isHidden = true
//         }
//        if cell.shopLiftingBtn.backgroundColor == .gray{
//            self.indexpath = self.NameCollectionView.indexPath(for: cell)
//           // self.NameCollectionView.reloadData()
//        }
//        else{
//            self.indexpath = nil
//          //  self.NameCollectionView.reloadData()
//        }
    }
        
// working with tableview here
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if buttonTitleName == "Police Department Employee"
        {
            return self.collection?.count ?? 0
        }
        else if buttonTitleName == "Fire Department Employee"
        {
        return self.collection?.count ?? 0
       }
        else if buttonTitleName == "Elected Officials"
        {
            return placeNameArray.count
        }
        else if buttonTitleName == "Government Employee"
        {
            return placeNameArray.count
        }
        return placeNameArray.count
        
    }
    
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if buttonTitleName == "Police Department Employee"
        {
          let cell =  tableView.dequeueReusableCell(withIdentifier: "CommuntyReprsentativeTablecell", for: indexPath) as! CommuntyReprsentativeTablecell
          //  print("cell.policeNameLbl.text",self.collection![indexPath.row]["first_name"].stringValue)

            cell.policeNameLbl.text = self.collection?[indexPath.row]["name"].stringValue

            cell.phoneNumberLbl.text = self.collection?[indexPath.row]["phone_number"].stringValue
            
            let ImgUrl = URL(string: (self.collection?[indexPath.row]["profile_pic"].stringValue)!)
            cell.userImgView.kf.setImage(with: ImgUrl)
            cell.delegate = self
        return cell
       }
        else if buttonTitleName == "Fire Department Employee"
        {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "CommuntyReprsentativeTablecell", for: indexPath) as! CommuntyReprsentativeTablecell
            cell.policeNameLbl.text = self.collection?[indexPath.row]["name"].stringValue
            cell.phoneNumberLbl.text = self.collection?[indexPath.row]["phone_number"].stringValue
            let ImgUrl = URL(string: (self.collection?[indexPath.row]["profile_pic"].stringValue)!)
            cell.userImgView.kf.setImage(with: ImgUrl)
            cell.delegate = self
            return cell
        }
        else if buttonTitleName == "Elected Officials"
        {
          let cell =  tableView.dequeueReusableCell(withIdentifier: "ElectedOfficalStateCell", for: indexPath) as! ElectedOfficalStateCell
               cell.delegate = self
            cell.img1.image = UIImage(named:backgroundImageArray[indexPath.row])
            cell.placeImage.image = UIImage(named:placeImageArray[indexPath.row])
            cell.Statelbl.text = placeNameArray[indexPath.row]
            cell.describedlbl.text = describedlbl[indexPath.row]
          return cell
        }
        else if buttonTitleName == "Government Employee"
        {
            let cell =  tableView.dequeueReusableCell(withIdentifier: "ElectedOfficalStateCell", for: indexPath) as! ElectedOfficalStateCell
            cell.delegate = self
            cell.img1.image = UIImage(named:backgroundImageArray[indexPath.row])
            cell.placeImage.image = UIImage(named:placeImageArray[indexPath.row])
            cell.Statelbl.text = placeNameArray[indexPath.row]
            cell.describedlbl.text = describedlbl[indexPath.row]
            return cell
        }
        else
        {
          let cell = UITableViewCell()
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func callbtnTapped(cell: CommuntyReprsentativeTablecell) {
        let indexPath = self.communityRepresentativeTable.indexPath(for: cell)
        let number = self.collection?[indexPath!.row]["name"].stringValue
        self.dialNumber(number: number!)
    }
    
    func messagebtnTapped(cell: CommuntyReprsentativeTablecell) {
        let indexPath = self.communityRepresentativeTable.indexPath(for: cell)
        let number = self.collection?[indexPath!.row]["name"].stringValue
        let messageVC = MFMessageComposeViewController()
        messageVC.body = "Enter a message details here";
        messageVC.recipients = [number!]
        messageVC.messageComposeDelegate = self
        self.present(messageVC, animated: true, completion: nil)
    }
    
    func onPressedForwardArrowBtn(cell: ElectedOfficalStateCell)
    {
        
        if buttonTitleName == "Elected Officials"{
            if cell.Statelbl.text! == "State"{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CommunityRepresentativeElectedOffical") as? CommunityRepresentativeElectedOffical
               
                vc?.urlEndPathType = Defines.getElectedOfficerList
                vc?.locationType = "1"
                self.present(vc!, animated: true)
               // self.navigationController?.pushViewController(vc!, animated: true)
            }
            else if cell.Statelbl.text! == "City"{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CommunityRepresentativeElectedOffical") as? CommunityRepresentativeElectedOffical
               
                vc?.urlEndPathType = Defines.getElectedOfficerList
                vc?.locationType = "3"
                self.present(vc!, animated: true)

               // self.navigationController?.pushViewController(vc!, animated: true)
            }
            else if cell.Statelbl.text! == "Town"{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CommunityRepresentativeElectedOffical") as? CommunityRepresentativeElectedOffical
               
                vc?.urlEndPathType = Defines.getElectedOfficerList
                vc?.locationType = "2"
                self.present(vc!, animated: true)

               // self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
        if buttonTitleName == "Government Employee"{
            if cell.Statelbl.text! == "State"{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CommunityRepresentativeElectedOffical") as? CommunityRepresentativeElectedOffical
               
                vc?.urlEndPathType = Defines.getGovernmentEmployee
                vc?.locationType = "1"
                self.present(vc!, animated: true)

               // self.navigationController?.pushViewController(vc!, animated: true)
            }
            else if cell.Statelbl.text! == "City"{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CommunityRepresentativeElectedOffical") as? CommunityRepresentativeElectedOffical
               
                vc?.urlEndPathType = Defines.getGovernmentEmployee
                vc?.locationType = "3"
                self.present(vc!, animated: true)

               // self.navigationController?.pushViewController(vc!, animated: true)
            }
            else if cell.Statelbl.text! == "Town"{
                let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "CommunityRepresentativeElectedOffical") as? CommunityRepresentativeElectedOffical
               
                vc?.urlEndPathType = Defines.getGovernmentEmployee
                vc?.locationType = "2"
                self.present(vc!, animated: true)

               // self.navigationController?.pushViewController(vc!, animated: true)
            }
        }
        
        
       
    }
    
    func dialNumber(number : String) {

     if let url = URL(string: "tel://\(number)"),
       UIApplication.shared.canOpenURL(url) {
          if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler:nil)
           } else {
               UIApplication.shared.openURL(url)
           }
       } else {
                // add error message here
       }
    }
    
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch (result) {
        case .cancelled:
            print("Message was cancelled")
        case .failed:
            print("Message failed")
        case .sent:
            print("Message was sent")
        default:
            return
        }
        dismiss(animated: true, completion: nil)
    }
}


extension CommunityrepersentativeVC{
    func getPoliceDepartment(){
            if  !Reachability.isConnectedToNetwork() {
                Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                    return
            }
        let userid : String =  UserDefaults.standard.object(forKey: "userid") as! String ?? "0"
            let parameter:[String:String] = [
                "zipcode": self.ZipCodeLbl.text ?? ""
               // "user_id": useri
            ]
            
            print("\nThe parameters for PoliceDepartment Data : \(parameter)\n")
            self.collection?.removeAll()
            let activityData = ActivityData()
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
            
            DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.getPoliceDepartmentList, dataDict: parameter, { (json) in
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                if json["status"].stringValue == "200" {
                                    print("DATACOLLECTION",json["status"].stringValue)

                                    if let data = json["data"].array{
                                        self.collection = data
                                        print("DATACOLLECTION",data)
                                        print("COLLECTION*****",self.collection!)
                                        self.communityRepresentativeTable.isHidden = false
                                        self.communityRepresentativeTable.reloadData()
                                    }
                                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                    DispatchQueue.main.async {
                                        self.communityRepresentativeTable.reloadData()
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
    
    
    func getFireDepartment(){
        
            if  !Reachability.isConnectedToNetwork() {
                Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                    return
            }
        let userid : String =  UserDefaults.standard.object(forKey: "userid") as! String ?? "0"
            
            let parameter:[String:String] = [
                "zipcode": UserData.ZipCode,
                "user_id": userid
            ]
            
            print("\nThe parameters for Dashboard : \(parameter)\n")
            self.collection?.removeAll()
            let activityData = ActivityData()
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
            
            DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.getFireDepartmentList, dataDict: parameter, { (json) in
    //                            print(json)
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                if json["status"].stringValue == "200" {
                                    
                                    if let data = json["data"].array{
                                        self.collection = data
                                        self.communityRepresentativeTable.isHidden = false
                                        self.communityRepresentativeTable.reloadData()
                                    }
                                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                    DispatchQueue.main.async {
                                        self.communityRepresentativeTable.reloadData()
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
    
    func getAttorneyList(){
            if  !Reachability.isConnectedToNetwork() {
                Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                    return
            }
            
            let parameter:[String:String] = [
                "zipcode": UserData.ZipCode
//                "user_id":"2"
            ]
            
            print("\nThe parameters for Dashboard : \(parameter)\n")
            self.collection?.removeAll()
            let activityData = ActivityData()
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
            
            DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.GetAttorneyList, dataDict: parameter, { (json) in
    //                            print(json)
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                if json["status"].stringValue == "200" {
                                    
                                    if let data = json["data"].array{
                                        self.collection = data
                                        self.communityRepresentativeTable.isHidden = false
                                        self.communityRepresentativeTable.reloadData()
                                    }
                                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                    DispatchQueue.main.async {
                                        self.communityRepresentativeTable.reloadData()
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
    func getBailBondList(){
                if  !Reachability.isConnectedToNetwork() {
                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                        return
                }
                let parameter:[String:String] = [
                    "zipcode": UserData.ZipCode
    //                "user_id":"2"
                ]
                print("\nThe parameters for Dashboard : \(parameter)\n")
                self.collection?.removeAll()
                let activityData = ActivityData()
                NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
                
        DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.GetBailBondList, dataDict: parameter, { (json) in
        //                            print(json)
                                    NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                    if json["status"].stringValue == "200" {
                                        
                                        if let data = json["data"].array{
                                            self.collection = data
                                            self.communityRepresentativeTable.isHidden = false
                                            self.communityRepresentativeTable.reloadData()
                                        }
                                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                        DispatchQueue.main.async {
                                            self.communityRepresentativeTable.reloadData()
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
