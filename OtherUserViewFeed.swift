 
//  OtherUserViewFeed.swift
//  Eithes
//  Created by Shubham Tomar on 13/04/20.
//  Copyright © 2020 Iws. All rights reserved.
import UIKit
import GoogleMaps
import  GooglePlaces

class OtherUserViewFeed: UIViewController, UITableViewDelegate,UITableViewDataSource{
    
    var nameArray = ["Dorothy Powers","Yoandra Sans","Sarah Xandre"]
    var  commentArray = ["Stay safe buddy!","We’re reaching at your destination.","Just called the police, they are reaching."]
    var notifiedContactName = ["Allef Michel","Michael Dam","Daniel Xavier","Joelson Melo","Bruce Mars","Taiwili Kayan","Daniel Xavier","Dmitriy Ilkevich","Dmitriy Ilkevich","Dmitriy Ilkevich","Dmitriy Ilkevich","Dmitriy Ilkevich"]
    
    @IBOutlet weak var bckArrowBtn: UIButton!
    
    @IBOutlet weak var joinFeedImageView: UIView!
    @IBOutlet weak var timerButton: UIButton!
    
    @IBOutlet weak var otherUserMapView: GMSMapView!
    
    @IBOutlet weak var distanceView: UIView!
    @IBOutlet weak var popupView: UIView!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var stopBtn: UIButton!
    
    @IBOutlet weak var jointStreamBtn: UIButton!
    
    @IBOutlet weak var viewFeedTableView: UITableView!
    
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet var newview: UIView!
    
    @IBOutlet weak var dissmissbtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        dissmissbtn.setTitle("", for: .normal)
        dissmissbtn.layer.cornerRadius = 5
        dissmissbtn.clipsToBounds = true
        viewFeedTableView.separatorStyle = .none
        commentView.layer.cornerRadius = 5
        commentView.clipsToBounds = true
        jointStreamBtn.layer.cornerRadius = 5
        jointStreamBtn.clipsToBounds = true
        timerButton.layer.cornerRadius = 12
        timerButton.clipsToBounds = true
        stopBtn.layer.cornerRadius = 12
        stopBtn.clipsToBounds = true
        popupView.isHidden = true
       // popupView.layer.cornerRadius = 20
       // popupView.clipsToBounds = true
        otherUserMapView.isHidden = true
        otherUserMapView.layer.cornerRadius = 15
         distanceView.layer.cornerRadius = 5
        otherUserMapView.clipsToBounds = true
        distanceView.isHidden = true
        joinFeedImageView.isHidden = true
        //dropShadowToView(view: popupView)

          reginib()
        
     //    Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.icon = UIImage(named: "mapBlue") // Marker icon
//        marker.snippet = "Australia"
//        marker.map = otherUserMapView
//
        let position = CLLocationCoordinate2D(latitude: 10, longitude: 10)
        let marker = GMSMarker(position: position)
        marker.title = "Hello World"
        marker.map = otherUserMapView
        
//        let positionLondon = CLLocationCoordinate2D(latitude: 50, longitude: 50)
//        let london = GMSMarker(position: positionLondon)
//        london.title = "London"
//        london.icon = UIImage(named: "mapBlue")
//        london.map = otherUserMapView
              
              
        
    }
    
    @IBAction func dismissBtnAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func dropShadowToView(view : UIView){
        //view.center = self.view.center
        //view.backgroundColor = UIColor.yellow
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 1
        //self.view.addSubview(viewShadow)
    }
    
    
    @IBAction func joinStreamBtnAction(_ sender: UIButton) {
        
       popupView.isHidden = false
        popupView.layer.cornerRadius = 30
        popupView.clipsToBounds = true
        popupView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // Top right corner, Top left corner respectively

        
    }
    
    
    @IBAction func onPressedStopBtn(_ sender: Any)
    {
//         bckArrowBtn.isHidden = true
//        otherUserMapView.isHidden = false
//         popupView.isHidden = true
//          distanceView.isHidden = false
//        joinFeedImageView.isHidden = true
//        iconImage.isHidden = false
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SumbitVideoVC") as? SumbitVideoVC
        self.present(vc!, animated: true, completion: nil)

        
//        joinFeedImageView.isHidden = false
//              bckArrowBtn.isHidden = true
//               popupView.isHidden = true
//               otherUserMapView.isHidden = true
//              distanceView.isHidden = true
//              iconImage.isHidden = true

    }
    @IBAction func onPressedTimerBtn(_ sender: Any)
    {
        bckArrowBtn.isHidden = false
        popupView.isHidden = false
        otherUserMapView.isHidden = true
          distanceView.isHidden = true
           joinFeedImageView.isHidden = false
          iconImage.isHidden = false
    }
    
    @IBAction func onPressedBckArrowBtn(_ sender: Any)
    {
      //  self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true)
    }
    
    
    @IBAction func onPressedIconImage(_ sender: Any)
    {
//        joinFeedImageView.isHidden = false
//        bckArrowBtn.isHidden = true
//        popupView.isHidden = true
//        otherUserMapView.isHidden = true
//        distanceView.isHidden = true
//        iconImage.isHidden = true
        bckArrowBtn.isHidden = false
       otherUserMapView.isHidden = false
        popupView.isHidden = true
         distanceView.isHidden = false
       joinFeedImageView.isHidden = true
       iconImage.isHidden = false

        
        
    }
    
    
    func reginib(){
        let nib = UINib(nibName: "SosStartCell", bundle: nil)
        viewFeedTableView.register(nib, forCellReuseIdentifier: "SosStartCell")
    }
     
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell =  tableView.dequeueReusableCell(withIdentifier:"SosStartCell", for: indexPath) as! SosStartCell
               cell.layer.backgroundColor = UIColor.clear.cgColor
               cell.nameLbl.text = nameArray[indexPath.row]
               cell.commentLbl.text  = commentArray[indexPath.row]
               
               return cell
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func locatonmapview()
        {
//        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
//            otherUserMapView.camera = camera
//            otherUserMapView.delegate = (self as! GMSMapViewDelegate)
//            let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
//            self.otherUserMapView.addSubview(mapView)
//
          //  var position = CLLocationCoordinate2DMake(17.411647,78.435637)


            // Creates a marker in the center of the map.
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
            marker.title = "Sydney"
            marker.icon = UIImage(named: "mapBlue") // Marker icon
            marker.snippet = "Australia"
            marker.map = otherUserMapView
}
    
}
