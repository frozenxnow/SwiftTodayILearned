//: ## Lesson 6 Exercises - Classes, Properties and Methods

import UIKit

//: __Problem 1__
//:
//: __1a.__
//: The compiler is complaining because the class Animal has no initializers. Write an init method for the Animal class and quiet this error. Include a mechanism to initialize the length of the Animal's tail using the Tail struct provided.
struct Tail {
    let lengthInCm: Double
    
    // memberwise initializer
    init(length: Double) {
        self.lengthInCm = length
    }
}

class Animal {
    var species: String = ""
    let tail: Tail
    
    init(species: String, length: Double) {
        self.species = species
        self.tail = Tail(length: length)
    }
    
}
//: __1b.__
//: Instantiate and initialize a few different Animals.
var ant = Animal(species: "Ant", length: 2.0)
var dog = Animal(species: "Dog", length: 50.0)
//: __Problem 2__
//:
//: Below are the beginnings of the Peach class.
class Peach {
    let variety: String
    
    // Softness is rated on a scale from 1 to 5, with 5 being the softest
    var softness: Int
    
    static var varieties = ["A", "B", "C"] // type property
    
    init(variety: String, softness: Int) {
        self.variety = variety
        self.softness = softness
    }
    
    func ripen() {
        self.softness += 1 // 그냥 softness += 1 도 가능!
        if softness > 4 {
            print("eat me")
        } else {
            print("just second")
        }
    }
    
}
//: __2a.__
//: Add a type property to the Peach class called "varieties". It should hold an array of different types of peaches.
//:
//: __2b.__
//: Add an instance method called ripen() that increases the value of the stored property, softness, and returns a string indicating whether the peach is ripe.
//:
//: __2c.__
//: Create an instance of the Peach class and call the method ripen().
let peach = Peach(variety: "A", softness: 4)
peach.ripen()
//: __Problem 3__
//:
//: __3a.__
//:Add the computed property, "cuddlability", to the class, FluffyDog. Cuddlability should be computed based on the values of the stored properties, fluffiness and droolFactor.
var theFluffiestDog = UIImage(named:"fluffyDog") // nil이라서 함수가 실행되지 않음
class FluffyDog {
    let name: String
    let fluffiness: Int
    let droolFactor: Int
    
    // Solution : 3a
    var cuddlability: Int {
        get {
            return self.fluffiness - self.droolFactor
        }
    }
    
    init(name: String, fluffiness: Int, droolFactor: Int) {
        self.name = name
        self.fluffiness = fluffiness
        self.droolFactor = droolFactor
    }

    func chase(_ wheeledVehicle: String)-> String {
        return "Where are you going, \(wheeledVehicle)? Wait for me! No, don't go! I will catch you!"
    }
}
//: __3b.__
//: Instantiate and initialize an instance of the class, FluffyDog. Use it to call the method, chase().
var somePuppy = FluffyDog(name: "puppy", fluffiness: 40, droolFactor: 30)
somePuppy.cuddlability
somePuppy.chase("something")

//: __Problem 4__
//:
//: __4a.__
//: Write an instance method, bark(), that returns a different string based on the value of the stored property, size.
enum Size: Int {
    case small
    case medium
    case large
}

class ChattyDog {
    let name: String
    let breed: String
    let size: Size
    
    init(name: String, breed: String, size: Size) {
        self.name = name
        self.breed = breed
        self.size = size
    }
    
    func bark(_ size: Size) -> String {
        switch size {
        case .small:
            return "small small"
        case .medium:
            return "medium medium"
        case .large:
            return "large large"
        }
    }
    
    static func speak(_ size: Size) -> String {
        switch size {
        case .small:
            return "small small"
        case .medium:
            return "medium medium"
        case .large:
            return "large large"
        }
    }
}
//: __4b.__
//: Create an instance of ChattyDog and use it to call the method, bark().
var someDog = ChattyDog(name: "Bow", breed: "someDog", size: .large)
someDog.bark(someDog.size) // 함수 선언시 wildcard가 반드시 있어야한다
ChattyDog.speak(someDog.size)
//: __4c.__
//: Rewrite the method, bark(), as a type method and rename it speak(). Call your type method to test it out.

//: __Problem 5__
//:
//:__5a.__
//: Write an initialization method for the House class below.
enum Quality {
    case poor, fair, good, excellent
}

enum NaturalDisaster {
    case earthquake
    case wildfire
    case hurricane
}

class House {
    var numberOfBedrooms: Int = 0
    let location: Quality
 
    func willStayStanding(_ naturalDisaster:NaturalDisaster)-> Bool {
        switch naturalDisaster {
        case .earthquake:
            return true
        case .wildfire:
            return true
        case .hurricane:
            return false
        }
    }
    
    init(location: Quality, number: Int) {
        self.location = location
        self.numberOfBedrooms = number
    }
    
    var worthyOfAnOffer: Bool {
        get {
            switch (location, numberOfBedrooms) {
            case (.excellent, 3):
                return true
            default:
                return false
            }
        }
    }
    
}

//: __5b.__
//: Create an instance of the House class and use it to call the method, willStayStanding().  This method takes in a parameter of type NaturalDisaster and return a Bool indicating whether the house will stay standing in a given natural disaster.
var someHouse = House(location: .excellent, number: 3)
someHouse.willStayStanding(.hurricane)
someHouse.worthyOfAnOffer
//: __5c.__
//: Add a computed property called, "worthyOfAnOffer". This property should be a Bool, whose return value is dependent upon some combination of the stored properties, numberOfBedrooms and location.






