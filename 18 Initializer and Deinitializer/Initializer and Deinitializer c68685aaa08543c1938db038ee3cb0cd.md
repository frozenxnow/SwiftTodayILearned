# Initializer and Deinitializer

# 1. Initializer

새로운 인스턴스를 생성하는 `생성자`입니다. instance의 모든 속성에 기본값을 제공합니다.

선언과 동시에 항상 동일한 값으로 초기화할 수 있으며,  `init()`의 파라미터로 인스턴스 생성 시점에 초기화할 수 있습니다. 

Optional Type의 속성은 초기화하지 않으면 기본값 `nil`로 초기화 됩니다. 

모든 속성이 기본값을 가지고 있고(선언 시 기본값 제공), init()을 선언하지 않는다면 `default initializer(기본 생성자)를 자동으로 제공`합니다. 

```swift
init(parameters) {
	initialization
}

TypeName(parameter) // 생성자를 호출하는 방법: methodName 대신 typeName
```

하나의 형식 안에서 initializer는 `오버라이딩`이 가능하기 때문에 생성자를 여러개를 선언할 수 있습니다. 그러나 코드의 중복을 피해야하기 때문에, 반복되는 코드가 있다면 생성자는 아래와 같이 작성합니다.

```swift
class SizeObj {
    var width = 0.0
    var height = 0.0
    
    init(width: Double, height: Double) {
        self.width = width
        self.height = height
    }
    
//    init(value: Double) {
//        width = value
//        height = value
//    }      위 init(width: Double, height: Double)과 
//           코드가 유사하기 때문에 위의 생성자를 사용해 선언합니다. 

    // 이 때, cconvenience 키워드를 추가합니다. 
    **convenience** init(value: Double) {
        self.init(width: value, height: value)
    }
}
```

생성자의 이름은 init()으로 모두 같기 때문에 이들을 구분하기 위해서는 파라미터의 수나 자료형, argument label을 살펴보아야 합니다.

## Memberwise Initializer

구조체에서는 memberwise initializer를 기본으로 제공합니다.

조건은 1) 따로 선언된 생성자가 없어야 하며 2) 파라미터의 이름은 모든 속성의 이름과 같아야 합니다. 

```swift
struct SizeValue {
	var width = 0.0
	var height = 0.0
}

let s1 = SizeValue() // parameter가 없는 기본값으로 인스턴스를 생성하는 생성자
let s2 = SizeValue(width: 1.2, height: 3.4) // 구조체의 모든 속성이 parameter인 생성자
```

# 2. Memberwise Initializer

앞서 memberwise iitializer가 제공되는 조건을 살펴보았고, 실제로 제공되는 memberwise initializer를 확인하겠습니다.

```swift
struct First {
    let a: Int
    let b: Int
    let c: Int
}
// 기본값이 없는 구조체의 생성자는 모든 속성을 파라미터로 받는 memberwise 제공합니다.
let f = First(a: 1, b: 2, c: 3)

struct Second {
    let a: Int = 0
    let b: Int = 0
    let c: Int
}
// 일부 기본값이 주어진 구조체는 기본값이 없는 속성을 파라미터로 받는 memberwise 제공합니다.
// a:b:는 let으로 선언되어있기 때문에 값을 변경할 수 없습니다.
let s = Second(c: 2)

struct Third {
    var a: Int = 0
    var b: Int = 1
    var c: Int
}
// Second와는 달리 var로 선언되어 있기 때문에, 기본값이 없는 속성만을 받는 memberwise와
// 모든 속성값을 parameter로 받는 memberwise가 함께 제공됩니다.
let t1 = Third(c: 2)
let t2 = Third(a: 0, b: 1, c: 2)
```

만약 구조체 내 생성자를 선언한다면 memberwise 생성자는 더이상 제공되지 않습니다.

memberwise 생성자도 사용하고, 직접 구현한 생성자를 사용하려면 구조체를 확장하고, `확장된` 구조체 내에서 생성자를 정의하면 memberwise 생성자도 사용할 수 있고, 직접 정의한 생성자도 사용할 수 있습니다.

```swift
struct Third {
    var a: Int = 0
    var b: Int = 1
    var c: Int
}

extension Third {
    init(value: Int) {
        a = value
        b = value
        c = value
    }
}

let t1 = Third(c: 2) // parameter가 없는 기본 생성자 
let t2 = Third(a: 0, b: 1, c: 2) // memberwise 생성자
let t3 = Third(value: 5) // extension에서 정의한 생성자
```

규칙을 정리하겠습니다.

