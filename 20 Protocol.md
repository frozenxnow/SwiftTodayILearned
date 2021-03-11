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

# 8. Optional Requirements

선택적 요구사항입니다. 이전에 배웠던 nil 값을 저장할 수 있는 옵셔널 타입이 아닌 단어 자체의 의미로 사용합니다. 

클래스에서만 사용이 가능하며, 열거형과 구조체에서는 이 프로토콜을 채용할 수 없습니다. AnyObject 프로토콜을 상속하면 클래스에서만 사용이 가능합니다. @objc attribute를 추가하면 AnyObject 프로토콜이 자동으로 상속됩니다. 

이를 사용하기 위해서는 `@objc attribute`와 `optional modifier`를 사용합니다.

```swift
@objc protocol protocolName {
		@objc optional requirements
}
```

옵셔널 프로토콜과 그 프로토콜을 채용하는 클래스를 살펴보겠습니다.

```swift
@objc protocol Drawable {
    @objc optional var strokeWidth: Double { get set }
    func draw()
    @objc optional func reset()
}

class Rectangle: Drawable {
    func draw() {
        
    }
}

let r: Drawable = Rectangle()
r.draw()
r.strokeWidth // nil 
r.reset?()
```

Drawable 형식의 Rectangle 인스턴스를 생성했습니다. 일반 속성인 draw() 메서드에는 바로 접근할 수 있지만 옵셔널 멤버에 접근하기 위해서는 옵셔널 체이닝이 필요합니다. 

옵셔널 속성인r.strockWidth에서 `nil`은 아무 값도 저장되어 있지 않다는 의미와 형식에 해당 속성이 선언되어 있지 않다는 의미입니다. 

옵셔널 타입과 마찬가지로 옵셔널로 선언된 메서드를 호출하기 위해서는 옵셔널 체이닝 연산자인 `?`가 필요합니다. 선택적 메서드는 선택적 속성과 같이 옵셔널로 대체됩니다. 

# 9. Protocol Extension

프로토콜의 확장입니다. 프로토콜을 확장하여 프로토콜에 요구되는 속성과 메서드를 정의할 수 있습니다. `구현된 상태의 프로토콜 속성`이라고 이해하면 될 것 같습니다. 

```swift
protocol Figure {
    var name: String { get }
    func draw()
}

extension Figure {
    func draw() {
        print("draw something")
    }
}

struct Rectangle: Figure {
    var name = "Rect"
}

let r = Rectangle()
r.name
r.draw() // draw something
```

extension에서 프로토콜을 확장하고, 그 프로토콜을 채용한 구조체가 있습니다. 

여기에 Rectangle에서 draw() 메서드를 다시 선언한 후 r.draw()를 호출하면, Rectangle 구조체에서 직접 구현한 함수가 출력됩니다.

```swift
struct Rectangle: Figure {
    var name = "Rect"
		func draw() {
				print("Draw Rectangle")
		}
}
r.draw() // Draw Rectangle
```

확장된 프로토콜보다 직접 구현한 쪽의 우선순위가 더 높습니다. 

# 10. Equatable (==, !=)

스위프트가 제공하는 기본 프로토콜 중 가장 중요한 프로토콜입니다.

## 1) Enum

- 연관값이 없는 열거형 : 자동으로 equatable 프로토콜을 추가합니다.

    ```swift
    enum Case {
        case case1
        case case2
    }

    Case.case1 == Case.case2 // false. 따로 Equatable을 구현하지 않아도 값을 비교할 수 있습니다.
    ```

- 기본(혹은 Equatable을 채용한) 타입을 연관값으로 가지고 있는 열거형  : 자동으로 equatable 프로토콜을 제공합니다. 단, 연관값을 가지고 있는 경우에는 열거형이 Equatable 프로토콜을 채용하도록 구현해야합니다.

    ```swift
    enum VideoInterface: **Equatable** {
        case dvi(width: Int, height: Int)
        case hdmi(width: Int, height: Int, version: Double, audoiEnabled: Bool)
        case displayPort(size: CGSize)
    }

    let a = VideoInterface.hdmi(width: 2560, height: 1440, version: 2.0, audoiEnabled: true)
    let b = VideoInterface.displayPort(size: CGSize(width: 3840, height: 2160))

    a == b // true. 비교 가능합니다.
    ```

