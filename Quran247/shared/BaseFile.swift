//
//  Shared.swift
//  Quran247
//
//  Created by Jimoh Babatunde  on 17/05/2020.
//  Copyright © 2020 Dawah Nigeria. All rights reserved.
//

import Foundation
import RKDropdownAlert
import Reachability
import SystemConfiguration

class BaseFile: UIViewController {
    let reachability = Reachability()!
    var darkOverlayView:UIView?
    var blurOverlay: UIVisualEffectView?
    var activityindicator : UIActivityIndicatorView?
    
    override func viewDidLoad() {
        print("loading ...")
    }
    //MARK: DropDownAlert
    public func displayDropDownAlertWithTitle(title: String, message: String, error: Bool) {
        RKDropdownAlert.title(title, message: message, backgroundColor: error ? UIColor.red : UIColor.init(named: "2ECC71"), textColor: UIColor.white, time: 2)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    @objc func reachabilityChanged(note: Notification) {

        let reachability = note.object as! Reachability

        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
            self.removeBlurOverlay()
        case .cellular:
            print("Reachable via Cellular")
            self.removeBlurOverlay()
        case .none:
            print("No Internet connection detected!")
            self.showBlurOverlayWithOutActivity(withText: "No Internet connection detected!")
        }
    }
    class func isConnectedToNetwork() -> Bool
    {
        let reachability = Reachability()

        if reachability!.isReachable || reachability!.isReachableViaWiFi || reachability!.isReachableViaWWAN
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    func checkInternet() {
        let dd = Reachability(hostname: "https://dawahnigeria.com/dn_qs.json")
        if ((dd?.whenReachable) != nil) {
            print("aaaa")
        }
        else if ((dd?.whenUnreachable) != nil) {
            print("bbbb")
        }
    }
    
    func removeBlurOverlay() {
        
        if (self.blurOverlay != nil) {
            self.blurOverlay?.removeFromSuperview()
            self.blurOverlay = nil
        }
    }
    
    func displayNetworkStatusMessage(text: String) {
        let confimationAlert = UIAlertController(title: title, message: text, preferredStyle: UIAlertController.Style.alert)
        
        
        confimationAlert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { (action: UIAlertAction!) in
            return
        }))
        self.present(confimationAlert, animated: true, completion: nil)
    }
    
    func showBlurOverlayWithOutActivity(withText: String) {
           
           let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
           self.blurOverlay = UIVisualEffectView(effect: blurEffect)
           self.blurOverlay?.frame = view.bounds
           self.blurOverlay?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
           
           self.activityindicator = UIActivityIndicatorView.init(activityIndicatorStyle: .medium)
           self.activityindicator?.center = self.view.center
           self.activityindicator?.startAnimating()
           
           let textLabel = UILabel.init(frame: CGRect.init(x: 0, y: (self.activityindicator?.frame.origin.y)!-40, width: (self.blurOverlay?.frame.width)!, height: 20))
           textLabel.textAlignment = .center
           textLabel.textColor = UIColor.darkGray
           textLabel.font = UIFont.init(name: "Helvetica-Neue-Light", size: 17.0)
           textLabel.text = withText
           self.blurOverlay?.contentView.addSubview(textLabel)
           
           
           view.addSubview(self.blurOverlay!)
        
        let confimationAlert = UIAlertController(title: title, message: withText, preferredStyle: UIAlertController.Style.alert)
        
        confimationAlert.addAction(UIAlertAction(title: "Close", style: .cancel, handler: { (action: UIAlertAction!) in
            return
        }))
        self.present(confimationAlert, animated: true, completion: nil)
       }
    
    func showBlurOverlay(withActivity: Bool) {
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        self.blurOverlay = UIVisualEffectView(effect: blurEffect)
        self.blurOverlay?.frame = view.bounds
        self.blurOverlay?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        if (withActivity) {
            self.activityindicator = UIActivityIndicatorView.init(activityIndicatorStyle: .medium)
            self.activityindicator?.center = self.view.center
            self.blurOverlay?.contentView.addSubview(self.activityindicator!)
            self.activityindicator?.startAnimating()
        }
        
        view.addSubview(self.blurOverlay!)
    }
    
    func showIndicator(withActivity: Bool) {
     
        if (withActivity) {
            self.activityindicator = UIActivityIndicatorView.init(activityIndicatorStyle: .large)
            self.activityindicator?.color = UIColor.red
            self.activityindicator?.center = self.view.center
            self.view.addSubview(self.activityindicator!)
            self.activityindicator?.startAnimating()
        }
       
    }
    
    func stopIndicator() {
        
     if (self.activityindicator != nil) {
         self.activityindicator?.removeFromSuperview()
         self.activityindicator = nil
     }
    }
}
