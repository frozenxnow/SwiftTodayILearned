# Generics

# 1. Generic Functions

**표현식**은 아래와 같습니다.

```swift
func name<T> (parameters) -> Type {
	// code
}
```

`<T>` : TypeParameter, 실제 자료형을 대체하는 place holder입니다. 함수 내부에서 파라미터나 리턴 형식으로 사용되며, 두 개 이상 사용할 수 있습니다. 콤마`(,)`로 구분합니다.

**형식제약을 추가할 수 있습니다.** 

```swift
<TypeParameter: ClassName>
<TypeParameter: ProtocolName>

ex
<T: Equatable>
	if lhs == rhs { return }
```

예시와 같이 작성했다면, Equatable Protocol을 채용한 값들만 전달하여 코드를 실행하게 됩니다.

**Specialization(특수화)** : 특정 형식을 위한 함수를 구현할 수 있습니다. 

같은 이름의 함수일 경우 전달하는 값에 의해 함수를 선택하게 됩니다. generic 함수를 overriding한 형태로 인식하며 generic 함수보다 우선순위가 높습니다. 

```swift
func swapValue<T: Equatable> (lhs: inout T, rhs: inout T) {
    print("generic version")
    
    if lhs == rhs { return }
    
    let tmp = lhs
    lhs = rhs
    rhs = tmp
}
```

위와 같이 두 값을 서로 변경해주는 generic function을 문자열에서도 사용이 가능하도록 특수화된 함수를 정의하겠습니다. 어떤 함수가 사용되었는지 로그를 출력하기 위해 print 메서드를 사용했습니다.

```swift
func swapValue (lhs: inout String, rhs: inout String) {
    print("specialized version")
    
    if lhs.caseInsensitiveCompare(rhs) == .orderedSame { return }
    
    let tmp = lhs
    lhs = rhs
    rhs = tmp
}
```

위 함수는 generic function로 선언된 함수가 아니고, 입력값을 String으로 제한한 함수입니다.

```swift
var a = "Hello"
var b = "Swift"
swapValue(lhs: &a, rhs: &b) // specialized version
```

이렇게 문자열을 입력한 두 변수를 사용해 함수를 호출하면 generic function보다 우선순위인 specialized function이 호출되었음을 알 수 있습니다. 

# 2. Generic Types

**collection은 전부 `구조체`이며 `generic type`입니다.** 동일한 형태의 값만 저장할 수 있는 이유입니다.

```swift
class Name<T> {
	code
}
struct Name<T> {
	code
}
enum Name<T> {
	code
}
```

새로운 형식은 아니고, 선언시 뒤에 type parameter를 붙이면 사용이 가능합니다. 클래스나 구조체, 열거형 내부에서 사용되는 값들의 타입 대신 타입파라미터를 사용할 수 있습니다. generic의 기본적인 문법을 그대로 사용하며, 형식제약도 동일합니다. 

**인스턴스를 생성하면 입력값에 따라 타입이 자동으로 추론됩니다.** 

```swift
struct Color<T> {
    var red: T
    var green: T
    var blue: T
}

var c = Color(red: 128, green: 0, blue: 122) // type(of:c) 는 Color<Int> 입니다.
```

이 때 이미 생성된 인스턴스인 c의 r,g,b 값을 각각 double 형식으로 바꾸어주면 에러가 발생합니다. Color<Double>과 Color<Int> 두 형식은 별도의 형식으로 처리되기 때문에 c의 파라미터로 다른 형태가 입력되면 에러가 발생합니다.

```swift
// c = Color(red: 128.0, green: 0.0, blue: 122.0)  // error! type(of:c)는 Color<Double>

let d: Color = Color(red: 128.0, green: 0.0, blue: 122.0) // 직접 타입을 지정해줄 수 있습니다.

// let e: Color // error! Color<T> 에서 T의 타입을 추론이 불가능합니다.
let e: Color<Int> //와 같이 정확한 타입까지 명시해주어야 합니다. 
```

**Array, Dictionary**를 살펴보겠습니다.

```swift
let arr: [Int] // 단축문법
let arr: Array<Int> 
let dict: Dictionary<String, Double>
```

제네릭 타입과 매우 유사한 형태입니다. 

Array와 Dictionary는 다양한 형태의 값을 처리할 수 있도록 제네릭 타입으로 구현되어있고, Int로 선언할 경우 컴파일러가 Int를 처리하는 문법을 자동으로 생성합니다.

extension을 통해 **제네릭을 확장할 수 있습니다.** 위에서 사용했던 Color 구조체를 확장해보겠습니다.

```swift
extension Color {
    func getComponents() -> [T] {
        return [red, green, blue]
    }
}
```

타입파라미터를 구조체 이름의 뒤에 붙이지 않고, 블록 내부 구현시에 타입으로 사용합니다. 따라서 구조체에서 사용했던 타입파라미터를 변경할 수 없고, 첫 선언시 사용했던 `T` 를 사용해야합니다. 

타입을 추론할 수 있어 인스턴스에 입력된 값이 정수일 경우 Color<Int> 형태의 인스턴스가 생성되고, 정수값의 배열을 리턴합니다. 

확장 시 `형식의 제약`이 필요한 경우 `where절`을 이용해 아래와 같이 표현합니다.

```swift
extension Color where T:FixedWidthInteger 
extension Color where T == Int
```

# 3. Associated Type

Generic Protocol을 선언하는 방법입니다.

프로토콜 내부에서 사용하는 place holder로 연관형식이라고 하며, 새로운 형식을 만드는 것은 아닙니다.

```swift
protocol QueueCompatible {
    associatedtype Element
    func enqueue(value: Element)
    func dequeue() -> Element?
}
```

`Element`라는 이름의 연관형식을 생성해주었습니다. UpperCamelCase로 작성하는 것이 관례입니다. 

typealias로 실제 타입을 선언하고 사용해주어야합니다. 물론 추론이 가능하다면 typealias는 생략이 가능하며, 실제 사용시에도 typealias는 자주 생략하는 편입니다.

```swift
class IntegerQueue: QueueCompatible {
    typealias Element = Int // typealias로 연관형식의 실제 타입 선언
    func enqueue(value: Int) { }
    func dequeue() -> Int? { return 0 }
}
class DoubleQueue: QueueCompatible { // typealias 생략, returnType으로 double로 추론 가능
    func enqueue(value: Double) { }
    func dequeue() -> Double? { return 0 }
}
```

연관형식에 제약을 추가하는 방법도 동일하게, 연관형식의 이름 뒤에 채용하는 프로토콜을 작성합니다.

```swift
associatedtype Element: Equatable
```