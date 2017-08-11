//
//  TipViewController.swift
//  Tippy
//
//  Created by Diana Fisher on 8/10/17.
//  Copyright © 2017 Diana Fisher. All rights reserved.
//

import UIKit

class TipViewController: UITableViewController {

    @IBOutlet weak var billAmountField: UITextField!
    @IBOutlet weak var taxAmountField: UITextField!
    @IBOutlet weak var taxPercentField: UITextField!
    @IBOutlet weak var tipAmountField: UITextField!
    @IBOutlet weak var tipPercentStepper: UIStepper!
    @IBOutlet weak var includeTaxSwitch: UISwitch!
    @IBOutlet weak var peopleCountStepper: UIStepper!
    @IBOutlet weak var resultField: UILabel!
    @IBOutlet weak var tipPercentLabel: UILabel!
    
    private var tipPercentage: Int = 20

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        print("view did load")
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // load defaults in viewWillAppear since viewDidLoad only gets called once and we want to have the most updated values.
        loadDefaults()
        print("view will appear")        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadDefaults() {
        
        let defaults = UserDefaults.standard
        let defaultTipPercentage = defaults.integer(forKey: "tipPercentage")
        print("loaded \(defaultTipPercentage)")
        
        if (defaultTipPercentage != 0) {
            tipPercentage = defaultTipPercentage
        }
        
        // update the label text
        tipPercentLabel.text = "\(tipPercentage)%"
    }
    
    // MARK: - IBAction
    @IBAction func calculateTip(_ sender: Any) {
        let bill = Double(billAmountField.text!) ?? 0
        let tax = Double(taxAmountField.text!) ?? 0
        
        print("bill = \(bill)")
        print("tax = \(tax)")
        
        let total = bill + tax
        
        print(total)
        
    }
}
