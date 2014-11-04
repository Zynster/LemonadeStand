//
//  Market.swift
//  LemonadeStand
//
//  Created by Dorian Dowse on 3/11/2014.
//  Copyright (c) 2014 Xenoka. All rights reserved.
//

import Foundation

class Market {
    
    class func makeCustomers(weatherMod:Int) -> [Customer] {
        var myCustomers: [Customer] = []
        
        var numberOfCustomers = Int(arc4random_uniform(UInt32(10)))
        numberOfCustomers += 1
        numberOfCustomers += weatherMod
        if numberOfCustomers < 0 {
            numberOfCustomers = 0
        }
        
        let myOrder = ["first", "second", "third", "forth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth", "eleventh", "twelth", "thirteenth", "forteenth"]
        
        for var i = 0; i < numberOfCustomers; i++ {
            var customer:Customer
            var customerPref = ""
            let prefRange = Double(Int(arc4random_uniform(UInt32(10))))/10
            if prefRange < 0.4 {
                customerPref = "strong"
            } else if prefRange < 0.7 {
                customerPref = "normal"
            } else {
                customerPref = "weak"
            }
            customer = Customer(preference: customerPref, order: myOrder[i])
            myCustomers.append(customer)
        }
        return myCustomers
    }
    
}