//
//  SettingsViewController.swift
//  Tippy
//
//  Created by Diana Fisher on 8/10/17.
//  Copyright © 2017 Diana Fisher. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipPercentageField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadSettings()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }    
    
    func loadSettings() {
        
        let defaults = UserDefaults.standard
        let defaultTipPercentage = defaults.integer(forKey: "tipPercentage")
        print("loaded \(defaultTipPercentage)")
        
        // set the text on our text field
        tipPercentageField.text = "\(defaultTipPercentage)"
    }
    
    func saveSettings() {
        let defaults = UserDefaults.standard
        
        var tipPercentage = Int(tipPercentageField.text!) ?? 0
        
        // make sure the tip percentage is not greater than 100
        tipPercentage = min(tipPercentage, 100)
        // make sure the tip percentage is not less than 0
        tipPercentage = max(tipPercentage, 0)
        
        // save the tip percentage to User Defaults
        defaults.set(tipPercentage, forKey:"tipPercentage")
    }
    
    @IBAction func tipPercentageChanged(_ sender: Any) {
        saveSettings()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}