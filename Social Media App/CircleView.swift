//
//  CircleView.swift
//  Social Media App
//
//  Created by Matthew Wells on 2016-08-28.
//  Copyright © 2016 Matthew Wells. All rights reserved.
//

import UIKit

class CircleView: UIImageView {

    override func layoutSubviews() {
       
    
       
        layer.cornerRadius = self.frame.width / 2
    
        
    }
}
