# Inheritance and Polymorphism

# 1. Inheritance

상속을 하는 클래스는 Base(Root)Class 입니다. `Super Class` 또는 `Parent Class` 라고 부르기도 합니다. 

상속을 받는 클래스는 `Subclass` 또는 `Child Class` 라고 부릅니다.

`Final Class`는 상속을 받을 수 있지만 다른 클래스에 상속할수 없습니다. 말 그대로 최종(끝) 클래스입니다.

Swift에서는 다중상속이 불가능합니다. 다중상속 대신 프로토콜을 이용해 보완할 수 있습니다.

부모클래스의 속성이나 함수 등을 상속받아 자식클래스에서는 이를 재정의(Override)하여 사용합니다.

# 2. Overriding

재정의(Override)가 가능한 요소는 methods, properties, subscripts, initializers 입니다.

재정의(Override)를 하는 방법에는 두가지가 있습니다.

```swift
1. 상속받은 정의를 무시하고 새롭게 정의하거나
2. 상속받아 기존의 정의에 새로운 정의를 추가하여 사용합니다.
```

자식클래스에서 `super.` 키워드를 사용해 부모클래스의 함수를 호출할 수 있습니다.

읽기전용 속성을 상속받아 읽기/쓰기(get block, set block)로 오버라이딩 할수 있으나 반대의 경우는 불가능합니다. 

속성을 상속받아 get block, set block을 생성한 뒤 `self.`를 사용해 자기 자신을 호출하지 않도록, 즉 재귀호출을 하지 않도록 주의해야 합니다. 

읽기전용 속성을 오버라이딩 했다면 Property Observer(willSet, didSet)는 사용할 수 없습니다. (사용할 필요가 없습니다.)

클래스가 아닌 속성이나 함수 앞에도 `final`을 추가할 수 있습니다. 이 경우 해당 속성/함수를 오버라이딩 할수 없습니다.

# 3. Upcasting and Downcasting

계층구조로 이루어진 클래스에서 타입을 변환하는 것입니다. 

`Upcasting`은 자식클래스로 생성한 인스턴스를 부모클래스 형식으로 저장하는 것이며, 이는 별도의 문법이 필요 없고 실패하거나 오류를 일으킬 확률이 적습니다.

`Downcasting`은 Upcasting 후 다시 되돌려놓는 것을 말합니다. 타입캐스팅 연산자를 사용합니다.

# 4. Type Casting

인스턴스의 타입을 확인하거나, 다른 타입으로 인스턴스를 처리해야할 때 사용합니다.

1) Type check operator : `is` 연산자입니다. Return Type은 Bool 입니다.

2) Type casting operator : `as` 연산자입니다. Return되는 것은 변환된 Type의 임시 인스턴스입니다.

```swift
as? // Conditional Cast, 컴파일 성공시 캐스팅 된 인스턴스를 리턴합니다. 실패할 경우 nil을 리턴합니다.
as! // Forced Cast, 강제 캐스팅으로 캐스팅 실패 시 오류가 발생합니다. 사용을 지양하는 편입니다.
```

### 다형성(Polymorphism)이란

예를 들어 계층 구조로 이루어진 클래스들의 인스턴스로 배열을 만들었을 때 각 인스턴스의 타입은 다르지만 공통적으로 상속을 받는 클래스가 있다면, 해당 배열의 타입은 가장 인접한 클래스의 형식이 됩니다.

배열의 타입과는 상관없이 각 인스턴스는 다른 타입이기 때문에 각각을 호출하면 각 인스턴스마다 오버라이딩 된 형태의 속성과 함수가 호출됩니다. 중요한 특성입니다.

# 5. Any and AnyObject

Swift에서 제공하는 범용 자료형입니다. 코드의 유연성은 높아지지만 가독성이 떨어지고 유지, 보수가 어려워 필요한 경우가 아니라면 사용하지 않는 타입입니다.

Any는 값형식과 참조형식 모두에서 사용할 수 있으나 AnyObject는 참조형식으로 제한됩니다.

위 타입으로 선언된 속성을 사용하기 위해서는 타입캐스팅이 필요합니다.

```swift
var data: Any = "Hello"
if let str = data as? String {
									print(str.count)
							}
```

String type으로 type casting이 가능하다면 str의 문자 수를 세어 콘솔에 출력하는 함수입니다. 

`Type Casting Pattern`을 사용하면 가독성이 높아지고 다양한 조건을 추가할 수 있습니다.

```swift
var data: Any = "Hello"
switch data {
case let str as String:
	print(str.count)
case let list as [Int]:
	print(str.count)
default:
	break
}
```

# 6. Overloading

오버로딩과 이름이 흡사하나 관계 없습니다. `오버로딩이`란 동일한 이름의 다양한 함수를 지정하는 것입니다.

컴파일러가 어떠한 함수를 만났을 때 동일한 이름의 함수를 찾아 어떤 규칙에 의해 그 중 하나를 채택합니다.

```swift
규칙1. 함수 이름이 동일하다면 파라미터의 수로 식별
규칙2. 함수 이름, 파라미터의 수가 동일하다면 파라미터의 자료형으로 식별
규칙3. 함수 이름, 파라미터가 동일하다면 argumentLabel으로 식별
규칙4. 함수 이름, 파라미터, argumentLabel이 동일하다면 리턴되는 값의 자료형으로 식별
			(그러나 이런 경우 새로운 이름의 함수를 부여하는 것을 권장합니다.)
```