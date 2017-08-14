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
    
    var guestCount: Int = 1
    var tipPercentage: Int = 0
    var includeTax: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadSettings()
        initializeViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // save values
        saveSettings()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }        
    
    func loadSettings() {
        
        // tipPercentaage
        tipPercentage = UserDefaultsManager.tipPercentage
        
        // useTaxInCalculation
        includeTax = UserDefaultsManager.useTax
        
        // guestCount
        guestCount = max(UserDefaultsManager.guestCount, 1)
        
    }
    
    func saveSettings() {
        // Save the settings in User Defaults
        
        UserDefaultsManager.guestCount = guestCount
        UserDefaultsManager.tipPercentage = tipPercentage
        UserDefaultsManager.useTax = includeTax
    }
    
    func initializeViews() {
        
        tipPercentageField.text = "\(tipPercentage)"
        includeTaxSwitch.isOn = includeTax
        guestCountField.text = "\(guestCount)"
    }
    
    // MARK: - IBActions
    
    @IBAction func tipPercentageChanged(_ sender: Any) {
        
        tipPercentage = Int(tipPercentageField.text!) ?? 0
        
        // Make sure the tip percentage is not greater than 100
        tipPercentage = min(tipPercentage, 100)
        
        // Make sure the tip percentage is not less than 0
        tipPercentage = max(tipPercentage, 0)
    }

    @IBAction func includeTaxValueChanged(_ sender: Any) {
        
        includeTax = includeTaxSwitch.isOn
    }
                
    @IBAction func guestCountChanged(_ sender: Any) {
        
        guestCount = Int(guestCountField.text!) ?? 1
        
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
