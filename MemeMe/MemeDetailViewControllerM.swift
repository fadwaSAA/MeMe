//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by فدوى العسكر on 19/03/1440 AH.
//  Copyright © 1440 فدوى العسكر. All rights reserved.
//

import UIKit
class MemeDetailViewControllerM: UIViewController {
    var meme : Meme!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         self.tabBarController?.tabBar.isHidden = true
        self.imageView!.image = meme.memedImage
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
}
