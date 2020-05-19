//
//  MainViewControllerModel.swift
//  Quran247
//
//  Created by Jimoh Babatunde  on 13/05/2020.
//  Copyright © 2020 Dawah Nigeria. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit

enum MainviewModelState {
    case MainViewDidFetchSuccessful
    case MainViewDidFetchFail
}



protocol MainViewModelDelegate: class {
    func MainViewModelDidChangeState(state: MainviewModelState)
    func downloadReciter(dawahCastUrl: String)
}


class MainViewModel: NSObject, UITableViewDataSource, MainViewReciterCellDelegate {
   
    public weak var delegate:MainViewModelDelegate?
    public var reciterNames : [String] = []
    public var mountPoint : [String] = []//dawahcast_url
    public var dawahCastUrl : [String] = []
    
    
    public func getAllReciters() {
        
        NetworkService.sharedManager.getAllReciters { (success, object, response) in
           if success {
            print("the object is \(object)")
            print("the response iss \(response)")
               if let result = object?.arrayValue {
                   print("the result is \(result)")
                   self.reciterNames = result.map { (reciterName) -> String in
                        return reciterName["reciter_name"].stringValue
                    }
                    self.mountPoint = result.map { (reciterFile) -> String in
                        return reciterFile["mount_point"].stringValue
                    }
                    self.dawahCastUrl = result.map { (dawahCastUrl) -> String in
                        return dawahCastUrl["dawahcast_url"].stringValue
                    }
                    print("reciters names \(self.reciterNames) and file is \(self.mountPoint)")
                    DispatchQueue.main.async {
                        self.delegate?.MainViewModelDidChangeState(state: .MainViewDidFetchSuccessful)
                    }

               }
           }
           else {
                print("wanna know")
            }
       }
       
    }
    
    //MARK: Register TableView
    public func registerReusableViewsForTableView(tableView: UITableView) {
        //Register the custom tableview cells
        tableView.register(UINib(nibName: "MainViewReciterCell", bundle: nil), forCellReuseIdentifier: "ReciterCells")
        tableView.dataSource = self
    }
    
    //MARK: UITableView Datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reciterNames.count
        //return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReciterCells", for: indexPath) as? MainViewReciterCell
        let reciterName = self.reciterNames[indexPath.item]
        cell?.updateCell(reciterName: reciterName)
        //cell?.selectionStyle = .blue
        cell?.delegate = self
        cell?.index = indexPath
        return cell!
    }
    
   
    func didTapMusicControls(controls: MusicControls, pos: Int) {
        let currentDawahCastUrl = self.dawahCastUrl[pos]
        switch controls {
        case .download:
            self.delegate?.downloadReciter(dawahCastUrl: currentDawahCastUrl)
        }
    }
    
}
