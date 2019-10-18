//
//  ImageAF.swift
//  Project
//
//  Created by Mahmoud helmy on 7/7/19.
//  Copyright © 2019 Mahmoud helmy. All rights reserved.
//

import UIKit
import AlamofireImage

class SetImage {
    
    class func setImage(ImageUrl: String , ImageView : UIImageView) {
        var swap = ImageUrl
        if (swap.contains(" ")) {
            swap = swap.replacingOccurrences(of: " ", with: "%20")
        }
        
        if swap != ""{
            
            
           // let encodedUrl = swap.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            
            guard let url = URL(string: ImageUrl) else  { return  }
         //   let url = URL(string: swap)
            let placeholderImage = UIImage(named: "next")
            
            let filter = AspectScaledToFillSizeWithRoundedCornersFilter(
                size: ImageView.frame.size,
                radius: 0
            )
            
            ImageView.af_setImage(
                withURL: url,
                placeholderImage: placeholderImage,
                filter: filter,
                imageTransition: .crossDissolve(0.5)
            )
            
        }else{
            ImageView.image = UIImage(named: "next")!
        }
        
    }
    
    
}
