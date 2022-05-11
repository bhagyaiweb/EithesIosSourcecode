//
//  SupportViewC.swift
//  Eithes
//  Created by Admin on 24/02/22.
//  Copyright © 2022 Iws. All rights reserved.


import UIKit

class SupportViewC: UIViewController {
    
    @IBOutlet weak var visitview: UIView!
    @IBOutlet weak var secondView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        visitview.dropShadowhome(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
        secondView.dropShadowhome(color: .lightGray, opacity: 1, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
    }
       
    @IBAction func backAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension UIView {
        
        func dropShadowhome(color: UIColor, opacity: Float = 1, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
          layer.masksToBounds = false
          layer.shadowColor = color.cgColor
          layer.shadowOpacity = opacity
          layer.shadowOffset = offSet
          layer.shadowRadius = radius
          layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
          layer.shouldRasterize = true
          layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        }
    }