- Equatable을 채용하지 않은 타입을 연관값으로 가지고 있는 열거형 : Equatable을 직접 구현해야합니다.

    클래스에서 구현하는 방법과 같기 때문에 생략하겠습니다.

## 2) Structure

구조체가 Equatable을 채용하도록 작성하면 컴파일러가 알아서 필요한 Equatable을 구현합니다. 

여기에서도 마찬가지로 속성은 기본(혹은 Equatable을 채용한) 타입이어야 합니다. 

```swift
struct Person : Equatable {
    let name: String
    let age: Int
}

let a = Person(name: "Steve", age: 12)
let b = Person(name: "Paul", age: 27)
a == b // true. 비교 가능합니다.
```

## 3) Class

클래스에서 Equatable 프로토콜을 채용할 경우 equatable 프로토콜에 선언되어 있는 타입메서드를 직접 구현해야합니다. 보통 클래스에서 직접 구현하지 않고, extension에서 구현합니다. (가독성이 높아지고 유지와 보수가 용이해집니다.) 이 방법은 열거형과 구조체에서도 사용 가능합니다. 

```swift
class Person {
    let name: String
    let age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

extension Person: Equatable { // Extension에서 함수를 정의합니다.
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name && lhs.age == lhs.age
    }
}

let a = Person(name: "Steve", age: 12)
let b = Person(name: "Paul", age: 27)

a == b
```

주의해야할 점은 속성의 모든 형식이 기본타입이어야 한다는 점입니다. 

또한 equatable을 구현할 때 모든 속성을 비교할 수 있도록 해야합니다. 이렇게 프로토콜을 작성한 후 세 가지 조건을 검증해야합니다.

1. a == a // 늘 true여야 합니다.
2. a == b, b == a // 두 결과값은 일치해야합니다. 
3. a == b, b == c, c == a // 앞의 두 결과가 true라면 마지막 c == a 의 결과도 true여야 합니다. 

# 11. Hashable

특정 조건을 만족하면 자동으로 제공됩니다. 단방향 암호화에 사용되는 기법이고 주로 무결성을 체크하거나 사용자 인증에 사용합니다. swift에서는 주로 dictionary의 key나 Set으로 정의합니다.

1) 값의 유일성을 보장하고, 2) 검색 속도가 빠르다는 장점이 있습니다.

## 1) enum

- 연관값이 없는 열거형의 경우 : hashable을 자동으로 제공하고 hashable에 대한 선언도 생략할 수 있습니다.

    ```swift
    enum ServiceType {
        case onlineCourse
        case offlineCamp
    }

    let types: [ServiceType: String] // dict 선언
    let typeSet: Set = [ServiceType.onlineCourse] // Set 선언
    ```

- 기본(혹은 hashable을 채용한) 타입을 연관값으로 가지고 있는 열거형  : 자동으로 hashable 프로토콜을 제공합니다. 단, 연관값을 가지고 있는 경우에는 열거형이 hashable 프로토콜을 채용하도록 구현해야합니다.

    ```swift
    enum VideoInterface: Hashable {
        case dvi(width: Int, height: Int)
        case hdmi(width: Int, height: Int, version: Double, audoiEnabled: Bool)
    }

    let interfaces: [VideoInterface: String]
    let interfaceSet: Set = [VideoInterface.dvi(width: 1024, height: 768)]
    ```

- hashable을 채용하지 않은 타입을 연관값으로 가지고 있는 열거형 : 모든 속성이 hashable을 채용하도록 직접 구현해야합니다.

## 2) Struct

