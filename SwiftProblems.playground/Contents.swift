import UIKit

///****************codable Protocol************************
struct EmployeeDetails: Codable {
    var name: String?
    var code: Int?
    var PreviousCompanies: [String]?
    
    enum CodingKeys: String, CodingKey {
    case name
    case code
    case PreviousCompanies = "companies"
    }
}

var externalData = """
{
"name": "Ravneet Arora",
"code": 1,
"companies": ["MPL", "BMS"]
}
"""

if let jsonData = externalData.data(using: .utf8) {
    if let employeeDetails = try? JSONDecoder().decode(EmployeeDetails.self, from: jsonData) {
        print("employeeDetails ---> \(employeeDetails)")
    }
   
    
}
///****************Manual Encoding and decoding************************
struct AnotherEmployeeDetails: Codable {
    var name: String?
    var code: Int?
    var PreviousCompanies: [String]?
    var lastCompany: String?
    
    enum CodingKeys: String, CodingKey {
    case name
    case code
    case PreviousCompanies = "companies"
    }
    
    enum AdditionalKeys: String, CodingKey {
        case lastCompany
    }
}

extension AnotherEmployeeDetails {
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(code, forKey: .name)
//        try container.encode(name, forKey: .code)
//        try container.encode(PreviousCompanies, forKey: .PreviousCompanies)
//
//        var anotherContainer = encoder.container(keyedBy: AdditionalKeys.self)
//        try anotherContainer.encode(PreviousCompanies?.first ?? "default value", forKey: .lastCompany)
//
//
//    }
    
    init(from decoder: Decoder) throws {
        var container = try decoder.container(keyedBy: CodingKeys.self)
        try container.decodeIfPresent(String.self, forKey: .name)
        try container.decodeIfPresent(String.self, forKey: .code)
        try container.decodeIfPresent([String].self, forKey: .PreviousCompanies)
       
        var anotherContainer = try decoder.container(keyedBy: AdditionalKeys.self)
        try anotherContainer.decodeIfPresent(String.self, forKey: .lastCompany)
       
    }
}

var anotherExternalData = """
{
"name": "Ravneet Arora",
"code": 1,
"companies": ["MPL", "BMS"]
}
"""

if let anotherJsonData = anotherExternalData.data(using: .utf8) {
    if let anotherEmployeeDetails = try? JSONDecoder().decode(AnotherEmployeeDetails.self, from: anotherJsonData) {
        print("anotherEmployeeDetails ---> \(anotherEmployeeDetails)")
    } else {
        print("decoding failed")
    }
   
    
}
/////////////////////////////////////// string to array and array to string
let s = "ravneet"
var input = Array(s)

var anotherS = String(input)
/////////////////////////////////////// enumeration
//Simple Enumeration
enum Planet {
    case mercury, venus, earth, mars
}
//Associated Values
enum AnotherPlanet {
    case mercury(lifePossible: Bool), venus(lifePossible: Bool), earth(lifePossible: Bool), mars(lifePossible: Bool)
}
var anotherPlanetInstance = AnotherPlanet.earth(lifePossible: true)

//Raw Values
enum PlanetInteger: Int {
    case mercury = 1, venus, earth, mars
}
var ourPlanetNumber = PlanetInteger.earth.rawValue

//Recursive Enumeration

indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

var five = ArithmeticExpression.number(5)
var two = ArithmeticExpression.number(2)
var sum = ArithmeticExpression.addition(five, two)
var multiplication = ArithmeticExpression.multiplication(sum, two)

func calculate(expression: ArithmeticExpression) -> Int {
    
    switch expression {
    case .number(let input):
        return input
    case .addition(let left,let right):
        return calculate(expression: left) + calculate(expression: right)
    case .multiplication(let left,let right):
        return calculate(expression: left) * calculate(expression: right)
    }
    
}

calculate(expression: multiplication)


////*************Inheritance

class Vehicle {
    var speed = 0.0
    var description: String {
        return "vehicle speed is \(speed) km/h"
    }
    
    func someFunction() {
        print("calling someFunction in Vehicle class")
    }
    func checkSameFunctionality() {
       print("just testing")
    }
}

class Car: Vehicle {
 //   override var speed = 120.0
    override var description: String {
        return "car speed is \(super.speed)"
    }
    override func someFunction() {
        print("calling someFunction in Car class")
    }
    
}

