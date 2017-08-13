//
//  UserDefaultsManager.swift
//  Tippy
//
//  Created by Diana Fisher on 8/12/17.
//  Copyright © 2017 Diana Fisher. All rights reserved.
//

import UIKit

class UserDefaultsManager: NSObject {
    
    private static let useDarkThemeKey = "useDarkThemeKey"
    private static let tipPercentageKey = "tipPercentage"
    private static let useTaxKey = "useTaxInCalculation"
    private static let checkNumberKey = "checkNumber"
    private static let guestCountKey = "guestCount"
    
    static var useDarkTheme: Bool {
        get {
            return UserDefaults.standard.bool(forKey: useDarkThemeKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: useDarkThemeKey)
        }
    }
    
    static var tipPercentage: Int {
        get {
            return UserDefaults.standard.integer(forKey: tipPercentageKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: tipPercentageKey)
        }
    }
    
    static var useTax: Bool {
        get {
            return UserDefaults.standard.bool(forKey: useTaxKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: useTaxKey)
        }
    }
    
    static var checkNumber: Int {
        get {
            return UserDefaults.standard.integer(forKey: checkNumberKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: checkNumberKey)
        }
    }
    
    static var guestCount: Int {
        get {
            return UserDefaults.standard.integer(forKey: guestCountKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: guestCountKey)
        }
    }
    
    
}
