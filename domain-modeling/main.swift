//
//  main.swift
//  Money
//
//  Created by Andrew Yu on 10/14/15.
//  Copyright © 2015 Derry Cheng. All rights reserved.
//

import Foundation

class Person {
    
    let firstName : String
    let lastName: String
    let age : Int
    var job : Job?
    var spouse : Person?
    
    init(firstName: String, lastName: String, age: Int){
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    
    func toString() {
        print("First Name: \(self.firstName)")
        print("Last Name: \(self.lastName)")
        print("Age: \(self.age) years old")
        if(self.job != nil){
            print("Occupation: \(self.job!.title)")
        }
        if(self.spouse != nil){
            print("Spouse: \(self.spouse!.firstName) \(self.spouse!.lastName)")
        }
    }
    
}

class Job{
    let title : String
    var salaryHour : Double?
    var salaryYear : Double?
    
    
    init(title: String){
        self.title = title
    }
    
    func calculateIncome (hours: Double) -> Double{
        if(salaryYear != nil){
            return self.salaryYear!
        } else{
            return self.salaryHour! * hours
        }
    }
    func raise (percentage : Double) -> Double {
        if(salaryYear != nil){
            return (1 + percentage/100) * Double(self.salaryYear!)
        } else {
            return (1 + percentage/100) * Double(self.salaryHour!)
        }
    }
}


class Family{
    var person : Person?
    var members : [Person]
    
    init(members: [Person]){
        self.members = [Person]()
    }
    
    func householdIncome() -> Double    {
        var totalIncome : Double = 0
        for(var i = 0; i < self.members.count; i++){
            if(members[i].job != nil && members[i].job?.salaryYear != nil){
                totalIncome += members[i].job!.salaryYear!
            }
        }
        return totalIncome
    }
    
    func haveChild (newPerson: Person){
        if(newPerson.age == 0){
            self.members.append(newPerson)
        } else {
            print("Child's age must be zero.")
        }
    }
    
    
}

struct Money{
    let amount : Double?
    let currency : String?
    init (amount: Double, currency : String){
        if(currency == "USD" || currency == "CAN" || currency == "GBP" || currency == "EUR"){
            self.amount = amount
            self.currency = currency
        } else {
            self.amount = nil
            self.currency = nil
        }
    }
    
    func convert(to: String) -> Double{
        var fromCurrency : Double
        switch self.currency{
        case "EUR"? :
            fromCurrency = self.amount!/1.5
        case "GBP"? :
            fromCurrency = self.amount!/0.5
        case "CAN"? :
            fromCurrency = self.amount!/1.25
        default:
            fromCurrency = self.amount!
        }
        var toCurrency : Double
        switch to{
        case "EUR":
            toCurrency = fromCurrency*1.5
        case "GBP":
            toCurrency = fromCurrency*0.5
        case "CAN":
            toCurrency = fromCurrency*1.25
        default:
            toCurrency = fromCurrency
        }
        return toCurrency
    }
    func add(amount: Double, currency: String) -> Double{
        var resultAmount: Double?;
        
        if(currency == "USD" || currency == "CAN" || currency == "GBP" || currency == "EUR"){
            if(currency != self.currency){
                let convertedAmount = self.convert(currency)
                resultAmount = convertedAmount + amount
            } else{
                resultAmount = self.amount! + amount
            }
        } else {
            resultAmount = nil
        }
        
        return resultAmount!
    }
    func subtract(amount: Double, currency: String) -> Double{
        var resultAmount: Double?;
        if(currency == "USD" || currency == "CAN" || currency == "GBP" || currency == "EUR"){
            if(currency != self.currency){
                let convertedAmount = self.convert(currency)
                resultAmount = convertedAmount - amount
            } else{
                resultAmount = self.amount! - amount
            }
        } else {
            resultAmount = nil
        }
        return resultAmount!
    }
}