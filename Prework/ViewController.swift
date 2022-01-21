//
//  ViewController.swift
//  Prework
//
//  Created by Ryan Kwong on 12/26/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipAmount: UILabel!
    @IBOutlet weak var tipSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Tip Calculator"
        setMode()
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        let bill = Double(billAmountTextField.text!) ?? 0
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .currency
        let tipPercent = tipSlider.value * 100
        let tip = formatter.string(from: bill * Double(tipSlider.value) as NSNumber)
        let total = formatter.string(from: bill + (bill * Double(tipSlider.value)) as NSNumber)
        
        tipAmount.text = String(format: "%.0f%%",tipPercent)
        tipAmountLabel.text = tip
        totalLabel.text = total
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setMode()
        print("view will appear")
        // This is a good place to retrieve the default tip percentage from UserDefaults
        // and use it to update the tip amount
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
        billAmountTextField.becomeFirstResponder()
    }
    
    func setMode(){
        let mode = UserDefaults.standard.string(forKey: "Mode") ?? "Dark"
        if mode == "Light" {
            overrideUserInterfaceStyle = .light
        }
        else{
            overrideUserInterfaceStyle = .dark
        }
        
        let tip = UserDefaults.standard.double(forKey: "Tip")
        tipAmount.text = String(format: "%.0f%%",tip)
        tipSlider.value = Float(tip/100)
        
    }
}

