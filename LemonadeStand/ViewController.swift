//
//  ViewController.swift
//  LemonadeStand
//
//  Created by Dorian Dowse on 3/11/2014.
//  Copyright (c) 2014 Xenoka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var fCash: UITextField!
    @IBOutlet weak var fLemons: UITextField!
    @IBOutlet weak var fIcecubes: UITextField!
    
    @IBOutlet weak var fMixLemons: UITextField!
    @IBOutlet weak var fMixIcecubes: UITextField!
    
    @IBOutlet weak var weatherView: UIImageView!
    
    
    var cash = 0
    var lemons = 0
    var icecubes = 0
    var mix = (lemons:0,icecubes:0)
    var weatherMod = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        cash = 10
        lemons = 1
        icecubes = 1
        updateInventoryFields()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    ////////////////////////////////////////////////////////////////////////////////////////
    // BUTTONS
    ////////////////////////////////////////////////////////////////////////////////////////
    
    // Purchase Buttons ////////////////////////
    
    @IBAction func bLemonsAdd(sender: UIButton) {
        if cash >= 2 {
            lemons += 1
            cash -= 2
            updateInventoryFields()
        }
        else {
            showAlertWithText(message: "You don't have enough cash")
        }
    }
    
    @IBAction func bLemonsSub(sender: UIButton) {
        if lemons > 0 {
            lemons -= 1
            cash += 2
            updateInventoryFields()
        }
        else {
            showAlertWithText(message: "You don't have any lemons")
        }
    }
    
    @IBAction func bIcecubesAdd(sender: UIButton) {
        if cash >= 1 {
            icecubes += 1
            cash -= 1
            updateInventoryFields()
        }
        else {
            showAlertWithText(message: "You don't have enough cash")
        }
    }
    
    @IBAction func bIcecubesSub(sender: UIButton) {
        if icecubes > 0 {
            icecubes -= 1
            cash += 1
            updateInventoryFields()
        }
        else {
            showAlertWithText(message: "You don't have any icecubes")
        }
    }
    
    // Mix Buttons ////////////////////////
    
    @IBAction func bLemonMixAdd(sender: UIButton) {
        if lemons > 0 {
            lemons -= 1
            mix.lemons += 1
            updateInventoryFields()
        }
        else {
            showAlertWithText(message: "You don't have any lemons")
        }
    }
    
    @IBAction func bLemonMixSub(sender: UIButton) {
        if mix.lemons > 0 {
            lemons += 1
            mix.lemons -= 1
            updateInventoryFields()
        }
        else {
            showAlertWithText(message: "You don't have any lemons in your mix")
        }
    }
    
    @IBAction func bIcecubeMixAdd(sender: UIButton) {
        if icecubes > 0 {
            icecubes -= 1
            mix.icecubes += 1
            updateInventoryFields()
        }
        else {
            showAlertWithText(message: "You don't have enough icecubes")
        }
    }
    
    @IBAction func bIcecubeMixSub(sender: UIButton) {
        if mix.icecubes > 0 {
            icecubes += 1
            mix.icecubes -= 1
            updateInventoryFields()
        }
        else {
            showAlertWithText(message: "You don't have any icecubes in your mix")
        }
    }
    

    // Start day button ////////////////////////
    
    @IBAction func bStartDay(sender: UIButton) {
        if mix.lemons > 0 && mix.icecubes > 0 {
            
            forecast()
            
            var myMix:String
            if mix.lemons > mix.icecubes {
                myMix = "strong"
            } else if mix.lemons < mix.icecubes {
                myMix = "weak"
            } else {
                myMix = "normal"
            }
            println("You made \(myMix) lemonade")
            
            var newCash = 0
            let customers = Market.makeCustomers(weatherMod)
            println("\(customers.count) customers came today")
            for customer in customers {
                if customer.preference == myMix {
                    println("The \(customer.order) customer liked \(customer.preference) lemonade and bought your \(myMix) mix")
                    newCash += 1
                } else {
                    println("The \(customer.order) customer preferred \(customer.preference) lemonade and didn't buy your \(myMix) mix")
                }
            }
        
            self.mix = (lemons:0,icecubes:0)
            self.cash += newCash
            updateInventoryFields()
            println("You made $\(newCash) today")
            showAlertWithText(header: "Sales Results", message: "You made $\(newCash) today")
        
        } else {
            showAlertWithText(message:"You need both lemons and icecubes to make lemonade")
        }
    }
    
    ////////////////////////////////////////////////////////////////////////////////////////
    // Helper Functions
    ////////////////////////////////////////////////////////////////////////////////////////
    
    
    func updateInventoryFields() {
        fCash.text = "$\(cash)"
        fLemons.text = "\(lemons)"
        fIcecubes.text = "\(icecubes)"
        fMixLemons.text = "\(mix.lemons)"
        fMixIcecubes.text = "\(mix.icecubes)"
    }
    
    func showAlertWithText (header : String = "Alert", message : String) {
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func forecast() {
        var theWeather = ""
        let possibilities = Int(arc4random_uniform(UInt32(3)))
        switch possibilities {
        case 0:
            theWeather = "Cold"
            self.weatherMod = -2
        case 1:
            theWeather = "Mild"
            self.weatherMod = 0
        case 2:
            theWeather = "Warm"
            self.weatherMod = 4
        default:
            theWeather = "Mild"
        }
        self.weatherView.image = UIImage(named:theWeather)
        println("A new day. The weather is \(theWeather) today")
    }
}