구조체가 hashable을 채용하도록 작성하면 컴파일러가 알아서 필요한 hashable을 구현합니다. 

여기에서도 마찬가지로 속성은 기본(혹은 hashable을 채용한) 타입이어야 합니다. 

```swift
struct Person: Hashable {
    let name: String
    let age: Int
}

let dict: [Person: String]
let set: Set = [Person(name: "Tom", age: 12)]
```

## 3) Class

클래스에서 hashable 프로토콜을 채용할 경우 hashable 프로토콜에 선언되어 있는 속성과 메서드를 직접 구현해야합니다. 그 중 속성인 hashValue는 더이상 사용되지 않는 속성이기 때문에 메서드(hash(into:)만 정의합니다. 보통 클래스에서 직접 구현하지 않고, extension에서 구현합니다. (가독성이 높아지고 유지와 보수가 용이해집니다.) 이 방법은 열거형과 구조체에서도 사용 가능합니다. 

hashable을 살펴보면 equatable을 상속받고 있기 때문에 추가적인 구현이 필요합니다. 

결론적으로 hashable의 hash(into:) 메서드와 equatable의 메서드를 구현해야합니다. 이것 또한 extension에서 구현해 가독성을 높이고 유지와 보수가 용이하도록 해야합니다. 

```swift
class Person {
    let name: String
    let age: Int
    
    init() {
        name = "Jane Doe"
        age = 0
    }
}

extension Person: Hashable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name && lhs.age == rhs.age
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(age)
    } // combine을 이용해 모든 속성을 순서대로 전달해야합니다.
        // 컴바인으로 전달되는 속성의 타입은 반드시 hashable을 구현해야합니다.
}
```

hash(into:) 함수는 복잡하게 직접 구현할 필요 없이 파라미터로 전달받은 hasher를 사용하도록 구현되어 있습니다. 

이 때 combine을 이용해 `모든` 속성을 `순서대로` 전달해야 하며, combine으로 전달되는 속성의 타입은 반드시 hashable을 구현해야 한다는 점을 유의해야합니다. 

# 12. Comparable (<=, <, >=, >)

Equatable은 동일한 값을 비교하는 프로토콜이었고, 

Comparable은 값의 크기나 순서를 비교하는 프로토콜입니다.

String이나 Int, Double을 포함한 숫자 타입은 Comparable을 기본으로 제공합니다. 

## 1) Enum

- 연관값이 없는 열거형의 경우 : Comparable 프로토콜을 채용하면 자동으로 구현됩니다. 
이전 버전에서는 불가능했으나 Swift 5.3+ 부터는 가능하도록 변경되었습니다.
- 기본(혹은 hashable을 채용한) 타입을 연관값으로 가지고 있는 열거형  : Comparable 프로토콜을 채용하면 자동으로 구현됩니다.
- hashable을 채용하지 않은 타입을 연관값으로 가지고 있는 열거형 : 직접 구현해야 합니다.
comparable 프로토콜은 Equatable 프로토콜을 채용하고 있고, 네 개의 비교 연산자가 선언되어 있습니다. 이 중 첫번째 연산자만 구현하면 나머지 세개의 연산자는 자동으로 구현됩니다.

    ```swift
    enum Weekday: Int { // rawValue를 갖도록 하고
        case sunday
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
    }

    extension Weekday: Comparable { // extension에서 comparable을 채용합니다
        static func < (lhs: Weekday, rhs: Weekday) -> Bool {
            return lhs.rawValue < rhs.rawValue
        }
    }

    Weekday.sunday < Weekday.monday // true. 
    ```

    만약 rawValue가 없다면 if문이나 switch문을 활용해 각 케이스를 비교하도록 구현합니다. equatable의 타입메서드도 구현해야 하지만 지금은 구현하지 않아도 됩니다. 

## 2) Struct

## 3) Class

앞서 살펴보았던 Equatable protocol, Hashable protocol과 같이 정의합니다.