# Protocol

# 1. Protocols

형식에서 필수적으로 구현되어야 하는 멤버 목록입니다. 요구사항이나 다름 없습니다. 저는 자바의 인터페이스와 비슷하다고 생각했습니다. 프로토콜은 상속이 가능하며, 다중상속이 가능합니다.

```swift
protocol ProtocolName { // 구현하지 않고 선언만 해두는 필수 멤버 목록
		propertyRequirements
		methodRequirements
		initializerRequirements
		subscriptRequirements
}

protocol ProtocolName: Protocol1, Procotol2, ... {
}
```

프로토콜은 `채용한다`고 표현합니다. 다중상속을 허용하며, 상속과 프로토콜 채용을 동시에 할 수 있고 표현식은 아래와 같습니다. 상속과 프로토콜 채용을 동시에 하는 경우 superclass의 이름을 가장 먼저 작성합니다. 

```swift
enum TypeName: Protocol {
}

struct TypeName: Protocol1, Procotol2, .. {
}

class TypeName: SuperClass, Protocol, .. {
}
```

`AnyObject` 프로토콜을 상속받는 프로토콜은 클래스 전용 프로토콜로 선언됩니다. 이렇게 선언된 프로토콜은 구조체나 열거형에서 채용할 수 없습니다.

```swift
protocol ProtocolName: AnyObject {
}
```

# 2. Property Requirements

```swift
procotol ProtocolName {
	var name: Type { get set }
	static var name: Type { get set }
}
```

`형식속성`으로 선언할 때는 `static` 키워드를 사용합니다. 

가변성은 let 키워드와 var 키워드로 결정되었지만 프로토콜에서는 `var` 키워드만 사용이 가능합니다. 

프로토콜에서 가변성은 get, set에 의해 결정됩니다.

- get : 읽기전용, 불변
- get, set : 읽기와 쓰기가 모두 가능, 가변

읽기 전용 프로토콜

```swift
protocol Figure {
    var name: String { get }
}

struct Rectangle: Figure {
    **let** name = "Rect"
}

struct Triangle: Figure {
    var name = "Triangle"
}

struct Circle: Figure {
    var name: String {
        return "Circle"
    }
}
```

Rectangle에서 상수 저장속성(let)으로 name에 "Rect"를 저장했습니다. 읽기 전용으로 값을 변경할 필요가 없기 때문에 let 키워드를 사용할 수 있습니다.

읽기, 쓰기가 모두 가능한 프로토콜 

```swift
protocol Figure {
    var name: String { get set }
}

struct Rectangle: Figure {
    var name = "Rect"
}

struct Triangle: Figure {
    var name = "Triangle"
}

struct Circle: Figure {
    var name: String {
        get {
            return "Circle"
        }
        set {
            
        }
    }
}
```

Rectangle에서 let으로 name을 선언할 경우 값이 변경될 수 없기 때문에 var 키워드로 수정합니다.

Circle에서 기존 값을 읽어오던 return문을 get 블럭 안에 선언하고 set 블럭을 추가합니다.

형식속성(static)으로 선언된 멤버가 있을 경우 프로토콜 채용시 형식속성을 그대로 작성해야합니다. 단 클래스에서는 static / class 로 선언이 가능합니다. 형식속성을 가지고 있는 프로토콜을 채용하는 클래스의 경우 

```swift
protocol Figure {
    static var name: String { get set }
}
class Circle: Figure {
    class var name: String {
        get {
            return "Circle"
        }
        set {
            
        }
    }
}
```

형식속성으로 선언된 값은 subclass로 상속되지만 오버라이딩이 불가능하기 때문에 오버라이딩을 하기 위해서는 static이 아닌 `class` 키워드를 사용해 구현해야합니다. name은 여전히 형식속성의 변수이고, 이를 subclass에서 오버라이딩할 수 있습니다.

# 3. Method Requirements

프로토콜에서 메서드를 작성할 때에는 메서드 헤더 부분만 작성합니다.

```swift
protocol ProtocolName {
	func method(parameter) -> ReturnType
	static method(parameter) -> ReturnType
	mutating method(parameter) -> ReturnType
}
```

- `static` : 타입 형식으로 선언할 때 사용하는 키워드입니다.
- `mutating` : 값형식을 채용할 수 있고, 메서드 안에서 속성 값을 변경해야할 때 사용하는 키워드입니다.
값형식 전용이라는 의미보다는, 메소드 안에서 속성 값을 변경할 수 있다는 의미를 가지고 있습니다. 따라서 값형식 뿐 아니라 참조형식에서도 사용할 수 있습니다.

