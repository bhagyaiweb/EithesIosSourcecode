//
//  NotifiedContactVC.swift
//  Eithes
//
//  Created by sumit bhardwaj on 04/08/21.
//  Copyright © 2021 Iws. All rights reserved.
//

import UIKit

class NotifiedContactVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var notifiedContactName = ["Allef Michel","Michael Dam","Daniel Xavier","Joelson Melo","Bruce Mars","Taiwili Kayan","Daniel Xavier","Dmitriy Ilkevich","Dmitriy Ilkevich","Dmitriy Ilkevich","Dmitriy Ilkevich","Dmitriy Ilkevich"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib1 = UINib(nibName: "NotifiedContactCell", bundle: nil)
        collectionView.register(nib1, forCellWithReuseIdentifier: "NotifiedContactCell")
        // Do any additional setup after loading the view.
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notifiedContactName.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NotifiedContactCell", for: indexPath) as! NotifiedContactCell
         cell.layer.backgroundColor = UIColor.clear.cgColor
        cell.nameLbl.text = notifiedContactName[indexPath.row]
         return cell
  
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 334, height: 143)
//    }
   // (self.collectionView.frame.width/2)-30
    
}
