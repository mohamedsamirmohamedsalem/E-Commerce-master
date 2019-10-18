//
//  TabBar.swift
//  Project
//
//  Created by Mahmoud helmy on 6/29/19.
//  Copyright © 2019 Mahmoud helmy. All rights reserved.
//

import UIKit

class TabBar: UITabBarController {
    


    var circle: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let numberOfItems = CGFloat(tabBar.items!.count)
        let tabBarItemSize = CGSize(width: (tabBar.frame.width / numberOfItems) - 20, height: tabBar.frame.height)
        circle = UIView(frame: CGRect(x: 0, y: -15, width: tabBarItemSize.height + 30 , height: tabBarItemSize.height + 30 ))
        
        circle?.backgroundColor = .white
        circle?.layer.cornerRadius = circle!.frame.width/2
        circle?.alpha = 0
        circle?.layer.borderWidth = 1.0
        circle?.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        tabBar.addSubview(circle!)
        tabBar.sendSubviewToBack(circle!)
        self.selectedIndex = 2
        circle?.layer.borderColor = #colorLiteral(red: 1, green: 0.4117647059, blue: 0.4156862745, alpha: 1)
       
        
     //  UITabBarItam item = []
        
     


        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       // let index = -(tabBar.items?.firstIndex(of: tabBar.selectedItem!)?.distance(to: 0))!
       let frame = frameForTabAtIndex(index: 2)
        circle?.center.x = frame.origin.x + frame.width/2
        circle?.alpha = 1
        if BBB.integer(forKey: "Badge") == 0
        {
            self.tabBar.items![1].badgeValue = nil
        } else {
            
            self.tabBar.items![1].badgeValue = "\(BBB.integer(forKey: "Badge"))"
            self.tabBar.items![1].badgeColor = #colorLiteral(red: 1, green: 0.4117647059, blue: 0.4156862745, alpha: 1)
        }
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let index = -(tabBar.items?.firstIndex(of: item)?.distance(to: 0))!
       // let frame = frameForTabAtIndex(index: 2)
   // self.circle?.center.x = frame.origin.x + frame.width/2
        if index == 2
        {
            self.circle?.layer.borderColor = #colorLiteral(red: 1, green: 0.4117647059, blue: 0.4156862745, alpha: 1)
            
          
        } else if index == 1 {
            BBB.set(0, forKey: "Badge")
            self.tabBar.items![1].badgeValue = nil
            circle?.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)



           
        } else {
             circle?.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
        //tabBar.centerXAnchor.constraint(equalTo: circle!.centerXAnchor).isActive = true
       // tabBar.topAnchor.constraint(equalTo: circle!.centerYAnchor).isActive = true
    }
    
    func frameForTabAtIndex(index: Int) -> CGRect {
        var frames = tabBar.subviews.compactMap { (view:UIView) -> CGRect? in
            if let view = view as? UIControl {
                for item in view.subviews {
                    if let image = item as? UIImageView {
                        return image.superview!.convert(image.frame, to: tabBar)
                    }
                }
                return view.frame
            }
            return nil
        }
        frames.sort { $0.origin.x < $1.origin.x }
        if frames.count > index {
            return frames[index]
        }
        return frames.last ?? CGRect.zero
    }

}