```swift
protocol Resettable {
    func reset()
}

class Size: Resettable {
    var width = 0.0
    var height = 0.0
    
    func reset() {
        width = 0.0
        height = 0.0
    }
}
```

메서드를 구현할 때는 메서드의 이름, 파라미터 형식, 리턴 형식만 일치시켜주면 됩니다. 함수 바디 부분은 자유롭게 구현할 수 있습니다. 

Size 클래스를 Size 구조체로 변경하면 참조형식에서 값형식이 되므로, 내부에서 구현하는 함수는 mutating 키워드를 가지고 있어야합니다. 때문에 프로토콜에서 멤버 목록을 작성하는 함수에도 mutating 키워드를 함께 작성합니다.

```swift
protocol Resettable {
    mutating func reset()
}

struct Size: Resettable {
    var width = 0.0
    var height = 0.0
    
    mutating func reset() {
        width = 0.0
        height = 0.0
    }
}
```

`mutating` 키워드에 대해 다시 한 번 설명합니다. **값형식**을 채용할 수 있고, 메서드 안에서 **속성 값을 변경해야할 때** 사용하는 키워드입니다.

위 코드는 구조체에서 함수를 정의하기 위해 mutating 키워드를 프로토콜에서도 작성해주었지만,

프로토콜에서 mutating으로 선언되었다고 해서 클래스(참조형식)에서 사용할 수 없는 것은 아닙니다. 사용 가능합니다. 

```swift
protocol Resettable {
    static func reset()
}

class Size: Resettable {
    var width = 0.0
    var height = 0.0
    
    func reset() {
        width = 0.0
        height = 0.0
    }

    static func reset() {
				// 오버라이딩 불가능 
    }
}
```

형식속성으로 선언된 메서드입니다. 오버로딩 작성 규칙에 따라 인스턴스 메서드와 타입 메서드로 동시에 구현할 수 있습니다. 다만 위와 같이 작성할 경우 static func reset() 함수는 오버라이딩이 불가능하기 때문에 오버라이딩 하기 위해서는 type method가 아닌 class method로 작성합니다. 

```swift
protocol Resettable {
    static func reset()
}

class Size: Resettable {
    var width = 0.0
    var height = 0.0
    
    func reset() {
        width = 0.0
        height = 0.0
    }

    class func reset() {
				// 오버라이딩 가능
    }
}
```

# 4. Initializer Requirements

프로토콜에 생성자가 있을 경우 이 또한 구현해야 합니다.

`구조체`에서 argument label이 같은 init()일 경우 따로 구현하지 않아도 memberwise init()이 자동으로 제공되기 때문에 구현하지 않아도 됩니다. 

```swift
protocol Figure {
    var name: String { get }
    init(name: String)
}

struct Rectangle: Figure {
    var name: String
} // init() 구현하지 않아도 자동으로 memberwise로 제공되는 생성자가 프로토콜의 생성자와 동일합니다. 
```

`class`에서 상속받을 경우 모든 상속을 고려해야하고, 모든 클래스에서 요구사항을 충족시켜야 할 필요가 있기 때문에 `required init()`으로 선언해야합니다. required init()으로 선언하면 해당 클래스와 해당 클래스를 상속받는 모든 subclass들은 프로토콜의 요구사항을 충족하게됩니다.

```swift
protocol Figure {
    var name: String { get }
    init(n: String)
}

class Circle: Figure {
    var name: String
    required init(n: String) {
        name = n
    }
} // 다른 클래스에 상속되는 일을 고려하여 required init()으로 선언합니다.
```

만약 프로토콜을 채용하는 클래스가 `final class`로 선언되어있다면, 해당 클래스는 더이상 그 어떤 클래스에도 채용되지 않기 때문에 required init()으로 선언할 필요가 없습니다.

```swift
protocol Figure {
    var name: String { get }
    init(n: String)
}

final class Triangle: Figure {
    var name: String
    init(n: String) {
        name = n
    }
} // 더이상 다른 클래스에 상속되지 않으므로 required init()으로 선언하지 않아도 됩니다.
```

프로토콜을 채용한 클래스를 상속받는 클래스에 새로운 속성을 추가했습니다.