- struct는 모든 저장속성을 초기화하는 생성자를 제공합니다.
- parameter 수는 속성의 수와 동일합니다.
- argument label과 parameter name은 속성의 이름과 동일합니다.
- 속성이 let으로 선언되고, 기본값을 가지고 있다면 생성자 parameter 목록에서 제외합니다.
- 속성이 var로 선언되면, 기본값이 있는 생성자와 기본값이 없는 생성자를 제공합니다.
- struct 내부에서 init()을 정의한다면 더이상 memberwise 생성자는 제공되지 않습니다.
- memberwise를 또 한번 정의해주어도 되지만, 새로운 init()을 확장된 구조체 내에서 선언하는 편이 더욱 실용적입니다.

# 3. Class Initializer

클래스에서 사용하는 클래스 생성자에 대해 알아보겠습니다.

## 1) Designated initializer : 지정생성자

- 모든 속성을 초기화하는 메인 생성자입니다.
- 개수에는 제한이 없지만 반드시 하나 이상이 선언되어있어야 합니다.
- default 생성자가 있거나 super class로부터 상속받은 designated 생성자가 있다면 구현할 필요 없습니다.

## 2) Convenience Initializer : 간편생성자

- 다양한 초기화 방법을 구현하기 위한 uitility 성격의 생성자입니다.
- 반드시 모든 속성을 초기화할 필요가 없고, 필요한 초기화만 한 후, designated initializer를 호출하여 초기화를 마무리합니다.
- 같은 클래스 내의 designate initializer를 호출할 수 있으나, super class의 initializer는 호출할 수 없습니다.
- 반드시 같은 클래스의 designate initializer를 호출하여 최종적으로 super class의 initializer를 호출하도록 구현해야합니다. (initializer deligation에서 공부하겠습니다)

```swift
class Position {
  var x: Double
  var y: Double
  
  // designated initializer : 모든 속성을 초기화합니다.
  init(x: Double, y: Double) {
      self.x = x
      self.y = y
  }
  
	// convenience initializer : designated init 호출하여 초기화를 마무리합니다.
  convenience init(x: Double) {
      self.init(x: x, y: 0.0)
      // 직접 x 속성을 초기화하면 designated initializer와 코드가 중복됩니다.
      // 따라서 같은 클래스에 있는 designated 호출해 x를 파라미터로, y에는 기본값을 저장하는 코드입니다.
  }
}
```

클래스 간 상속이 있을 경우에 대해 알아보겠습니다. 기본적으로 superclass의 initializer는 상속되지 않습니다.

상속받은 클래스에서 superclass의 생성자를 사용해도, 상속받은 클래스에 기본값이 없는 속성이 있다면 초기화되지 않는 속성이 존재하게 되고, 이것을 초기화 실패라고 표현합니다. 

```swift
class Figure {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func draw() {
        print("draw \(name)")
    }
}

class Rectangle: Figure {
    var width: Double = 0.0
    var height: Double = 0.0
}
```

그러나 이와 같은 경우 subclass의 모든 속성이 초기화되어있고, designated initializer가 정의되지 않았습니다.

→ `superclass의 모든 designated initializer가 상속`됩니다.

```swift
class Figure {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func draw() {
        print("draw \(name)")
    }
}

class Rectangle: Figure {
    var width: Double = 0.0
    var height: Double = 0.0

		init(name:String, width: Double, height: Double) {
        self.width = width
        self.height = height
        super.init(name: name) // superclass의 designated initializer를 통해 name에 접근
		}
}
```

Rectangle 클래스에 선언된 designated initializer를 살펴보겠습니다.

