
//  MyACcountVC.swift
//  Eithes
//  Created by Shubham Tomar on 27/03/20.
//  Copyright © 2020 Iws. All rights reserved.

import UIKit

class MyACcountVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
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

        self.ZipCodeLbl.text = self.zipCodesArr[row]
        self.dropdownpicker.isHidden = true
       // dashboardtableview.reloadData()

       // getDashBoardData()
      //  dropdownpicker.reloadData()
      
        

        

    }
    
    
    
    
    
    var zipCodesArr = ["27212","201302","90001","376688","110096","201301"]

     var iconImageArray = ["group_4-1","directory_1"]
      var backGroundimgArray = ["1stbackgroundImgaccount","myaacounbckgroundt2img",""]
      var titlelabelArray = ["USER BENEFITS","MY DIRECTORY"]
    @IBOutlet weak var ZipCodeLbl: UILabel!
    
    @IBOutlet weak var MyaccounttableView: UITableView!
    
    @IBOutlet weak var zipbtn: UIButton!
    
    @IBOutlet weak var dropdownpicker: UIPickerView!
    
    var myaccountzipcode : String?
    override func viewDidLoad() {
        super.viewDidLoad()
    self.MyaccounttableView.separatorStyle = .none
        reginib()
        zipbtn.setTitle("", for: .normal)
        dropdownpicker.isHidden = true
        self.dropdownpicker.backgroundColor = .white
        self.dropdownpicker?.layer.cornerRadius = 3.0
        self.dropdownpicker?.layer.masksToBounds = true

    }
    
    override func viewWillAppear(_ animated: Bool) {
      //  super.viewWillAppear(animated)
        self.ZipCodeLbl.text = myaccountzipcode
    }
    
    @IBAction func BackArrowbtn(_ sender: Any)
    {
       // self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func sosButtonAction(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(identifier: "ChooseCategoryVC")
        vc?.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true, completion: nil)
        
    }
    
    
    @IBAction func onPressedsearchBtn(_ sender: Any)
    {
    
        let vc = UIStoryboard.init(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier: "SerachingVC") as? SerachingVC
        self.present(vc!, animated: true, completion: nil)
    //self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    
    @IBAction func zipbtAction(_ sender: Any) {
        self.dropdownpicker.isHidden = false

    }
    
    
    func reginib()
    {
        let nib = UINib(nibName: "Myaccoutcell", bundle: nil)
        MyaccounttableView.register(nib, forCellReuseIdentifier: "Myaccoutcell")
    }
    
    
    
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        iconImageArray.count
       }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "Myaccoutcell", for: indexPath)
        as! Myaccoutcell
        cell.selectedBackgroundView = UIView()
        cell.selectedBackgroundView?.backgroundColor = UIColor.white

        cell.BackgroundImage.image = UIImage(named: backGroundimgArray[indexPath.row])
        cell.iconimage.image = UIImage(named: iconImageArray[indexPath.row])
        cell.titlelbl.text = titlelabelArray[indexPath.row]
        return cell
       }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if indexPath.row == 0 {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserBenifitVC") as! UserBenifitVC
            vc.userZipcodeStr = self.ZipCodeLbl.text
            print("PASSZIP",vc.userZipcodeStr)
            print("PASSZIP1",self.ZipCodeLbl.text)

            self.present(vc, animated: true)
            //  self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MyDirectoryVC") as! MyDirectoryVC
            self.present(vc, animated: true)
           // self.dismiss(animated: true, completion: nil)
            //vc.userDirectory = true
           // self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