```swift
protocol Figure {
    var name: String { get }
    init(n: String)
}

class Circle: Figure {
    var name: String
    required init(n: String) {
        name = n
    }
}

class Oval: Circle {
    var prop: Int
    init() {
        prop = 0
        super.init(n: "Oval")
    } // 프로토콜의 생성자와 파라미터 목록이 다르기 때문에 요구사항을 충족시키지 못함
    
    // 프로토콜 생성자와 동일한 생성자를 선언해야한다
    required convenience init(n: String) {
        self.init() // 꼭 지정생성자로 선언하지 않아도 됨
    }
}
```

Oval이라는 클래스에 prop이라는 속성을 추가했고, 이를 초기화하기 위한 initializer를 선언합니다. 

Oval에서 정의한 파라미가 없는 init()은 prop을 초기화하고 super.init(), 즉 상위 클래스의 init(n:)을 사용해 나머지 속성을 초기화했습니다. 하지만 프로토콜의 생성자인 init(n:)을 정의해주지 않았습니다. 이는 required convenience init(n:)으로 정의합니다. 여기에서 방금 선언했던 파라미터가 없는 self.init()을 호출하는 것입니다. 

→ 이렇게 써두니 이해를 한것 같지만 명확히 이해하기 위해 시간이 조금 걸릴 것 같습니다.

Failable initializer를 살펴보겠습니다.

```swift
protocol Grayscale {
    init(white: Double) // non-failable : non-optional type의 인스턴스를 요구합니다.
}

struct Color: Grayscale {

//    init?(white: Double) {
//        // Optional 인스턴스 생성 : 에러
//    }

    init!(white: Double) {
        // non-Optional type 인스턴스 생성
				// 그러나 강제하기 때문에 에러가 발생할 수 있습니다.
    }
}
```

non-failable initializer를 요구하는 프로토콜을 채용할 경우 init?(white:)으로 생성된 인스턴스는 optional type이므로 에러가 발생합니다. init!(white:)를 사용해 인스턴스를 생성할 수 있지만 강제하는 문법이기 때문에 런타임 에러가 발생할 수 있습니다. 

반면 프로토콜에서 failable initializer를 요구하는 경우 init(white:), init?(white:), init!(white:)를 전부 사용할 수 있습니다.

# 5. Subscript Requirements

```swift
protocol ProtocolName {
	subscript(parameters) -> returnType { get set } // 읽기, 쓰기 가능
}
protocol ProtocolName {
	subscript(parameters) -> returnType { get } // 읽기 전용 
} 
```

마찬가지로 프로토콜에서는 바디 부분을 제외하고 작성하고, 가변성은 get과 set에 의해 결정됩니다.

```swift
protocol List {
    subscript(idx: Int) -> Int { get }
}

struct DataStore: List {
    subscript(idx: Int) -> Int {
        return 0
    }
} // 읽기전용 프로토콜 채용

protocol List2 {
    subscript(idx: Int) -> Int { get set }
}

struct DataStore2: List2 {
    subscript(idx: Int) -> Int {
        get {
            return 0
        }
        set {
            
        }
    }
} // 읽기와 쓰기 모두 가능한 프로토콜 채용
```

# 6. Protocol Type

프로토콜은 first-class citizen으로 독립적으로 사용이 가능합니다. 

그리고 타입 캐스팅을 통해 프로토콜의 적합성을 판단할 수 있습니다. 적합성 판단은 이 프로토콜을 채용하고 있는지 확인하는 작업입니다. 

```swift
instance is protocolName // bool return

instance as protocolName 
instance as! protocolName
instance as? protocolName
```

`is` 연산자는 프로토콜을 채용하고 있는지 여부를 bool type으로 리턴합니다.

`as` 연산자는 인스턴스를 해당 프로토콜 타입으로 캐스팅하여 리턴합니다. 

```swift
protocol Resettable {
    func reset()
}

class Size: Resettable {
    var width = 0.0
    var height = 0.0
    
    func reset() {
        width = 0.0
        height = 0.0
    }
}
```

프로토콜과 프로토콜을 채용하는 클래스가 있습니다. 여기에서 인스턴스를 각각 생성하겠습니다.

```swift
let s = Size() // Size 형태로 저장되는 Size 인스턴스
let r: Resettable = Size() // Resettable 형태로 저장되는 Size 인스턴스, upcasting과 유사합니다. 

// r.width : error. Resettable type으로 Protocol의 속성만 사용 가능합니다.
```