init 내부에 [self.name](http://self.name) = name과 같은 코드를 작성할 경우 오류가 발생하는 이유는 1) 슈퍼클래스의 designated initializer가 호출되지 않았고 2) 상위 구현을 호출하기 전 상속받은 name 속성에 접근했기 때문입니다. 

이는 superclass의 designated initializer인 `super.init(name: name)`을 사용한다면 해결이 가능합니다. 

상속받은 클래스의 경우에는 보통 현재 클래스에 선언된 속성만 초기화하고 나머지는 superclass에 맡깁니다.

```swift
class Figure {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func draw() {
        print("draw \(name)")
    }

		convenience init() {
        self.init(name: "unknown")
    }
}

class Rectangle: Figure {
    var width: Double = 0.0
    var height: Double = 0.0

		init(name:String, width: Double, height: Double) {
        self.width = width
        self.height = height
        super.init(name: name) // superclass의 designated initializer를 통해 name에 접근
		}

	  // superclass의 designated initializer override
		override init(name: String) {
        width = 0
        height = 0
        super.init(name: name)
    }

		convenience init() {
        self.init(name: "unknown")
    }
}
```

superclass와 subclass에 모두 구현되어 있는 convenience initializer의 경우 override의 개념이 적용되지 않습니다.

`**convenience initializer**`는 **같은 클래스의 다른 initializer를 호출**하고, superclass의 initializer를 호출할 수 없기 때문입니다.

# 4. Required Initializer

필수생성자입니다. 

```swift
required init(parameters) {
	statements
}
```

생성자 앞에 `required` 키워드를 추가합니다. 

subclass의 모든 속성이 초기화되어있고 생성자가 없으면, superclass의 모든 designated initializer가 상속됩니다. 따라서 required designated initializer도 상속되기 때문에 subclass에서 따로 구현할 필요가 없습니다.

그러나 subclass에 다른 init()이 구현되어 있으면 더이상 designated initializer가 상속되지 않습니다. `required init()`은 반드시 구현해야하기 때문에, subclass에서도 `required` 키워드를 사용해 superclass의 required designated initializer를 정의합니다. 이 때는 superclass의 init()과 완전히 동일한 형태로 구현해야합니다. 

```swift
class Figure { // superclass
    var name: String
    
    required init(name: String) {
        self.name = name
    }
    
    func draw() {
        print("draw \(name)")
    }
}

class Rectangle: Figure { // subclass
    var width: Double = 0.0
    var height: Double = 0.0
    
    init() {
        // width = 0.0
        // height = 0.0
        super.init(name: "unknown")
    }

		required init(name: String) {
				// width = 0.0
				// height = 0.0
				super.init(name: name)
		}
}
```

required initializer를 사용하는 이유는 subclass를 상속하는 다른 클래스들이 다시 동일한 init()을 구현하도록 강제하기 위함입니다.

(??) → 위 문장은 이해하지 못했습니다.

# 5. InitializerDelegation

delegation은 위임, 대리라는 뜻을 가지고 있습니다. 

코드의 중복을 최대한 제거하고 모든 속성을 효율적으로 초기화하는 것이 목적입니다.

## 1) Value Type의 Initializer Delegation

상속이 불가능하고, 생성자의 종류가 하나이므로 상대적으로 단순합니다. 

다만 초기화 규칙이 바뀌면 모든 생성자를 수정해야하므로 유지와 보수가 어렵다는 것이 특징입니다.

이를 보완하기 위해 모든 속성을 초기화하는 하나의 생성자를 구현하고, 다른 생성자에서는 이 생성자를 호출하도록(`self.init(parameter)`) 구현해야합니다.

```swift
struct Size {
    var width = 0.0
    var height = 0.0
    
    init(w: Double, h: Double) { // 모든 속성을 초기화하는 생성자
        width = w
        height = h
    }
    
    init(value: Double) { 
//        width = value
//        height = value // 위 생성자를 호출하는 형식으로 변경 
        self.init(w: value, h: value)
    }
}
```

위 코드를 보면 `init(value:)`는 자신이 해야하는 초기화를 첫번째 `init(w:h:)`에게 위임합니다. 

단순히  다른 init()을 호출해 초기화를 위임하는 것이 delegation이 아니라, delegation의 목적인 모든 속성 초기화를 잊지 않아야 합니다. 모든 init() 실행 후 전체 속성이 초기화되어야 합니다.

Initializer Delegation의 장점은 초기화 규칙 변경시 수정해야 하는 코드가 적어 유지와 보수가 수월해진다는 점입니다.

![Initializer%20and%20Deinitializer%20c68685aaa08543c1938db038ee3cb0cd/_2021-03-09__7.54.40.png](Initializer%20and%20Deinitializer%20c68685aaa08543c1938db038ee3cb0cd/_2021-03-09__7.54.40.png)

첫번째 그림처럼 생성자가 연달아 호출되도록 구현하는 것도 가능하고

두번째 그림처럼 나머지 생성자들이 한 생성자를 호출하도록 구현하는 것도 가능합니다. 

초기화 완료 시점에 모든 속성이 초기화된다면 어떤 패턴을 사용하던지 상관 없습니다.

## 2) Class Type의 Initializer Delegation

여기에는 세 가지 규칙이 있습니다.

1. Delegate Up (sub→super)  : sub의 designated는 반드시 super의 designated를 호출해야합니다.
동일한 클래스 내에서  designated → designated 호출시 error가 발생합니다.
2. Delegate Across (sub→sub, super→super) : convenience는 같은 클래스 내의 생성자만 호출이 가능합니다. sub → super 의 생성자 호출은 불가능합니다.
3. convenience 호출시 최종적으로 동일한 클래스 내의 designated가 호출되어야 합니다. 

![Initializer%20and%20Deinitializer%20c68685aaa08543c1938db038ee3cb0cd/_2021-03-09__8.06.45.png](Initializer%20and%20Deinitializer%20c68685aaa08543c1938db038ee3cb0cd/_2021-03-09__8.06.45.png)

그림으로 나타낼 경우 위와 같습니다. 

```swift
class Figure {
    let name: String
    
    init(name: String) { // designated initializer
        self.name = name
    }
    convenience init() { // convenience initializer (2)
        self.init(name: "unknown")
    }
}

class Rectangle: Figure {
    var width = 0.0
    var height = 0.0
    
    init(n: String, w: Double, h: Double) { // designated initializer
        width = w
        height = h
        super.init(name: n) // (1)Delegate Up
    }
    convenience init(value: Double) { // convenience initializer 
        self.init(n: "rect", w: value, h: value) // (2)동일한 클래스 내의 designated init 호출
    }
}

class Square: Rectangle {
    // 속성X, Designated X -> rect의 designated 상속
    convenience init(value: Double) { // convenience initializer
        self.init(n: "square", w: value, h: value)
				// Rectangle에서 상속받은 designated initializer 호출하는 것이므로 self. 사용 
    }
    
    convenience init() { // (2)위의 init 호출
        self.init(value: 0.0)
    }
}

// 이 모든 코드는 조건 (3)을 만족합니다.
```

초기화의 진행 순서와 방향에 대해 알아보겠습니다. 

![Initializer%20and%20Deinitializer%20c68685aaa08543c1938db038ee3cb0cd/_2021-03-09__8.29.15.png](Initializer%20and%20Deinitializer%20c68685aaa08543c1938db038ee3cb0cd/_2021-03-09__8.29.15.png)

크게 두 가지로 나뉩니다.

1. `sub→super`의 방향으로 위로 올라갑니다. 올라가면서 만나는 super.init() 혹은 self.init()은 아직 실행되지 않으며, 중간에 초기화할수 없는 속성이 있으면 초기화에 실패하고 초기화를 중단합니다. superclass의 designated initializer까지 올라가며 초기화에 성공했을 때 인스턴스의 유효성이 확보됩니다.
2. `super→sub`의 방향으로 내려갑니다. 1번에서 할수 없었던 부가적인 초기화를 진행하며, 인스턴스 속성에 접근하거나 메소드를 호출할 수 있습니다. 부가적인 과정이기 때문에 아무 작업이 없을 수 있습니다.

위 두 가지가 모두 완료되었을 때, 초기화가 완료되었다고 할 수 있습니다.

# 6. Failable Initializer

실패를 허용하는 생성자입니다.

옵셔널과 같이 표현하며 마찬가지로 두 가지 형태가 있습니다.

```swift
init?(parameter) {
	statement
}

init!(parameter) {
	statement
}
```

init?(parameter) { } : 초기화된 인스턴스가 옵셔널 타입으로 리턴되거나 실패할 경우 nil이 리턴됩니다.

init!(parameter) { } : 초기화된 인스턴스가 옵셔널 타입으로 리턴되거나 실패할 경우 nil이 리턴됩니다.

기대했던 결과와는 다르게 두 문법 모두 오류가 발생하지 않습니다. 강제추출했음에도 불구하고 nil이 리턴되어 에러가 발생하지 않는 이유는 IUO 구현이 변경되어 옵셔널과 동일하게 처리되기 때문입니다. 만약 객체를 생성할 때 non-optional 타입으로 형식을 제한한다면 초기화 시점에 해당 타입으로 unwrapping됩니다. 이때 init!() 사용해 초기화에 실패할 경우 에러가 발생합니다. 

### !

느낌표를 사용하는 초기화에는 두 가지 단점이 있습니다.

IUO로 처리되기 때문에 처리 방법을 알고 있어야하고, 초기화에 실패했을 때 에러가 발생한다는 점입니다. failable initializer의 목적은 에러가 발생하지 않는 것이 목적인데 이는 목적에 부합하지 않습니다. 따라서 느낌표보다는 주로 `?`를 사용합니다.

### 구현 규칙

`오버로딩`이 가능합니다. failable과 non-failable을 구분하지 않아 init!(value:Double), init(value:Double) 은 같은 생성자로 구분하기 때문에 함께 선언하면 에러가 발생합니다. 

non-failable initializer에서는 결과가 non-failable이기 때문에init?()을 호출할 수 없습니다. init!()은 사용 가능합니다. 하지만 이것도 초기화에 실패할 경우 에러가 발생하기 때문에 사용하지 않는것이 좋습니다.

반대로 failable initializer에서는 자유롭습니다. failable을 호출해도 되고 non-failable을 호출해도 됩니다. 

# 7. Deinitializer

소멸자입니다. 인스턴스가 메모리에서 제거되기 전 부가적인 정리 작업이 필요할 때 직접 구현합니다.

보통은 자동으로 제공되고, 인스턴스가 생성될 때 자동으로 실행되기 때문에 가시적으로 작성하는 경우는 많이 없습니다. 주로 파일 연결이나 네트워크 연결처럼 자동으로 정리되지 않는 것들을 정리해야 하거나, 디버깅 용도로 사용합니다.

```swift
deinit {
	statement
}
```