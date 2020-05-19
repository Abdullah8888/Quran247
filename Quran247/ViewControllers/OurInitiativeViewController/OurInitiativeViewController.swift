//
//  OurInitiativeViewController.swift
//  Quran247
//
//  Created by Jimoh Babatunde  on 14/05/2020.
//  Copyright © 2020 Dawah Nigeria. All rights reserved.
//

import UIKit

class OurInitiativeViewController: BaseFile {

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

    @IBAction func showQuran(_ sender: Any) {
        //show quran website
        let webViewVC = WebViewController(nibName: "WebViewController", bundle: nil)
        webViewVC.url = "https://quranopedia.com/"
        self.navigationController?.pushViewController(webViewVC, animated: true)
    }
   
    
    @IBAction func showDeenQuiz(_ sender: UIButton) {
        let webViewVC = WebViewController(nibName: "WebViewController", bundle: nil)
        webViewVC.url = "https://deenquiz.com/"
        self.navigationController?.pushViewController(webViewVC, animated: true)
    }
    
    
    @IBAction func showProjects(_ sender: UIButton) {
        let webViewVC = WebViewController(nibName: "WebViewController", bundle: nil)
        webViewVC.url = "https://dawahnigeria.com/highlight/"
        self.navigationController?.pushViewController(webViewVC, animated: true)
    }
    
    
    @IBAction func showDawahCast(_ sender: UIButton) {
        let webViewVC = WebViewController(nibName: "WebViewController", bundle: nil)
        webViewVC.url = "https://dawahnigeria.com/discs"
        self.navigationController?.pushViewController(webViewVC, animated: true)
    }
    
    
    @IBAction func showArticles(_ sender: UIButton) {
        let webViewVC = WebViewController(nibName: "WebViewController", bundle: nil)
        webViewVC.url = "https://dawahnigeria.com/articles/"
        self.navigationController?.pushViewController(webViewVC, animated: true)
    }
    
    @IBAction func showQuran2(_ sender: UIButton) {
        let webViewVC = WebViewController(nibName: "WebViewController", bundle: nil)
        webViewVC.url = "https://dawahnigeria.com/recitations/"
        self.navigationController?.pushViewController(webViewVC, animated: true)
    }
    
    @IBAction func showTafseer(_ sender: UIButton) {
        let webViewVC = WebViewController(nibName: "WebViewController", bundle: nil)
        webViewVC.url = "https://dawahnigeria.com/dawahcast/"
        self.navigationController?.pushViewController(webViewVC, animated: true)
    }
    
    @IBAction func showQuranService(_ sender: UIButton) {
        let webViewVC = WebViewController(nibName: "WebViewController", bundle: nil)
        webViewVC.url = "https://dawahnigeria.com/qs/"
        self.navigationController?.pushViewController(webViewVC, animated: true)
    }
    
    @IBAction func showMarketPlace(_ sender: UIButton) {
        let webViewVC = WebViewController(nibName: "WebViewController", bundle: nil)
        webViewVC.url = "https://dawahnigeria.com/marketplace/"
        self.navigationController?.pushViewController(webViewVC, animated: true)
    }
    
    
    @IBAction func showDirectory(_ sender: UIButton) {
        let webViewVC = WebViewController(nibName: "WebViewController", bundle: nil)
        webViewVC.url = "https://dawahnigeria.com/directory/"
        self.navigationController?.pushViewController(webViewVC, animated: true)
    }
    
    
    @IBAction func showCase(_ sender: UIButton) {
        let webViewVC = WebViewController(nibName: "WebViewController", bundle: nil)
        webViewVC.url = "https://dawahnigeria.com/showcase/"
        self.navigationController?.pushViewController(webViewVC, animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