모두 Size 타입의 인스턴스이지만 r은 Resettable 타입이고, 프로토콜의 속성만 호출이 가능합니다. 이는 실제로 upcasting과 유사합니다.

```swift
// var r: Resettable = Size()
var r = Size() as Resettable // 같은 문장입니다.

r as? Size // 원래의 타입으로 되돌리기 위해 사용합니다.
```

→ 여기에서는 원래의 타입으로 돌리기 위해 `as? Size`를 작성했다고 했습니다. 여기에서 말하는 원래의 타입이란 무엇인지 알기 위해 r.width, r.height을 사용했으나 에러가 발생하는것을 보면 여전히 Resettable Type이라는 말인데, 이 부분에 대해서는 질문을 보내두었습니다!

## Collection에서 사용하는 Protocol

```swift
protocol Figure {
    func draw()
}

struct Triangle: Figure {
    func draw() {
        print("triangle")
    }
}

class Rectangle: Figure {
    func draw() {
        print("Rectangle")
    }
}

struct Circle: Figure {
    var radius = 0.0
    func draw() {
        print("Circle")
    }
}

let t = Triangle()
let r = Rectangle()
let c = Circle()

let list: [Figure] = [t, r, c]
```

t, r, c 인스턴스는 구조체, 클래스 등이 섞여 있으며 모두 다른 형식을 가지고 있습니다. 이 인스턴스로 배열을 만들고자 한다면 각 구조체와 클래스가 채용하고 있는 공통적인 프로토콜인 [Figure] 형태의 배열을 생성해야합니다. 

```swift
for i in list {
    i.draw()
    if let c = i as? Circle {
        c.radius
    }
}
```

해당 배열을 `for-in문`에서 사용했습니다. 배열은 [Figure] 타입이기 때문에 프로토콜에 정의된 draw() 메서드를 문제 없이 사용할 수 있습니다. 그러나 c의 radius를 사용하고자 한다면 `as?` 연산자를 사용해 원래 형식으로 캐스팅해야합니다.

이처럼 upcasting과 downcasting을 적절히 사용하면 상속이 지원되지 않는 값형식에서도 유사한 패턴으로 구사할 수 있습니다.

# 7. Protocol Composition

6번에서 프로토콜 타입의 변수에 인스턴스를 저장할 수 있다고 배웠습니다. (`let r: Resettable = Size()`)

두 가지 이상의 프로토콜 형식으로 저장하는 임시프로토콜을 Protocol Composition이라고 합니다. 

```swift
protocol Resettable {
    func reset()
}

protocol Printable {
    func printValue()
}

class Size: Resettable, Printable {
    var width = 0.0
    var height = 0.0
    
    func reset() {
        width = 0.0
        height = 0.0
    }
    
    func printValue() {
        print(width, height)
    }
}
```

Size 클래스는 두 프로토콜을 동시에 채용하고 있습니다. 따라서 특정 프로토콜 형식의 변수에 인스턴스를 저장할 수 있지만, 두 프로토콜 형식의 변수에 인스턴스를 저장하기 위해서는 프로토콜을 `&` 연산자로 연결합니다.

```swift
let r: Resettable = Size()
let p: Printable = Size()

let rp: Resettable & Printable = Size()
```

r에는 Resettable 형식의 변수에 Size 인스턴스가

p에는 Printable 형식의 변수에 Size 인스턴스가

rp에는 Resettable & Printable 형식의 변수에 Size 인스턴스가 저장됩니다. 

임시프로토콜을 사용할 수 있는 이유는 Size클래스가 두 프로토콜을 모두 채용하기 때문입니다.

```swift
class Circle: Resettable {
    var radius = 0.0
    
    func reset() {
        radius = 0.0
    }
}
// rp = Circle() // error.
```

Circle 클래스는 하나의 프로토콜만 채용하고 있기 때문에 rp(Resettable&Printable)에 저장할 수 없습니다.

```swift
class Oval: Circle { }

var cr: Circle & Resettable = Circle()
cr = Oval()
```

클래스와 프로토콜이 혼합된 형태를 살펴보겠습니다.

Circle클래스 계층에 있고 Resettable 프로토콜을 채용한 인스턴스를 cr 변수에 저장했습니다.

Oval 클래스는 Circle 클래스를 상속받습니다. 그리고 상속받은 Circle클래스 덕분에 Resettable 요구사항도 충족하고 있기 때문에 Oval 인스턴스는 cr에 저장이 가능합니다.