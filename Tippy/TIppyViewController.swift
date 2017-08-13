//
//  TIppyViewController.swift
//  Tippy
//
//  Created by Diana Fisher on 8/12/17.
//  Copyright © 2017 Diana Fisher. All rights reserved.
//

import UIKit

class TIppyViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var guestCountLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var checkNumberLabel: UILabel!
    
    @IBOutlet weak var billTotalField: UITextField!
    
    @IBOutlet weak var taxField: UITextField!
    
    @IBOutlet weak var subtotalLabel: UILabel!
    
    @IBOutlet weak var tipLabel: UILabel!
    
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var perPersonAmountLabel: UILabel!
    
    @IBOutlet weak var tipPercentageLabel: UILabel!
    
    @IBOutlet weak var minusButton: UIButton!
    
    @IBOutlet weak var plusButton: UIButton!
    
    
    // MARK: - Stored Properties
    var tipPercentage: Int = 0
    var useTaxInCalculation: Bool = true
    var guestCount: Int = 1
    
    let minGuestCount: Int = 1
    let maxGuestCount: Int = 5 //10000
    
    lazy var dateFormatter = DateFormatter()
    
    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("view will appear")
        /* 
         Load settings in viewWillAppear since it will get called every time the view is about to appear.
         If we only wanted to update the values once, we would use viewDidLoad since that is only called 
         once when the view has been loaded into memory.
         */
        
        loadSettings()
        initializeViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    
    @IBAction func guestCountPlusPressed(_ sender: Any) {

        // Increase the guest count if it is less than 10000
        if (guestCount < maxGuestCount) {
            guestCount += 1
        }
        
        checkPlusButton()
        
        // Enable the minus button, if it is disabled.
        if (guestCount > minGuestCount && !minusButton.isEnabled) {
            minusButton.isEnabled = true
            minusButton.setNeedsDisplay()
        }
        
        // Update the label
        guestCountLabel.text = "\(guestCount)"
    }
    
    @IBAction func guestCountMinusPressed(_ sender: Any) {
        
        // Decrease the guest count if it is greater than one
        if (guestCount > minGuestCount) {
            guestCount -= 1
        }
        
        checkMinusButton()
        
        // Enable the plus button, if it is disabled.
        if (guestCount < maxGuestCount && !plusButton.isEnabled) {
            plusButton.isEnabled = true
            plusButton.setNeedsDisplay()
        }
        
        // Update the label
        guestCountLabel.text = "\(guestCount)"
    }
    
    
    @IBAction func tipSuggestionsPressed(_ sender: Any) {
        // Show tip suggestions
    }
    
    // MARK: - Convenience
    
    func loadSettings() {
        
        print(UserDefaultsManager.useDarkTheme)
        
        // Tip Percentage
        let defaultTipPercentage = UserDefaultsManager.tipPercentage
        
        print("loaded \(defaultTipPercentage)")
        
        if (defaultTipPercentage != 0) {
            tipPercentage = defaultTipPercentage
        }
        
        // Use Tax
        useTaxInCalculation = UserDefaultsManager.useTax
        
        
    }
    
    func initializeViews() {
        
        tipPercentageLabel.text = "(\(tipPercentage)%)"
        
        guestCountLabel.text = "\(guestCount)"
        
        checkMinusButton()
        checkPlusButton()
        
        formatDate()
    }
    
    func calculateTip() {
        let bill = Double(billTotalField.text!) ?? 0
        let tax = Double(taxField.text!) ?? 0
        
        let subTotal: Double = bill + tax
        subtotalLabel.text = "\(subTotal)"
        print(subTotal)
        
        let tipFraction: Double = Double(tipPercentage) / 100.0
        print(tipFraction)
        
        var tip: Double = 0.0
        if (useTaxInCalculation) {
            tip = subTotal * tipFraction
            
        } else {
            tip = bill * tipFraction
        }
        
        let total: Double = subTotal + tip
        let perPerson: Double = total / Double(guestCount)
        
        tipLabel.text = "\(tip)"
        totalLabel.text = "\(total)"
        perPersonAmountLabel.text = "\(perPerson)"
        
    }
    
    func checkMinusButton() {
        
        if (guestCount < minGuestCount+1) {
            // Disable the minus button
            minusButton.isEnabled = false
            
            // Update display of the minusButton
            minusButton.setNeedsDisplay()
        }
    }
    
    func checkPlusButton() {
        if (guestCount > maxGuestCount-1) {
            // Disable the plus button
            plusButton.isEnabled = false
            
            // Update display of the plus button
            plusButton.setNeedsDisplay()
        }
    }
    
    func formatDate() {
        // Get today's date
        let date = Date()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let result = dateFormatter.string(from: date)
        dateLabel.text = result
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
