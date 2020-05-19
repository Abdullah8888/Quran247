//
//  ViewController.swift
//  Quran247
//
//  Created by Jimoh Babatunde  on 11/05/2020.
//  Copyright © 2020 Dawah Nigeria. All rights reserved.
//

import UIKit
import AVFoundation
import RKDropdownAlert

class ViewController: BaseFile, UITableViewDelegate, MainViewModelDelegate {
    
    @IBOutlet weak var displayTime: UILabel?
    @IBOutlet weak var imgBtn: UIImageView?
    
    
    @IBOutlet weak var indicator: UIActivityIndicatorView?
    @IBOutlet weak var currentReciter: UILabel?
    @IBOutlet weak var tableView: UITableView?
    private let viewModel = MainViewModel()
    var audioPlayer : AVPlayer!
    var player:AVAudioPlayer = AVAudioPlayer()
    var checkForPlay = true
    var isPlayerPlayedFinish = false
    private var timer: Timer?
    private var timer2: Timer?
    private var counter = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.viewModel.delegate = self
        tableView?.delegate = self
        self.viewModel.registerReusableViewsForTableView(tableView: tableView!)
        self.viewModel.getAllReciters()
        
        view.bringSubview(toFront: self.currentReciter!)
        view.bringSubview(toFront: self.imgBtn!)
        view.bringSubview(toFront: self.displayTime!)
    
        //view.bringSubview(toFront: self.indicator!)
        
        let tapMusicIcon = UITapGestureRecognizer.init(target: self, action: #selector(self.changeMusicState(_:)))
        tapMusicIcon.numberOfTapsRequired = 1
        self.imgBtn?.addGestureRecognizer(tapMusicIcon)
        
        NotificationCenter.default.addObserver(self,
        selector: #selector(playerItemDidReachEnd),
                  name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                  object: nil)
        
       
        //self.checkInternet()
       // timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(expiringTime), userInfo: nil, repeats: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.indicator?.startAnimating()
    }
  
    
    // Notification Handling
    @objc func playerItemDidReachEnd(notification: NSNotification) {
        self.isPlayerPlayedFinish = true
    }
    // Remove Observer
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func changeMusicState(_ sender: UITapGestureRecognizer) {
        //change to pause
    
        print("yyyy")
        if let reciter = self.currentReciter?.text {
            if !reciter.isEmpty {
                print("asdf")
                if checkForPlay {
                    self.imgBtn?.image = UIImage(named: "iconplay")
                    self.audioPlayer.play()
                    self.checkForPlay = false
                   
                }
                else {
                    if self.audioPlayer.timeControlStatus == AVPlayer.TimeControlStatus.playing {
                        self.checkForPlay = true
                        self.imgBtn?.image = UIImage(named: "iconpause")
                        self.audioPlayer.pause()
                    }
                    else {
                        print("nothing is playing")
                        self.displayDropDownAlertWithTitle(title: "Error", message: "A reciter must be selected", error: true)
                    }
                    
                }
            }
            else {
                print("reciter gat to be selected")
                self.displayDropDownAlertWithTitle(title: "Error", message: "A reciter must be selected", error: true)
            }
        }
    }
    
