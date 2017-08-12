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
    
    
    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("view will appear")
        // load settings in viewWillAppear since it will get called every time the view is about to appear.  If we only wanted to update the values once, we would use viewDidLoad since that is only called once when the view has been loaded into memory.
        loadSettings()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    
    @IBAction func tipSuggestionsPressed(_ sender: Any) {
        // show tip suggestions
    }
    
    // MARK: - Convenience
    
    func loadSettings() {
        
        let defaults = UserDefaults.standard
        let defaultTipPercentage = defaults.integer(forKey: "tipPercentage")
        
        var tipPercentage: Int = 0
        
        print("loaded \(defaultTipPercentage)")
        
        if (defaultTipPercentage != 0) {
            tipPercentage = defaultTipPercentage
        }
        
        // update the label text
        tipPercentageLabel.text = "(\(tipPercentage)%)"
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
