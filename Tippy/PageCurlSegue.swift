//
//  PageCurlSegue.swift
//  Tippy
//
//  Created by Diana Fisher on 8/11/17.
//  Copyright © 2017 Diana Fisher. All rights reserved.
//

import UIKit

class PageCurlSegue: UIStoryboardSegue {
    
    override func perform() {
        let destVC = destination
        let sourceVC = source

        UIView .transition(from: sourceVC.view, to: destVC.view, duration: 0.6, options: UIViewAnimationOptions.transitionCurlUp, completion: { finished in
            let sourceVC = self.source
            let destVC = self.destination
            
            sourceVC.navigationController?.present(destVC, animated: false, completion: nil)
//            sourceVC.navigationController?.pushViewController(destVC, animated: false)
        })
        
        
        
        
//        destVC.view.layer.anchorPoint = CGPoint.zero
//        sourceVC.view.layer.anchorPoint = CGPoint.zero
//        
//        destVC.view.layer.position = CGPoint.zero
//        sourceVC.view.layer.position = CGPoint.zero
//        
//        let containerView: UIView? = sourceVC.view.superview
//        destVC.view.transform = CGAffineTransfor
    }
}
