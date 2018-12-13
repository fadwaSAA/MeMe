//
//  Meme1.swift
//  MemeMe
//
//  Created by فدوى العسكر on 19/03/1440 AH.
//  Copyright © 1440 فدوى العسكر. All rights reserved.
//

import UIKit
struct Meme {
    var topText:String!
    var bottomText:String!
    var originalImage:UIImage!
    var memedImage:UIImage!
    init (topText: String, bottomText: String, originalImage: UIImage, memedImage: UIImage){
        
        self.topText=topText
        self.bottomText=bottomText
        self.originalImage=originalImage
        self.memedImage=memedImage
        
        
    }
}
