//
//  ARVPopupMenuItem.swift
//  ARVPopupMenu
//
//  Created by Arvindh Sukumar on 08/03/15.
//  Copyright (c) 2015 Arvindh Sukumar. All rights reserved.
//

import UIKit

class ARVPopupMenuItem: NSObject {
   
    var title: String = ""
    var image: UIImage!
    
    convenience init(title:String,image:UIImage!){
        self.init()
        self.title = title
        self.image = image
    }
}
