//
//  MainViewReciterCell.swift
//  Quran247
//
//  Created by Jimoh Babatunde  on 13/05/2020.
//  Copyright © 2020 Dawah Nigeria. All rights reserved.
//

import UIKit

enum MusicControls {
    case download
}

protocol MainViewReciterCellDelegate: class {
    func didTapMusicControls(controls: MusicControls, pos: Int)
}

class MainViewReciterCell: UITableViewCell {

    @IBOutlet weak var download: UIImageView?
    @IBOutlet weak var reciterName: UILabel?
    public weak var delegate: MainViewReciterCellDelegate?
   // var didTap: (() -> ())?
    var index: IndexPath?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("i dey here")
        // Initialization code
        
        let tapDownload = UITapGestureRecognizer.init(target: self, action: #selector(self.download(_:)))
        tapDownload.numberOfTapsRequired = 1
        self.download?.addGestureRecognizer(tapDownload)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func download(_ sender: UITapGestureRecognizer) {
        self.delegate?.didTapMusicControls(controls: .download, pos: index!.row)
    }
    
    func updateCell(reciterName: String) {
        self.reciterName?.text = reciterName
    }
    
    
    
    
}
