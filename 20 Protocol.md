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

프로토콜에서 initializer가 있을 경우 이 또한 구현해야 합니다.

구조체에서 argument label이 같은 init일 경우 따로 구현하지 않아도 memberwise init이 자동으로 제공되기 때문에 구현하지 않아도 됩니다. 

```swift
protocol Figure {
    var name: String { get }
    init(name: String)
}

struct Rectangle: Figure {
    var name: String
} // init() 구현하지 않아도 자동으로 memberwise로 제공되는 생성자가 프로토콜의 생성자와 동일합니다. 
```

class에서 상속받을 경우 모든 상속을 고려해야하고, 모든 클래스에서 요구사항을 충족시켜야 할 필요가 있기 때문에 required init()으로 선언해야합니다. required init()으로 선언하면 해당 클래스와 해당 클래스를 상속받는 모든 subclass들은 프로토콜의 요구사항을 충족하게됩니다.

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

만약 프로토콜을 채용하는 클래스가 final class로 선언되어있다면, 해당 클래스는 더이상 그 어떤 클래스에도 채용되지 않기 때문에 required init()으로 선언할 필요가 없습니다.

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