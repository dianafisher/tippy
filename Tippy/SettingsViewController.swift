//
//  SettingsViewController.swift
//  Tippy
//
//  Created by Diana Fisher on 8/10/17.
//  Copyright © 2017 Diana Fisher. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet weak var tipPercentageField: UITextField!
    @IBOutlet weak var includeTaxSwitch: UISwitch!
    @IBOutlet weak var guestCountField: UITextField!
    
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
        
        // tipPercentaage
        let tipPercentage = UserDefaultsManager.tipPercentage
        // set the text on our text field
        tipPercentageField.text = "\(tipPercentage)"
        
        // useTaxInCalculation
        let useTaxInCalculation = UserDefaultsManager.useTax
        includeTaxSwitch.isOn = useTaxInCalculation
        
        // guestCount
        let guestCount = UserDefaultsManager.guestCount
        guestCountField.text = "\(guestCount)"
    }
    
    // MARK: - IBActions
    
    @IBAction func tipPercentageChanged(_ sender: Any) {
        
        var tipPercentage = Double(tipPercentageField.text!) ?? 0
        
        // Make sure the tip percentage is not greater than 100
        tipPercentage = min(tipPercentage, 100.0)
        
        // Make sure the tip percentage is not less than 0
        tipPercentage = max(tipPercentage, 0)

        // Save the new setting in User Defaults
        UserDefaultsManager.tipPercentage = tipPercentage
    }

    @IBAction func includeTaxValueChanged(_ sender: Any) {
        
        let includeTax = includeTaxSwitch.isOn
        
        // Save the new setting in User Defaults
        UserDefaultsManager.useTax = includeTax
    }
                
    @IBAction func guestCountChanged(_ sender: Any) {
        
        var guestCount = Int(guestCountField.text!) ?? 1
        
        // Make sure the guest count is not less than 1
        guestCount = max(guestCount, 1)
        
        // Save the new setting in User Defaults
        UserDefaultsManager.guestCount = guestCount
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
