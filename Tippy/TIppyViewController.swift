//
//  TIppyViewController.swift
//  Tippy
//
//  Created by Diana Fisher on 8/12/17.
//  Copyright © 2017 Diana Fisher. All rights reserved.
//

import UIKit
import Foundation

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
    
    @IBOutlet weak var taxPercentageLabel: UILabel!
    
    // MARK: - Stored Properties
    var tipPercentage: Double = 0.0
    var taxPercentage: Double = 0.0
    var useTaxInCalculation: Bool = true
    
    var guestCount: Int = 1
    var checkNumber: Int = 1
    
    let minGuestCount: Int = 1
    let maxGuestCount: Int = 10000
    
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
        
        // Recalculate tip
        calculateTip()
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
        
        // Recalculate tip
        calculateTip()
    }
    
    
    @IBAction func tipSuggestionsPressed(_ sender: Any) {
        // Show tip suggestions
    }
    
    @IBAction func viewTapped(_ sender: Any) {
        
        // Dismiss the keyboard
        view.endEditing(true)
    }
    
    @IBAction func calculate(_ sender: Any) {
        calculateTip()
    }
    
    // MARK: - Convenience
    
    func loadSettings() {
        
        print(UserDefaultsManager.useDarkTheme)
        
        // Tip Percentage
        tipPercentage = max(UserDefaultsManager.tipPercentage, 0)
                
        // Use Tax
        useTaxInCalculation = UserDefaultsManager.useTax
        print("use tax: \(useTaxInCalculation)")
        
        
        // Guest Count
        guestCount = max(UserDefaultsManager.guestCount, 1)
        
        // Check Number
        checkNumber = max(UserDefaultsManager.checkNumber, 1)
        
    }
    
    func initializeViews() {
        
        // Set tip percentage label text
        tipPercentageLabel.text = String(format: "(%.2f)%", tipPercentage)
                
        // Set guest count label text
        guestCountLabel.text = "\(guestCount)"
        
        // Enable/Disable plus and minus buttons
        checkMinusButton()
        checkPlusButton()
        
        // Set the date label text
        formatDate()
        
        // Set the check number label text
        formatCheckNumber()
        
        // Set the bill total text field as the first responder
        billTotalField.becomeFirstResponder()
    }
    
    func formatCheckNumber() {
        
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 4
        formatter.maximumIntegerDigits = 4
        
        let nsCheckNumber = NSNumber.init(value: checkNumber)
        
        let value = formatter.string(from: nsCheckNumber) ?? "0001"
        
        checkNumberLabel.text = value
        
    }
    
    
    func calculateTip() {
        let bill = Double(billTotalField.text!) ?? 0.0
        print("bill: \(bill)")
        
        let tax = Double(taxField.text!) ?? 0.0
        print("tax: \(tax)")
        
        let subTotal: Double = bill + tax
        print("subtotal: \(subTotal)")
        
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
        
        subtotalLabel.text = String(format: "$%.2f", subTotal)
        tipLabel.text =  String(format: "$%.2f", tip)
        totalLabel.text =  String(format: "$%.2f", total)
        perPersonAmountLabel.text =  String(format: "$%.2f", perPerson)
        
        
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
