//
//  ViewController.swift
//  Tippy
//
//  Created by Diana Fisher on 8/10/17.
//  Copyright © 2017 Diana Fisher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    //MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: - IBAction

    @IBAction func onTap(_ sender: Any) {
        print("tapped!")
        
        view.endEditing(true) // dismiss the keyboard
    }

    @IBAction func calculateTip(_ sender: Any) {
        
        // set the values of tip and total
        
        let tipPercentages = [0.18, 0.2, 0.25]
        
        let selectedPercent = tipPercentages[tipControl.selectedSegmentIndex]
        
        let bill = Double(billTextField.text!) ?? 0
        let tip = bill * selectedPercent
        let total = bill + tip
        
        // convert the String to a Double or use 0, if it is nil
//        tipLabel.text = "$\(tip)"
//        totalLabel.text = "$\(total)"
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
        
    }
}

