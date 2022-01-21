//
//  SettingsViewController.swift
//  Prework
//
//  Created by Ryan Kwong on 1/12/22.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
//    @IBOutlet weak var UIPicker: UIPickerView!
    @IBOutlet weak var modeSwitch: UISwitch!
    var currencies:[String] = [String]()
    @IBOutlet weak var tipField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let settings = UserDefaults.standard
        let mode = settings.string(forKey: "Mode") ?? "Dark"
        if mode == "Light" {
            overrideUserInterfaceStyle = .light
            modeSwitch.isOn = false
        }
        else{
            overrideUserInterfaceStyle = .dark
            modeSwitch.isOn = true
        }
        let tip = settings.double(forKey: "Tip")
        tipField.text = String(format: "%.0f%%",tip)
        
        
//        UIPicker.dataSource = self
//        UIPicker.delegate = self
//
//        let identifiers = Locale.availableIdentifiers
//
//        for id in identifiers {
//            let locale = NSLocale(localeIdentifier: "en_US")
//            currencies.append(locale.localizedString(forLocaleIdentifier: id))
//        }
//        print(currencies)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            var label = UILabel()
            if let v = view {
                label = v as! UILabel
            }
            label.font = UIFont (name: "Helvetica Neue", size: 17)
            label.text =  currencies[row]
            label.textAlignment = .center
            return label
        }
    
    @IBAction func themeChange(_ sender: UISwitch) {
        let defaults = UserDefaults.standard
        if sender.isOn {
            print("on")
            overrideUserInterfaceStyle = .dark
            defaults.set("Dark", forKey: "Mode")
        }
        else {
            print("off")
            overrideUserInterfaceStyle = .light
            defaults.set("Light", forKey: "Mode")
        }
        defaults.synchronize()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(Double(tipField.text!.replacingOccurrences(of: "%", with: "")),forKey: "Tip")
        defaults.synchronize()
    }
    
    
}
