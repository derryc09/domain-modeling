//
//  main.swift
//  domain-modeling
//
//  Created by Derry Cheng on 10/14/15.
//  Copyright © 2015 Derry Cheng. All rights reserved.
//

import Foundation

class Person: CustomStringConvertible{
    
    let firstName : String
    let lastName: String
    let age : Int
    var job : Job?
    var spouse : Person?
    
    init(firstName: String, lastName: String, age: Int){
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        if(age < 16){
            self.job = nil
        }
        if(age < 18){
            self.spouse = nil
        }
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
    var description: String {
        return ("Name:\(lastName),\(firstName), Age:\(age), ") + (job != nil ? "Job:" + job!.title + "," : "") + (spouse != nil ? "Spouse: " + spouse!.firstName  : "")
    }
    
    
    
}

class Job: CustomStringConvertible{
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
    var description: String {
        return ("Title: \(title)") + (salaryHour != nil ? ", Hourly Salary: " + String(salaryHour!)  : "") + (salaryYear != nil ? ", Yearly Salary: " + String(salaryYear!)  : "")
    }
}


class Family: CustomStringConvertible{
    var person : Person?
    var members : [Person]
    
    init(members: [Person]){
        self.members = [Person]()
        var checkstatus = 0;
        for(var i = 0; i < members.count; i++){
            if(members[i].age >= 21){
                checkstatus = 1;
            }
        }
        if (checkstatus == 0){
            print("Your family is ILLEGAL!!!")
            print("")
        }
    }
    
    func householdIncome() -> Double    {
        var totalIncome : Double = 0
        for(var i = 0; i < self.members.count; i++){
            if(members[i].job != nil && members[i].job?.salaryYear != nil){
                totalIncome += members[i].job!.salaryYear!
            } else if(members[i].job != nil && members[i].job?.salaryHour != nil){
                totalIncome += (members[i].job!.calculateIncome(40) * 52)
            }
        }
        return totalIncome
    }
    
    func haveChild (newPerson: Person){
        if(newPerson.age == 0){
            self.members.append(newPerson)
        } else {
            print("Child's age must be zero. Thou shall not have this child.")
            print("")
        }
    }
    var tempString: String = ""
    func membersString() -> String{
        for(var i = 0; i < members.count; i++){
            if(i == 0){
                tempString += (members[0].firstName)
            } else {
                tempString = (tempString + ", " + members[i].firstName)
                
            }
        }
        return tempString
    }
    
    var description: String {
        return ("Members include: " + membersString())
    }
    
}

struct Money: CustomStringConvertible, Mathematics{
    var amount : Double
    var currency : String
    init (amount: Double, currency : String){
        if(currency == "USD" || currency == "CAN" || currency == "GBP" || currency == "EUR"){
            self.amount = amount
            self.currency = currency
        } else {
            print("Please note that we do not accept your indicated currency.")
            print("You are now forced to take U.S. Dollars.")
            print("")
            self.amount = amount
            self.currency = "USD"
        }
    }
    
    
    
    func convert(to: String) -> Double{
        if(to == "USD" || to == "CAN" || to == "GBP" || to == "EUR"){
            var fromCurrency : Double
            switch self.currency{
            case "EUR" :
                fromCurrency = self.amount/1.5
            case "GBP" :
                fromCurrency = self.amount/0.5
            case "CAN" :
                fromCurrency = self.amount/1.25
            case "YEN" :
                fromCurrency = self.amount/120
            default:
                fromCurrency = self.amount
            }
            var toCurrency : Double
            switch to{
            case "EUR":
                toCurrency = fromCurrency*1.5
            case "GBP":
                toCurrency = fromCurrency*0.5
            case "CAN":
                toCurrency = fromCurrency*1.25
            case "YEN":
                toCurrency = fromCurrency*120
            default:
                toCurrency = fromCurrency
            }
            return toCurrency
        } else {
            print("Please note that we do not recognize this currency")
            print("Your request has been rejected. ")
            print("")
            return self.amount
        }
    }
    
    func add(amount: Double, currency: String) -> Double{
        var resultAmount: Double?;
        if(currency == "USD" || currency == "CAN" || currency == "GBP" || currency == "EUR"){
            if(currency != self.currency){
                let convertedAmount = self.convert(currency)
                resultAmount = convertedAmount + amount
            } else{
                resultAmount = self.amount + amount
            }
        } else {
            resultAmount = amount;
            print("Please note that we do not accept your indicated currency.")
            print("Therefore, we refuse to process your request. Muhahahaha")
            print("")
        }
        print("The result output is in this currency: \(currency)")
        return resultAmount!
    }
    
