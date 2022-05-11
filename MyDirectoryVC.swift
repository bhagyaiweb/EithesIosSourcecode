//
//  MyDirectoryVC.swift
//  Eithes
//
//  Created by Shubham Tomar on 03/04/20.
//  Copyright © 2020 Iws. All rights reserved.


import UIKit
import GoogleMaps
import MapKit
import SwiftyJSON
import Alamofire
import NVActivityIndicatorView


class MyDirectoryVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MyCellDelegate1, GMSMapViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
       return zipCodesArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        self.view.endEditing(true)
        return zipCodesArr[row]

    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        self.zipcodeLbls.text = self.zipCodesArr[row]
        self.zipcodePickerView.isHidden = true

    }
    
    
    @IBOutlet weak var zipcodeLbls: UILabel!
    
    
   // @IBOutlet weak var mapView: GMSMapView!
   // @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var addNewBtn: UIButton!
    
     
    var nameArray = ["Ali Morshedlou","Bram Naus","Ellyot"]
    var tabNAmeArray = ["My Connections","Trackers"]
    var nameTitle = ""
    var buttonTitleName = "My Connections"
    var  tracklistName = ["Ali Morshedlou","Bram Naus"]
    var dateArray = ["29/09/2019","2/10/2019"]
    var addArray = ["Ring Road","New Super Market"]
    var timeArray = ["14:00 PM","9:00 PM"]
    
    var myConnections = Array<JSON>()
    var nameslist = Array<JSON>()

    
    var selecteditem = 0
   
   let tbcell = MyDirectoryCell()
    @IBOutlet weak var zipcodePickerView: UIPickerView!
    
    @IBOutlet weak var mapButtonView: UIView!
    
    @IBOutlet weak var buttonsView: UIView!
    
    @IBOutlet weak var nameCollection: UICollectionView!
    
    @IBOutlet weak var myDirectorytableView: UITableView!
    
    var zipCodesArr = ["27212","201302","90001","376688","110096","201301"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myDirectorytableView.separatorStyle = .none
        myDirectorytableView.isHidden = false
        myDirectorytableView.reloadData()
        reginib()
        getConnectionList()
        addNewBtn.layer.cornerRadius = 5
        addNewBtn.clipsToBounds = true
      //  saveBtn.layer.cornerRadius = 5
       // saveBtn.clipsToBounds = true
       // addMoreView.isHidden = true
        addNewBtn.isHidden = false
        self.buttonsView.isHidden =  true
        self.mapButtonView.isHidden = true
      //  self.mapView.isHidden = true
        self.zipcodePickerView.backgroundColor = .white
        //self.dropdownpick?.layer.borderWidth = 1.0
        self.zipcodePickerView?.layer.cornerRadius = 3.0
        self.zipcodePickerView?.layer.masksToBounds = true
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.zipcodePickerView.isHidden = true
    }
    @IBAction func zipcodeBtnActn(_ sender: UIButton) {
        self.zipcodePickerView.isHidden = false
    }
    
    
    @IBAction func serchingBtnAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier: "SerachingVC") as? SerachingVC
        self.present(vc!, animated: true, completion: nil)
    }
    
    
    @IBAction func onPresssedMapViewBtn(_ sender: Any)
    {
//
   self.buttonsView.isHidden =  false
        mapButtonView.backgroundColor = .clear
        mapButtonView.isHidden = false
     //   mapView.isHidden = false
// mapview()
        
        let next = self.storyboard?.instantiateViewController(withIdentifier: "TrackerMapVC") as! TrackerMapVC

       // self.navigationController?.pushViewController(next, animated: true)
      //  self.navigationController?.popViewController(animated: true)
        self.present(next, animated: true, completion: nil)
       // self.popoverPresentationController(next)
        
        
    }
    
    @IBAction func onPressedSaveBtn(_ sender: Any)
    {
      
    }
    
    @IBAction func onPressedTrackerListBtn(_ sender: Any)
    {
        self.buttonsView.isHidden = false
       // self.mapButtonView.isHidden = true
        self.mapButtonView.isHidden = false
        mapButtonView.isHidden = false
      //  mapView.isHidden = false
        
        
    }
    
    
    @IBAction func sosButonAction(_ sender: UIButton) {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "ChooseCategoryVC") as! ChooseCategoryVC
        print("indexprint******34333")
       self.present(next, animated: true, completion: nil)
       
    }
    
    
    @IBAction func onPressedAddNewBtn(_ sender: Any)
    {
        let next = self.storyboard?.instantiateViewController(withIdentifier: "AddNewConnectionVC") as! AddNewConnectionVC
        print("indexprint******34333")
       self.present(next, animated: true, completion: nil)
    }
    
    
    @IBAction func onPressedBackArrowBtn(_ sender: Any)
    {
        //self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onPressedSearchBtn(_ sender: Any)
    {
        
       // self.navigationController?.pushViewController(vc!, animated: true)
    }
    func reginib()
    {
        let nib = UINib(nibName: "Tabcollectioncell", bundle: nil)
        nameCollection.register(nib, forCellWithReuseIdentifier: "Tabcollectioncell")
         let nib1 = UINib(nibName: "MyDirectoryCell", bundle: nil)
        myDirectorytableView.register(nib1, forCellReuseIdentifier: "MyDirectoryCell")
        let nib2 = UINib(nibName: "TrackerListCell", bundle: nil)
        myDirectorytableView.register(nib2, forCellReuseIdentifier: "TrackerListCell")
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabNAmeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Tabcollectioncell", for: indexPath) as! Tabcollectioncell
                cell.delegate = self
              self.nameTitle = tabNAmeArray[indexPath.row]
              cell.shopLiftingBtn.setTitle(self.nameTitle, for: .normal)
        if   self.selecteditem == indexPath.row  {
            cell.shopLiftingBtn.backgroundColor = UIColor.blue
        // self.feedDatacollectionView.isHidden = false
        }else {

         cell.shopLiftingBtn.backgroundColor = UIColor.gray
     }
        
         return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        let numberOfItemsPerRow: CGFloat = 2.0; print("")

        let itemWidthtop = (collectionView.bounds.width - layout.minimumLineSpacing) / numberOfItemsPerRow
        let itemWidthdown = (collectionView.bounds.width - layout.minimumLineSpacing) / numberOfItemsPerRow
        if collectionView == nameCollection{
            return CGSize(width: itemWidthtop/1.5, height: 30)
        }
//        if collectionView == feedDatacollectionView
//        {
//            return CGSize(width: itemWidthdown, height: 300)
//
//        }
        return CGSize(width: itemWidthdown, height: itemWidthdown)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Tabcollectioncell", for: indexPath) as! Tabcollectioncell
       
        if indexPath.row == 0 {
            cell.shopLiftingBtn.isSelected = true
            cell.shopLiftingBtn.backgroundColor = UIColor.blue
            buttonTitleName = "My Connections"
            self.myDirectorytableView.isHidden = false
            let tbcell = MyDirectoryCell()
            tbcell.namelbl.text = nameArray[indexPath.row]
            tbcell.mapBtn.addTarget(self, action: #selector(mapcheck), for: .touchUpInside)
            myDirectorytableView.reloadData()
        }else{
            cell.shopLiftingBtn.isSelected = false
            cell.shopLiftingBtn.backgroundColor = UIColor.gray
            self.myDirectorytableView.isHidden = true
        }

    }
    let userid : String =  UserDefaults.standard.object(forKey: "userid") as! String ?? "0"
    
    func getConnectionList(){
        if  !Reachability.isConnectedToNetwork() {
            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                return
        }
            let parameter:[String:String] = [
                "user_id": userid
        ]
        
        print("\nThe parameters for Dashboard cONNECT : \(parameter)\n")
       // self.nameslist.removeAll()
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
        
        DataProvider.sharedInstance.getDataFromRegister(path: Defines.ServerUrl + Defines.getmyConnectionList, dataDict: parameter, { (json) in
            print("PARMASINDIRECTORY",parameter)
                            print(json)
                            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                            if json["status"].stringValue == "200" {
                                
                                if let data = json["data"].array{
                                    self.myConnections = data
                                    self.myDirectorytableView.isHidden = false
                                    self.myDirectorytableView.reloadData()
                                }
                                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                                DispatchQueue.main.async {
                                    self.myDirectorytableView.reloadData()
                                }
                                self.myDirectorytableView.reloadData()

                            }else {
                                self.myConnections.removeAll()
                                Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
                                    return
                                })
                            }
                        }) { (error) in
                            print(error)
                            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        }
    }
    
    
    func onpressedShopliftingBtn(cell: Tabcollectioncell)
    {
        
        
        let indexpath = self.nameCollection.indexPath(for: cell)
        self.selecteditem = indexpath?.row ?? 0
        
        DispatchQueue.main.async {
            self.nameCollection.reloadData()
            self.myDirectorytableView.reloadData()
        }
        
        if selecteditem == 0 {
            // cell.shopLiftingBtn.titleLabel?.text = "My Connections"
              //  buttonTitleName = cell.shopLiftingBtn.titleLabel!.text!
            getConnectionList()
            self.myDirectorytableView.isHidden = false
           self.myDirectorytableView.reloadData()
        }
        
//        if cell.shopLiftingBtn.backgroundColor == UIColor.gray
//                            {
//                   if cell.shopLiftingBtn.titleLabel?.text == "My Connections"
//                                {
//                   buttonTitleName = cell.shopLiftingBtn.titleLabel!.text!
//                       getConnectionList()
//                   self.myDirectorytableView.isHidden = false
//                  self.myDirectorytableView.reloadData()
//
//                       addNewBtn.isHidden = false
//                        buttonsView.backgroundColor = .clear
//                        buttonsView.isHidden = true
//                        }
//           else if cell.shopLiftingBtn.titleLabel?.text == "Trackers"
//                           {
//              buttonTitleName = cell.shopLiftingBtn.titleLabel!.text!
//              self.myDirectorytableView.isHidden = false
//             self.myDirectorytableView.reloadData()
//               addNewBtn.isHidden = true
//             //  mapView.isHidden = true
//               mapButtonView.isHidden = true
//               buttonsView.isHidden = false
//
//           }
//        }
//        else
//        {
//          //  self.myDirectorytableView.isHidden = true
////              addNewBtn.isHidden = true
////               buttonsView.isHidden = true
////               mapView.isHidden = true
//        }
    }
    // here working with tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if buttonTitleName == "My Connections"
        {
        return nameslist.count
       }
        else if buttonTitleName == "Trackers"
        {
            return tracklistName.count
        }
        return nameslist.count
    }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
       {
        
         if buttonTitleName == "My Connections"{
             let cell = tableView.dequeueReusableCell(withIdentifier: "MyDirectoryCell", for: indexPath) as! MyDirectoryCell
            // if self.myConnections.count > 0 {
                 let data = self.myConnections[indexPath.row].dictionaryValue
                 cell.namelbl.text = data["name"]?.stringValue
                 cell.phoneLbl.text = data["phone_number"]?.stringValue
                 
                 if data["profile_pic"]?.stringValue != ""{
                     let imgURL = URL(string: data["profile_pic"]!.stringValue)!
                     cell.picImgView.kf.setImage(with: imgURL)
                 }
                 cell.mapBtn.addTarget(self, action: #selector(mapcheck), for: .touchUpInside)

           //  }
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MyDirectoryCell", for: indexPath) as! MyDirectoryCell
//           cell.namelbl.text = nameArray[indexPath.row]
//        cell.mapBtn.addTarget(self, action: #selector(mapcheck), for: .touchUpInside)
            
        return cell
        }
         else
         {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TrackerListCell", for: indexPath) as! TrackerListCell
            cell.nameLbl.text = tracklistName[indexPath.row]
            cell.addressLbl.text = addArray[indexPath.row]
            cell.dateLbl.text = dateArray[indexPath.row]
            cell.timeLbl.text = timeArray[indexPath.row]
            return cell
        }
           
       }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 90
        
    }
    @objc func mapcheck(){
        let next = self.storyboard?.instantiateViewController(withIdentifier: "TrackerMapVC") as! TrackerMapVC
        self.present(next, animated: true, completion: nil)
       // self.navigationController?.pushViewController(next, animated: true)
    }
    
    
    @objc func mapview()
    {
        // Do any additional setup after loading the view.
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
//        mapView.camera = camera
     //   mapView.delegate = (self as GMSMapViewDelegate)
        
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
      //  self.mapView.addSubview(mapView)

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    

}
