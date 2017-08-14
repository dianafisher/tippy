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
            
            sourceVC.navigationController?.pushViewController(destVC, animated: true)
        })
        
    }
}
