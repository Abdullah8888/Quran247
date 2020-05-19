//
//  AboutUsViewController.swift
//  Quran247
//
//  Created by Jimoh Babatunde  on 14/05/2020.
//  Copyright © 2020 Dawah Nigeria. All rights reserved.
//

import UIKit

class AboutUsViewController: BaseFile {

   @IBOutlet weak var stackView: UIStackView?
   @IBOutlet weak var view1: UIView?
   
   @IBOutlet weak var view11: UIView?
      
      override func viewDidLoad() {
          super.viewDidLoad()
          
         self.setUpShadowsForViews(stackView: stackView!)
      }
    
      func setUpShadowsForViews(stackView: UIStackView) {
          
          for view in stackView.arrangedSubviews {
              view.layer.shadowColor = UIColor.black.cgColor
              view.layer.shadowOpacity = 0.3
              view.layer.shadowRadius = 4
              view.layer.shadowOffset = .init(width: 0, height: 1)
          }
      }
    
    

}


