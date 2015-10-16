//
//  main.swift
//  domain-modeling
//
//  Created by Derry Cheng on 10/14/15.
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
}

struct Money{
    let amount : Double
    let currency : String
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
    
}
var Derry = Person(firstName: "Derry", lastName: "Cheng", age: 22)
var Brian = Person(firstName: "Brian", lastName: "Hawkins", age: 23)
var Andrew = Person(firstName: "Andrew", lastName: "Before", age: 53)
var Vivian = Person(firstName: "Vivian", lastName: "Woods", age: 20)
var April = Person(firstName: "April", lastName: "Seaburg", age: 43)
var Benny = Person(firstName: "Benny", lastName: "Lam", age: 24)


var MacBookAir = Money(amount: 1500, currency: "USD")
print("         // declared  Money                                          PASSED")

print(MacBookAir.convert("CAN"))
print("         // converted  Money                                         PASSED")

var iPhone = Money(amount: 1000, currency: "USD")
print(iPhone.add(3000, currency: "USD"))
print("         // added Money with same currency                           PASSED")

print(iPhone.add(2000, currency: "GBP"))
print("         // added Money with different currency                      PASSED")

print(iPhone.subtract(1000, currency: "GBP"))
print("         // subtracted Money with different currency                   PASSED")
var noMoney = Money(amount: 1000, currency: "Bla")
print("         // added Money with nonexistant currency  - auto switch to USD.     PASSED")
print(noMoney.currency)
print("")

April.spouse = Andrew
print("         // set April's spouse = Andrew                              PERSON  Test PASSED")

April.spouse!.toString()
print("         // printed April's spouse's string rep.                     PERSON  Test PASSED")

Andrew.spouse = April
print("         // set Andrew's spouse              .                     PERSON  Test PASSED")

Andrew.spouse!.toString()
print("         // Test spouse.toString                                  PERSON  Test PASSED")

var Football = Job(title: "Football Player")

Football.salaryHour = 128
print("         // set Hourly salary              .                     PERSON  Test PASSED")

print(Football.salaryHour!)
print("         // prints Hourly wage             .                     PERSON  Test PASSED")

print(Football.calculateIncome(40))
print("         // calculate Income works             .                     PERSON  Test PASSED")

var BeforeFam = Family(members: [Person]())
print("         // Declaring a family works          .                     PERSON  Test PASSED")

Andrew.job = Football

var Child = Person(firstName: "Chucky", lastName: "Doll", age: 0)
var Kid = Person(firstName: "Jerky", lastName: "Beef", age: 20)

BeforeFam.haveChild(Child)
print("           // Test Have Child   age == 0                                  Passed")

BeforeFam.haveChild(Kid)
print("           // Test Have Child   age > 0 , blocked                            Passed")

BeforeFam.members.append(Andrew)
BeforeFam.members.append(April)
print("             // Adding family memebrs                                Passed")

var Dev = Job(title: "Developer")
Dev.salaryYear = 86000

Vivian.job = Dev
print(BeforeFam.householdIncome())
print("           // Test household income                                     Passed")


var WoodsFam = Family(members: [Person]())
print("             // Add household with age < 21                          Passed")
WoodsFam.members.append(Vivian)
print("             // Members age < 21 receives illegal message                Passed")
WoodsFam.members.append(Benny)
print("             // illegal message  removes properly               Passed")

print(WoodsFam.householdIncome())
print("             // One Person Household income                          Passed")


var Librarian = Job(title: "Librarian")
print("         // declared job Librariab                           Job  Test PASSED")
print("")

Librarian.salaryYear = 97380
print("         // set Librarian yearly = 97380                     Job  Test PASSED")
print("")

April.job = Librarian
print("         // set April's job = Librarian          Job  Test PASSED")
print("")

print(April.job!.title)
print("         // print April's job's title'           Job Test PASSED")
print("")

Derry.toString()
print("         // called  toString() method            PERSON  Test PASSED")
print("")

var ContractsAnalyst = Job(title: "Contracts Analyst")
print("         // declared  Job var ContractsAnalyst   Job     Test PASSED")
print("")

ContractsAnalyst.salaryYear = 70000
print("         // added  yearly salary to Job          Job     Test PASSED")
print("")

print(ContractsAnalyst.raise(20))
print("         // printed the 20percent raise          Job     Test PASSED")
print("")

var Barista = Job(title: "Barista")
print("         // Declared new Job                     Job     Test PAASED")
print("")

Barista.salaryHour = 10.50
print("         // added  hourly salary to job          Job     Test PASSED")
print("")

print(Barista.salaryHour!)
print("         // printed  Barista hourly salary       Job     Test PASSED")
print("")

print(Barista.calculateIncome(40))
print("         // calc'd&printed Barista 40hr incomJob     Test PASSED")
print("")

print(Barista.raise(20))
print("         // printed  the 20percent raise         Job     Test PASSED")
print("")









