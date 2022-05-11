//
//  AddNewConnectionVC.swift
//  Eithes
//
//  Created by Admin on 10/05/22.
//  Copyright © 2022 Iws. All rights reserved.
//

import UIKit
import TweeTextField
import SwiftyJSON
import Alamofire
import NVActivityIndicatorView
import Toast_Swift
import SDWebImage
import MessageUI
import AVKit
import Kingfisher
import FittedSheets
import AVFoundation
import SDWebImage

class AddNewConnectionVC: UIViewController {
    
    

    @IBOutlet weak var nameTF: TweeActiveTextField!
    
    @IBOutlet weak var mobileNoTF: TweeActiveTextField!
    
    @IBOutlet weak var emailTF: TweeActiveTextField!
    
    @IBOutlet weak var locationTF: TweeActiveTextField!
    
    @IBOutlet weak var profileimageView: UIImageView!
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBOutlet weak var imgoutletBtn: UIButton!
    
    
    @IBAction func uploadPhotoBtnActn(_ sender: Any) {
        let refreshAlert = UIAlertController(title: "", message: title, preferredStyle: .actionSheet)
                
                refreshAlert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction!) in
                    self.openCamera(type: "image")
                }))
                refreshAlert.addAction(UIAlertAction(title: "Library", style: .default, handler: { (action: UIAlertAction!) in
                    self.openLibrary(type: "image")
                }))
                refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                    
                }))
                present(refreshAlert, animated: true, completion: nil)
    }
    
    @IBAction func searchBtnction(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle:Bundle.main).instantiateViewController(withIdentifier: "SerachingVC") as? SerachingVC
        self.present(vc!, animated: true, completion: nil)
    }
    

    
    @IBAction func saveBtnActn(_ sender: Any) {
       
    
        
        if  self.imgoutletBtn.isSelected == true {
            uploadConnections()
        }else{
            Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Select image first")

        }
         
        
        
    }
    
    
    func uploadConnections() {
        if  !Reachability.isConnectedToNetwork() {
         //   self.VehicalregistrationAddMoreView.isHidden = true
                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: Defines.noInterNet)
                        return
                }
        
          if  self.nameTF.text == ""{
                  //  self.VehicalregistrationAddMoreView.isHidden = true
                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter name!")
                        return
                }
                if self.mobileNoTF.text == "" {
                   // self.VehicalregistrationAddMoreView.isHidden = true
                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter mobile number!")
                       // self.usernameText.becomeFirstResponder()
                        return
                }
//                if self.formValues["Mobile Number"]!.count <= 5 || self.formValues["Mobile Number"]!.count >= 11{
//                    self.VehicalregistrationAddMoreView.isHidden = true
//                   Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "moblie number is invalid!")
//                      // self.usernameText.becomeFirstResponder()
//                       return
//               }

        if self.emailTF.text == "" {
                   // self.VehicalregistrationAddMoreView.isHidden = true
                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter email!")
                       // self.usernameText.becomeFirstResponder()
                        return
                }
        let validEmail = self.emailTF.text!.isValidEmail()
            if validEmail == false {
              //  self.VehicalregistrationAddMoreView.isHidden = true
                Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "email is invalid!")
                return
            }
        
        if self.locationTF.text == "" {
                  //  self.VehicalregistrationAddMoreView.isHidden = true
                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please enter current location!")
                       // self.usernameText.becomeFirstResponder()
                        return
                }
        if self.imgoutletBtn.isSelected == false {
                  //  self.VehicalregistrationAddMoreView.isHidden = true
                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please select an image!")
                       // self.usernameText.becomeFirstResponder()
                        return
                }
                
//                if self.drivingLicenseImg == nil {
//                    Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: "Please select an image!")
//                       // self.usernameText.becomeFirstResponder()
//                        return
//                }
//
        
            var data:Data?
                let url:String = Defines.ServerUrl + Defines.uploadConnection
        data = self.profileimageView.image?.pngData()
                        //print(data)
                let activityData = ActivityData()
                NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
                
                var status = ""
//                if self.radioButtonPermission == false{
//                    status = "1"
//                }
//                else{
//                    status = "0"
//                }
        let userid : String =  UserDefaults.standard.object(forKey: "userid") as! String ?? "0"

                let parameter:[String:String] = [
                    "user_id": userid,
                    "name": self.nameTF.text!,
                    "phone_number": self.mobileNoTF.text!,
                    "location":self.locationTF.text!,
                    "email":self.emailTF.text!,
                    "status":status,
                    "location_access":"1"
                ]
        
        print("PARAMS",parameter)
                let timestamp = NSDate().timeIntervalSince1970
            
                Alamofire.upload(multipartFormData: { multipartFormData in
                    multipartFormData.append(data!, withName: "file" ,fileName: "\(timestamp).png", mimeType: "\(timestamp)/png")
        //            multipartFormData.append(imgData, withName: name ,fileName: "file.jpg", mimeType: "image/jpg")
                    for (key, value) in parameter {
                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    }
                    print("PARAMS88",parameter)

                }, to: url)
                { (result) in
                    switch result {
                    case .success(let upload, _, _):
                        
                        upload.uploadProgress(closure: { (progress) in
                            let activityData = ActivityData()
                            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
                            print("Upload Progress: \(progress.fractionCompleted)")
                        })
                        
                        upload.responseJSON { response in
                            print(response)
                            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                            print(response.result.value!)
                            let json = JSON(response.result.value!)
                            print(json)
                            if json["status"].stringValue == "200" {
                             //   self.radioButtonPermission = false
                              //  self.addMoreButton.isHidden = false
                              //  self.Savebtn.isHidden = true
                             //   self.formValues.removeAll()
                             //   self.formValues = self.formValues1
                        self.view.makeToast(json["msg"].stringValue, duration: 3.0, position: .top)

                                let next = self.storyboard?.instantiateViewController(withIdentifier: "MyDirectoryVC") as! MyDirectoryVC
                                print("indexprint******34333")
                               self.present(next, animated: true, completion: nil)
                               // self.myConnections.removeAll()
                               // self.getConnectionList()
                            }else {
                                Utility.showMessageDialog(onController: self, withTitle: Defines.alterTitle, withMessage: json["msg"].stringValue, withError: nil, onClose: {
                                    return
                                })
                               // self.view.makeToast("Video upload failed", duration: 3.0, position: .top)
                            }
                        }
                    case .failure(let encodingError):
                        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
                        print(encodingError)
                    }
                }
            }
    
    

}
extension AddNewConnectionVC: UINavigationControllerDelegate ,UIImagePickerControllerDelegate{
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if (info[.mediaType] as? String) != nil {
                let profileImage = info[.originalImage] as! UIImage
                let updateImage = profileImage.updateImageOrientionUpSide()
                self.imgoutletBtn.isSelected = true
                self.profileimageView.image = updateImage!
            }
            dismiss(animated: true) {
                print("Photo Selected")
//                self.API_Calling_For_UpdateProfilePicture()
            }
        }
        
        // take phota using camera
        func openCamera(type:String) {
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                let imagePicker = UIImagePickerController()
    //            self.isAvtar = false
                imagePicker.delegate = self
                imagePicker.sourceType = .camera;
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        
        // take photo from library
        func openLibrary(type:String) {
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
                let imagePicker = UIImagePickerController()
    //            self.isAvtar = false
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
}



