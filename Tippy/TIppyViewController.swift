//
//  TIppyViewController.swift
//  Tippy
//
//  Created by Diana Fisher on 8/12/17.
//  Copyright © 2017 Diana Fisher. All rights reserved.
//

import UIKit
import Foundation

class TIppyViewController: UIViewController, UITextFieldDelegate {

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
    
    @IBOutlet weak var tipPlusButton: UIButton!
    
    @IBOutlet weak var tipMinusButton: UIButton!
    
    @IBOutlet weak var guestCountLabel2: UILabel!
    
    @IBOutlet weak var includeTaxSwitch: UISwitch!
    
    // MARK: - Stored Properties
    var tipPercentage: Int = 0
    var taxPercentage: Double = 0.0
    var billAmount: Double = 0.0
    var useTaxInCalculation: Bool = true
    
    var guestCount: Int = 1
    var checkNumber: Int = 1
    
    let minGuestCount: Int = 1
    let maxGuestCount: Int = 10000
    let maxBillValue: Double = 10000000.00
    let maxTaxValue: Double = 10000000.00
    
    lazy var dateFormatter = DateFormatter()
    
    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        billTotalField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /*
         Load settings in viewWillAppear since it will get called every time the view is about to appear.
         If we only wanted to update the values once, we would use viewDidLoad since that is only called 
         once when the view has been loaded into memory.
         */
                
        loadSettings()
        initializeViews()
        
        // Recalculate tip
        calculateTip()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // save the current bill total to user defaults
        let billAmount = Double(billTotalField.text!) ?? 0.0

        UserDefaultsManager.lastBillAmount = billAmount
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
        
        formatGuestCount()
        
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
        
        formatGuestCount()
        