    func subtract(amount: Double, currency: String) -> Double{
        var resultAmount: Double?;
        if(currency == "USD" || currency == "CAN" || currency == "GBP" || currency == "EUR"){
            if(currency != self.currency){
                let convertedAmount = self.convert(currency)
                resultAmount = convertedAmount - amount
            } else{
                resultAmount = self.amount - amount
            }
        } else {
            resultAmount = amount;
            print("Please note that we do not accept your indicated currency.")
            print("Therefore, we refuse to process your request. Muhahahaha")
            print("")
        }
        print("The result output is in this currency: \(currency)")
        return resultAmount!
    }
    var description: String {
        return ("\(currency)" + String(amount))
    }
    
    func addMoney(money: Money) -> Money{
        var resultMoney = Money(amount: 0, currency: "CAN")
        if(money.currency != self.currency){
            let convertedAmount = self.convert(money.currency)
            resultMoney.amount = convertedAmount + money.amount
            resultMoney.currency = money.currency
        } else{
            resultMoney.amount = self.amount + money.amount
            resultMoney.currency = self.currency
        }
        return resultMoney
    }
    
    func subtractMoney(money: Money) -> Money{
        var resultMoney = Money(amount: 0, currency: "CAN")
        if(money.currency != self.currency){
            let convertedAmount = self.convert(money.currency)
            resultMoney.amount = convertedAmount - money.amount
            resultMoney.currency = money.currency
        } else{
            resultMoney.amount = self.amount - money.amount
            resultMoney.currency = self.currency
        }
        return resultMoney
    }
}

protocol CustomStringConvertible{
    var description: String { get }
    
}
protocol Mathematics{
    func addMoney (money: Money) -> Money
    func subtractMoney (money: Money) -> Money
}

extension Double {
    var USD: Money {
        return Money(amount: self, currency: "USD")
    }
    var EUR: Money {
        return Money(amount: self, currency: "EUR")
    }
    var GBP: Money {
        return Money(amount: self, currency: "GBP")
    }
    var YEN: Money {
        return Money(amount: self, currency: "YEN")
    }
    var CAN: Money{
        return Money(amount: self, currency: "CAN")
    }
}

print("     declare Person")
var me = Person(firstName: "Derry", lastName: "Cheng", age: 24)
print("     print Derry using Description, should include Spouse information")

print(me.description)

print("     declare Person Benny")
var Benny = Person(firstName: "Benny", lastName: "Lam", age: 24)
print("     print Person using Description")

print(Benny.description)
print("     set Derry's spouse as Benny")
me.spouse = Benny
print("     print Derry using description")
print(me.description)
print("     declare Person Andrew")
var Andrew = Person(firstName: "Andrew", lastName: "Yu", age: 24)
print("     print Person using Description")
print(Andrew.description)
print("     declare empty Family. Should pop up illegal Family notice")
var Fam = Family(members: [Person]())
print("     print empty Family using Description. Should be empty")
print(Fam.description)

print("     adding 3 Family members: Derry, Andrew, Benny")

Fam.members.append(me)          // add family members
Fam.members.append(Andrew)      // add family members
Fam.members.append(Benny)       // add family members
print("     print all Family members, should include all three names")
print(Fam.description)          // print family description
print("")


print("     Testing Mathematics.")
print("")
print("     declare Money USD40 using double: value is USD 40.0")
var USD40 = 40.USD

print("     print Money using description")
print(USD40.description)

print("     declare Money CAN10 using double, value is CAN 10.0")
var CAN10 = 10.CAN

print("     print Money using description")
print(CAN10.description)
print("     subtract 10CAN from 40 USD - result should  be 40 CAN")
print(USD40.subtractMoney(CAN10).description)
print("     add 10CAN to 40 USD - result should  be 60 CAN")
print(USD40.addMoney(CAN10).description)
print("     declare Money CAN20 using double, value is CAN 20.0")
var CAN20 = 20.CAN
print("     print Money using description")
print(CAN20.description)
print("     Test Mathematics on same currency. Subtract 10CAN from 20 CAN - result should  be 10 CAN")
print(CAN20.subtractMoney(CAN10))

print("     declare Jobs, should be Contracts Analyst")
var Jobs = Job(title: "Contracts Analyst")
print("     set Contracts Analyst hourly to be 42")
Jobs.salaryHour = 42.0
print("     print Job using Description. should be descriptive")
print(Jobs.description)
print("     set Derry's job as Contracts Analyst")
me.job = Jobs
print("     print Derry using Description. Should include Spouse and Job information")
print(me.description)

print("")
print("")
print("")
print("         Conclusion:")
print("         Description works on all types and returns human-readable stuff")
print("         Mathematics can remove and add Money regardless of currency and amount and is defined on Money")
print("         Money can be declared using Double")
print("")
