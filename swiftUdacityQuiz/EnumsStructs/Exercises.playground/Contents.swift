//: ## Lesson 7 Exercises - Enums & Structs

//: __Problem 1__
//:
//: At the end of the code snippet below, what is the value of macchiato.steamedMilk when EspressoDrink is implemented as a struct? What about when EspressoDrink is implemented as a class?

// none  : 구조체 형태에서 값을 다른 변수에 저장하게 되면, 데이터의 복사본이 생성된다. 이것은 원본과 별개의 데이터이므로 다른 변수를 수정하더라도 원본의 값은 변경되지 않아 None 이고,
//  -> splash : 클래스에서는 변수에 참조하고 있는 값의 주소값을 저장하므로, 다른 변수에 저장할 경우 같은 주소값이 저장된다. 그러므로 이 변수를 통해 접근하게 되는 대상은
//              원본이기 때문에 이 (참조)변수를 통해 접근했을 경우 원본의 데이터가 변경된다.

enum Amount {
    case none
    case splash
    case some
    case alot
}

struct EspressoDrink {
    let numberOfShots: Int
    var steamedMilk: Amount
    let foam: Bool
    
    init(numberOfShots: Int, steamedMilk: Amount, foam: Bool) {
        self.numberOfShots = numberOfShots
        self.steamedMilk = steamedMilk
        self.foam = foam
    }
}

var macchiato = EspressoDrink(numberOfShots: 2, steamedMilk: .none, foam: true)
var espressoForGabrielle = macchiato
espressoForGabrielle.steamedMilk = .splash
macchiato.steamedMilk


//: __Problem 2__
//:
//: __2a.__
//: Write an enum to represent the five fingers on a human hand.

enum HumanHand {
    case finger1
    case finger2
    case finger3
    case finger4
    case finger5
}

//:
//: __2b.__
//: Associate an Int value with each finger.

enum Finger: Int {
    case finger1 = 1
    case finger2
    case finger3
    case finger4
    case finger5
}

//: __Problem 3__
//:
//: Enum, class, or struct?
//:
//: Uncomment the code below and choose whether each type should be an enum, class, or struct.
struct Window {
    let height: Double
    let width: Double
    var open: Bool
}

enum WritingImplement {
    case pen
    case pencil
    case marker
    case crayon
    case chalk
}

struct Material {
    let name: String
    let density: Double
    let stiffness: Double
}

struct Bicycle {
    let frame: Material
    let weight: Double
    let category: String

    static var bikeCategories: [String] = ["Road", "Touring", "Mountain", "Commuter", "BMX"]

    func lookCool() {
        print("Check out my gear-shifters!")
    }
}

class Cyclist {
    var speed: Double
    let agility: Double
    let bike: Bicycle

    var maneuverability: Double {
        get {
            return agility - speed/5
        }
    }

    init(speed: Double, agility: Double, bike: Bicycle) {
        self.speed = speed
        self.agility = agility
        self.bike = bike
    }

    func brake() {
        speed -= 1
    }

    func pedalFaster(factor: Double) {
        speed * factor
    }
}

enum Size: String {
    case small = "8 ounces"
    case medium = "12 ounces"
    case large = "16 ounces"
}

//: __Problem 4__
//:
//: Write a cookie struct.

struct Cookie {
    var flavor: String
    var minutesSinceRemovalFromOven: Int
    
    var delicious: Bool {
        get {
            if flavor == "choco" {
                return true
            } else {
                return false
            }
        }
    }
    
    func tempt() -> String {
        if delicious == true {
            return "eat!"
        } else {
            return "nope"
        }
    }
}

//: __4a.__
//: Include 2 stored properties. Examples might include a string representing flavor, or an int representing minutesSinceRemovalFromOven.

//:__4b.__
//: Add a computed property, "delicious", a bool whose value depends upon the values of the stored properties.

//:__4c.__
//:Include a method. For example, the method tempt() might return or print out an indication of a person being tempted to eat the cookie.

//: __4d.__
//: Create an instance of your Cookie struct and call its method.

let cookies = Cookie(flavor: "choco", minutesSinceRemovalFromOven: 10)
cookies.tempt()

//: __Problem 5__
//:
//: Write a class to represent a listing for a Bed and Breakfast. // 이거 비앤비야.....

enum Housing {
    case house
    case APT
    case hut
    case mansion
}

class BnBListing {
    var category: Housing
    var capacity: Int // ?
    var availability: Bool
    
    init(category: Housing, capacity: Int, availability: Bool) {
        self.category = category
        self.capacity = capacity
        self.availability = availability
    }
    
    func book() -> String {
        self.availability = false
        return "check the reservation"
    }
    
}

//: __5a.__
//: Include 3 stored properties. Examples might include a category representing the type of housing i.e. apartment or house, or a bool representing availability.

//: __5b.__
//: Consider writing a helper enum and incorporating it as one of your properties.

//: __5c.__
//: Include at least one method. For example, the method book() might toggle the availability bool or return a reservation confirmation.

//: __5d.__
//: Create an instance of your BnBListing class and call one of its methods.

let bnb = BnBListing(category: .hut, capacity: 30000, availability: true)
bnb.book()
bnb.availability