        // Recalculate tip
        calculateTip()
    }
    
    @IBAction func tipPlusPressed(_ sender: Any) {
        
        // Increaese tip percentage if it is less than 100
        if (tipPercentage < 100) {
            tipPercentage += 1
        }
        
        checkTipPlusButton()
        
        // Enable the tip minus button, if it is disabled
        if (tipPercentage > 0 && !tipMinusButton.isEnabled) {
            tipMinusButton.isEnabled = true
            tipMinusButton.setNeedsDisplay()
        }
        
        formatTipPercentage()
        
        // Recalculate tip
        calculateTip()
    }
    
    @IBAction func tipMinusPressed(_ sender: Any) {
        
        // Decrease the tip percentage if it is greater than 0
        if (tipPercentage > 0) {
            tipPercentage -= 1
        }
        
        checkTipMinusButton()
        
        // Enable the tip plus button, if it is
        if (tipPercentage < 100 && !tipPlusButton.isEnabled) {
            tipPlusButton.isEnabled = true
            tipPlusButton.setNeedsDisplay()
        }
        
        formatTipPercentage()
        
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
    
    @IBAction func includeTaxSwitchChanged(_ sender: Any) {
        useTaxInCalculation = includeTaxSwitch.isOn
        
        calculateTip()
    }
    
    // MARK: - Formatters
    
    func formatCurrency(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: Locale.current.identifier)
        let result = formatter.string(from: value as NSNumber)
        return result!
    }
    
    func formatBillAmount() {
        billTotalField.text = String(format: "%.2f", billAmount)
    }
    
    func formatCheckNumber() {
        
        // Format the check number with leading zeroes
        let formatter = NumberFormatter()
        formatter.minimumIntegerDigits = 4
        formatter.maximumIntegerDigits = 4
        
        let nsCheckNumber = NSNumber.init(value: checkNumber)
        
        let value = formatter.string(from: nsCheckNumber) ?? "0001"
        
        checkNumberLabel.text = value
    }
    
    func formatGuestCount() {
        
        // Update the guest count labels
        guestCountLabel.text = "\(guestCount)"
        guestCountLabel2.text = "\(guestCount)"
    }
    
    func formatTipPercentage() {
        
        // Update the tip percentage label.
        tipPercentageLabel.text = "(\(tipPercentage)%)"
    }
    
    func formatDate() {
        // Get today's date
        let date = Date()
        
        // Format the date as MM/dd/yyyy
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        let result = dateFormatter.string(from: date)
        dateLabel.text = result
    }

    // MARK: - UITextFieldDeletage
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if (textField == billTotalField) {
            
            // Show an alert if the billTotalField value is invalid.
            let value = Double(billTotalField.text!) ?? 0
            if (value > maxBillValue) {
                let okButtonTitle = NSLocalizedString("OK", comment: "")
                
                let formattedValue = String(format: "$%.2f", maxBillValue)
                let alertController = UIAlertController(title: "Invalid Input", message: "Bill Total must be less than $\(formattedValue)", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: okButtonTitle, style: .default) { _ in
                    
                }
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: { 
                    
                })
                
                return false
            }
        }
        if (textField == taxField) {
            let value = Double(taxField.text!) ?? 0
            if (value > maxTaxValue) {
                
                let okButtonTitle = NSLocalizedString("OK", comment: "")
                
                let formattedValue = String(format: "$%.2f", maxTaxValue)
                let alertController = UIAlertController(title: "Invalid Input", message: "Tax must be less than $\(formattedValue)", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: okButtonTitle, style: .default) { _ in
                    
                }
                
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: {
                    
                })
                
                
                return false
            }
        }
        return true
    }
    
    // MARK: - Convenience
    
    func loadSettings() {
        
        // Bill Amount
        billAmount = UserDefaultsManager.lastBillAmount
        
        // Tip Percentage
        tipPercentage = max(UserDefaultsManager.tipPercentage, 0)
        
        // Use Tax
        useTaxInCalculation = UserDefaultsManager.useTax        
        
        // Guest Count
        guestCount = max(UserDefaultsManager.guestCount, 1)        
        
        // Check Number
        checkNumber = max(UserDefaultsManager.checkNumber, 1)
        
    }
    
    func initializeViews() {
        
        // Set bill amount
        formatBillAmount()
        
        // Set tip percentage label text
        formatTipPercentage()
                
        // Set guest count label text
        formatGuestCount()
        
        // Enable/Disable plus and minus buttons
        checkMinusButton()
        checkPlusButton()
        
        // Set the date label text
        formatDate()
        
        // Set the check number label text
        formatCheckNumber()
        
        // Set the guest count
        formatGuestCount()
        
        // set include tax switch value
        includeTaxSwitch.isOn = useTaxInCalculation
        
        // Set the bill total text field as the first responder
        billTotalField.becomeFirstResponder()
    }
    
    func calculateTip() {
        
        // Get the bill and tax amounts from the text fields.
        let bill = Double(billTotalField.text!) ?? 0.0
        
        // If the bill is over the maximum value, skip the rest.
        if (bill > maxBillValue) {
            return;
        }
        
        let tax = Double(taxField.text!) ?? 0.0
        
        // If the tax is over the maximum value, skip the rest.
        if (tax > maxTaxValue) {
            return;
        }
        
        // Calculate the sutbtotal
        let subTotal: Double = bill + tax
        
        // Convert tip percentage to a fraction
        let tipFraction: Double = Double(tipPercentage) / 100.0
        
        // Calculate the tip (with or without tax)
        var tip: Double = 0.0
        
        if (useTaxInCalculation) {
            tip = subTotal * tipFraction
            
        } else {
            tip = bill * tipFraction
        }
        
        // Round tip to the nearest cent
        let roundedTip = Double(round(100 * tip)/100)
        
        let total: Double = subTotal + roundedTip
        let perPerson: Double = total / Double(guestCount)
        
        // Update labels with the new values
        let subtotalStr = formatCurrency(value: subTotal)
        subtotalLabel.text = subtotalStr
        
        tipLabel.text =  formatCurrency(value: roundedTip) // String(format: "$%.2f", roundedTip)
        totalLabel.text =  formatCurrency(value: total)    //String(format: "$%.2f", total)
        perPersonAmountLabel.text =  formatCurrency(value: perPerson) //String(format: "$%.2f", perPerson)
        
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
    
    func checkTipMinusButton() {
        if (tipPercentage < 1) {
            tipMinusButton.isEnabled = false
            tipMinusButton.setNeedsDisplay()
        }
    }
    
    func checkTipPlusButton() {
        if (tipPercentage > 99) {
            tipPlusButton.isEnabled = false
            tipPlusButton.setNeedsDisplay()
        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        // Set the nav bar button item title equal to the empty string since we have an image background
        let destVC = segue.destination
        destVC.navigationItem.title = ""               
        
    }


}