class Harrier: Car {
    override var description: String {
        return "Harrier ---> \(super.description)"
    }
    override func checkSameFunctionality() {
        print("just testing")
    }
}


var harrierInstance = Harrier()
harrierInstance.speed = 200.0
print("\(harrierInstance.description)")
harrierInstance.checkSameFunctionality()



//********Extensions *****

class someClass {
    func someMethod() {
        
    }
}

extension someClass {
    //uncomment to check error. this is possible with subclass
//    func someMethod() {
//
//    }
    
    

}
extension Int {
    func seeDifference() -> Self {
        self + self + self
    }
}

// -------- difference between self and Self ------
let value: Int = 0
value.seeDifference()

// -------- SOLID - LSP ------

class Rectangle {
    var width: Float = 0
    var length: Float = 0
    
    var area: Float {
        width * length
    }
}

class Square: Rectangle {
    override var width: Float {
        didSet {
            length = width
        }
    }
}

func printArea(of rectangle: Rectangle) {
    rectangle.length = 5
    rectangle.width = 2
    print("Area ---> \(rectangle.area)")
    
}

var rectangleObj = Rectangle()
printArea(of: rectangleObj)

var square = Square()
printArea(of: square)


class Person {
    var name: String
    
    init (name: String) {
        self.name = name
    }
}

var person1 = Person(name: "Ravneet")

var person2 = person1

person2.name = "Pankaj"

print("person1 name changes to \(person1.name)")

struct AnotherPerson {
    var name: String
    
    init (name: String) {
        self.name = name
    }
}

var anotherPerson1 = AnotherPerson(name: "Another Ravneet")

var anotherPerson2 = person1

anotherPerson2.name = "Another Pankaj"

print("person1 name changes to \(anotherPerson1.name)")


// ------- Lazy Property ----------
// ------- Lazy Property will be initialized only once and store the value in it. it will return the same value everytime we will access lazy proeprty ----------
// ---- computed property will intialized and compute every time we access it.

struct Employee {
    var name: String
    var id: Int
    var salary: Int
}

struct Company {
    var employees: [Employee]
    var highestId: Int {
        print("conputed property highestId initialized")
        return employees.max { $1.salary > $0.salary }?.id ?? 0
    }
    lazy var highestSalariedPerson: Employee? = {
        print("highestSalariedPerson lazy property initialized")
        return employees.max { $1.salary > $0.salary }
    }()
}

var employee1 = Employee(name: "employee 1", id: 1, salary: 100000)
var employee2 = Employee(name: "employee 2", id: 2, salary: 200000)
var employee3 = Employee(name: "employee 3", id: 3, salary: 300000)

//change it to let to show error (Lazy properties are mutable so we cannot call it on immutable value -- valid for value types only)
//let mpl = Company(employees: [employee1, employee2, employee3])
var mpl = Company(employees: [employee1, employee2, employee3])

var highestPaidEmployee = mpl.highestSalariedPerson
print("highestPaidEmployee ---- \(highestPaidEmployee)")

var highestIdEmployee = mpl.highestId
print("highestIdEmployee ---- \(highestIdEmployee)")

mpl.employees.append(Employee(name: "employee 4", id: 4, salary: 500000))


print("New highestPaidEmployee ---- \(mpl.highestSalariedPerson)")

print("New highestIdEmployee ---- \(mpl.highestId)")

//checking initial commit

// ------- Autoclosure --------------

func checkClosure(closure:() -> (String)) {
  let output = closure()
    print("output in explicit closure ---> \(output)")
}

checkClosure(closure: {"Ravneet"})


func checkAutoClosure(closure: @autoclosure () -> (String)) {
  let output = closure()
    print("output in autoclosure ---> \(output)")
}
checkAutoClosure(closure: "Ravneet")


// ----- swift book example -------

//without autoclosure
var customerList = ["Ravneet", "Harsha", "Pankaj", "Dad", "Mom"]

func serveCustomer(fetchFirstCustomerFromList: () -> (String)) {
   print("Serving ---> \(fetchFirstCustomerFromList())")
}

serveCustomer {
    customerList.removeFirst()
}

//with autoclosure
func serveCustomerWithAutoclosure(fetchFirstCustomerFromList: @autoclosure () -> (String)) {
   print("Serving ---> \(fetchFirstCustomerFromList())")
}

serveCustomerWithAutoclosure(fetchFirstCustomerFromList: customerList.removeFirst())