    @IBAction func didTapMenu(_ sender: UIBarButtonItem) {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else { return }
        menuViewController.didTapMenu = { menuType in
            print("this is \(menuType)")
            self.navigateToNewView(menuType: menuType)
        }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)

    }
    
    func navigateToNewView(menuType: MenuType) {
        
        switch menuType {
           case .home:
               print("home")
           case .support:
                let webViewVC = WebViewController(nibName: "WebViewController", bundle: nil)
                webViewVC.url = "https://dawahnigeria.com/support"
                self.navigationController?.pushViewController(webViewVC, animated: true)
           case .ourInitiatives:
                let ourInitiativeVC = OurInitiativeViewController(nibName: "OurInitiativeViewController", bundle: nil)
                self.navigationController?.pushViewController(ourInitiativeVC, animated: true)
           case .share:
               self.share()
           case .aboutDn:
                let aboutUsVC = AboutUsViewController(nibName: "AboutUsViewController", bundle: nil)
                self.navigationController?.pushViewController(aboutUsVC, animated: true)

        }
        
    }
    
    func share() {
        let messageToShare = """
                                Share Assalam alaykum warahmotullahi wabarokatu, I am usig an awesome app "Quran247"
                                to sream Quran from various Nigerian reciters, anytime anywhere. You should try it too
                             """
    
        let shareActivityVC = UIActivityViewController(activityItems: [messageToShare], applicationActivities: nil)
        shareActivityVC.popoverPresentationController?.sourceView = self.view
        
        present(shareActivityVC, animated: true, completion: nil)
        
    }
    
    func MainViewModelDidChangeState(state: MainviewModelState) {
        switch state {
        case .MainViewDidFetchSuccessful:
            print("yes k")
            tableView?.reloadData()
            self.indicator?.stopAnimating()
            self.indicator?.isHidden = true
        case .MainViewDidFetchFail:
            print("error while trying to fetch reciters")
        }
        
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200.0
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = PlayerViewController(nibName: "PlayerViewController", bundle: nil)
//        self.navigationController?.pushViewController(vc, animated: true)
//        print("i'm clicked pa")
        //self.displayDropDownAlertWithTitle(title: "Loading ... ", message: "Please wait while reciter loads", error: false)
        self.showIndicator(withActivity: true)
        self.checkForPlay = false
        self.isPlayerPlayedFinish = false
        self.displayTime?.text = "00:00"
        let reciterName = self.viewModel.reciterNames[indexPath.item]
        let reciterUrl = self.viewModel.mountPoint[indexPath.item]
        
        self.currentReciter?.text = reciterName
        //self.play(reciterUrl: reciterUrl) //This should work whenn ssl for url is fixed
        let ss = "https://www.computerhope.com/jargon/m/example.mp3"
        let ss1 = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"
        self.play(reciterUrl: ss1)
        //self.playy()
    }

   
    func downloadReciter(dawahCastUrl: String) {
        print("wanna download this \(dawahCastUrl)")
        let webViewVC = WebViewController(nibName: "WebViewController", bundle: nil)
        webViewVC.url = dawahCastUrl
        self.navigationController?.pushViewController(webViewVC, animated: true)
    }
    
    func playy() {
        let dd = Bundle.main.url(forResource: "song", withExtension: "mp3")
        do {
                //AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
                self.player = try AVAudioPlayer(contentsOf: dd!)
                player.prepareToPlay()
                //player.volume = 1.0
                player.play()
            } catch let error as NSError {
                //self.player = nil
                print(error.localizedDescription)
            } catch {
                print("AVAudioPlayer init failed")
            }

        }
    
    func play(reciterUrl: String) {
        print("here i am")
        DispatchQueue.main.async {
            guard let url = URL.init(string: reciterUrl) else {
                print("url seems to be wrong or contains error")
                return
            }
            let playerItem = AVPlayerItem(url: url)
            self.audioPlayer = AVPlayer(playerItem: playerItem)
            self.audioPlayer.play()
            
            
            let interval = CMTime(value: 1, timescale: 2)
            self.audioPlayer.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { [weak self] time in
                    print("Av here")
                if self?.audioPlayer.currentItem?.status == AVPlayerItem.Status.readyToPlay {
                    self?.stopIndicator()
                    print("AVPlayer is ready to play")
                    let seconds = CMTimeGetSeconds(time)
                    let secondsString = String(format: "%02d", Int(seconds.truncatingRemainder(dividingBy: 60)))
                    let minutesString = String(format: "%02d", Int(seconds / 60))
                    self?.displayTime?.text = "\(minutesString):\(secondsString)"
                    
//                    if let isPlaybackLikelyToKeepUp = self?.audioPlayer?.currentItem?.isPlaybackLikelyToKeepUp {
//                        if isPlaybackLikelyToKeepUp{
////                            self.loadingIndicator.isHidden = true
////                            self.playPauseButton.isHidden = false
//                            print("seem to be loaind")
//                        }
//                    }
                  
                }
               
                if self?.audioPlayer.currentItem?.status == AVPlayerItem.Status.failed {
                    print("AVPlayer failed")

                }

                if self?.audioPlayer.currentItem?.status == AVPlayerItem.Status.unknown {
                    print("AVPlayer is unknown")
                }
               })
        }
       
    }
    
}

extension ViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        SideMenuTransition.sharedInstance.isPresenting = true
        return SideMenuTransition.sharedInstance
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        SideMenuTransition.sharedInstance.isPresenting = false
        return SideMenuTransition.sharedInstance
    }
    

}

