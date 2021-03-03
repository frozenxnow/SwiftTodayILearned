# Structure and Class

# 1. Structures & Classes

사용자 정의 데이터 타입에는 1) Enum 2) Structure 3) Class가 있습니다. 

SWIFT는 객체 지향 프로그래밍 언어입니다. 같은 객체를 추상화 하더라도 프로그램의 종류에 따라 다른 결과가 나옵니다.

클래스는 설계도 역할을 하며, 이 클래스를 통해 생성된 `객체`를 `인스턴스`라고 합니다. 인스턴스마다 속성에 저장된 값과 메서드의 실행 결과에는 차이가 있습니다. 객체끼리 상호작용을 할 수 있도록 구현하고, 이를 메시지를 주고받는다고 표현합니다. 

비교적 작은 데이터를 저장하거나 값 형식이 필요한 경우 `구조체`로 생성합니다. 스위프트는 구조체에도 클래스가 가진 대부분의 기능을 제공합니다. 구조체를 사용해 생성된 객체는 값이라고 부릅니다. 구조체도 설계도 역할을 하지만, 이 때 생성된 것은 객체가 아니라 `값`이라는 표현을 사용합니다. 

```swift
struct structName {
	property
	method
	initializer // 생성자
	subscript
}

class className {
	property
	method
	initializer // 생성자
	deinitiailizer // 소멸자
	subscript
}
```

구조체와 클래스의 이름은 UpperCamelCase로 짓는 것이 관례이며, 멤버는 LowerCamelCase로 짓습니다.

구조체와 클래스를 비교해보겠습니다. **공통점**입니다.

![Structure%20and%20Class%20d6dc1454b6fc414782d2fea26136acd9/_2021-03-03__6.23.22.png](Structure%20and%20Class%20d6dc1454b6fc414782d2fea26136acd9/_2021-03-03__6.23.22.png)

멤버로 property, method, initiailizer, subscript를 가지고 있으며 extension이 가능하고 protocol을 채용할 수 있습니다.

둘은 공통점이 많아 비슷해보이지만 `저장 방식`에서 **차이**를 가지고 있습니다.

![Structure%20and%20Class%20d6dc1454b6fc414782d2fea26136acd9/_2021-03-03__6.24.40.png](Structure%20and%20Class%20d6dc1454b6fc414782d2fea26136acd9/_2021-03-03__6.24.40.png)

**구조체**는 Stack이라는 메모리 공간에 데이터를 저장합니다. 그리고 값을 전달할 때마다 복사본을 전달합니다. 이를 `값형식`이라고 부르는데, 열거형과 기본 자료형은 모두 값형식에 속합니다. 

**클래스**는 Heap이라는 메모리 공간에 데이터를 저장합니다. Stack에는 Heap의 주소를 저장합니다. 값을 전달할 때 복사본이 아닌 원본 메모리의 주소를 전달합니다. 이를 `참조형식`이라고 부르는데, 클로저도 참조형식에 속합니다. 

소멸자는 클래스에서만 지원하고, 상속 또한 클래스에서만 허용됩니다. 

메모리 관리 방식에도 차이가 있습니다. **값형식(구조체)**에서는 인스턴스를 가진 `스코프가 종료`될 때 메모리에서 값이 삭제됩니다. **참조형식(클래스)**에서는 클래스에 관계 없이 `Reference Counting`을 통해 관리됩니다. (Counting이 0이 되면 메모리에서 삭제됩니다.)

# 2. Initializer Syntax

인스턴스를 생성할 때 실행되는 **생성자**의 목적은 `모든 속성을 초기화`하는 것입니다. 유일한 목적입니다.

생성자가 종료되는 시점 즉, 인스턴스가 생성된 시점에는 모든 속성의 값에 초기값이 저장되어 있어야 합니다. 

인스턴스를 생성할 때에는 생성자가 호출되어야 하는데 구조체(혹은 인스턴스)의 이름 뒤에 괄호를 붙입니다. 

```swift
class Position {
    var x: Double
    var y: Double
    
// init() 생성자는 모든 속성을 초기화해야 합니다.

    init() { // x와 y를 모두 0으로 초기화하는 생성자 
        x = 0.0
        y = 0.0
    }
    
    init(value: Double) { // parameter가 있는 생성자 
        x = value
        y = value
    }
}

let p1 = Position() // x: 0.0, y: 0.0
let p2 = Position(value: 3.2) // x: 3.2, y: 3.2
```

열거형, 구조체, 클래스는 설계도입니다. 이 설계도를 사용하기 위해서는 반드시 **생성자**가 필요합니다. **생성자는 모든 속성을 초기화시켜주는 함수**이며 생성자가 호출되면 모든 속성이 초기화가 완료됩니다. 에러 없이 초기화가 완료되면 인스턴스가 생성됩니다. 

# 3. Value Types / Reference Types

Value Type : Structure, Enumeration, Tuple, Collection
Reference Type : Class, Closure

**Value Type으로 생성한 인스턴스**에서 속성 값을 변경하면 원본에는 영향을 주지 않습니다. 앞서 말했듯 value type은 값의 복사본을 전달해 stack에 저정합니다. 

**Reference Type으로 생성한 인스턴스**에서 속성 값을 변경하면 원본의 값도 변경됩니다. 마찬가지로 reference type은 인스턴스가 저장된 메모리 주소를 전달하기 때문입니다. 원본과 주소를 별도의 공간에 각각 저장하고 주소를 통해 값에 접근합니다. 값은 그렇게 변경되기 때문에 인스턴스가 참조하는 원본에 영향을 미치게 되는 것입니다. 

# 4. Identity Operator

Value 형식끼리의 값을 비교할 때에는 서로 다른 메모리를 차지하고 있기 때문에 각 값을 비교합니다.

Reference 형식끼리의 값을 비교할 때에는 두가지를 비교해야합니다. 한 인스턴스가 두 개의 메모리 공간을 차지하고 있기 때문에 Heap에서 Value를 비교하고, Heap에서 메모리 주소를 비교해야합니다.

메모리 주소값을 비교할 때 Identity Operator를 사용합니다.

```swift
==
!= // 값을 비교하는 연산자

===
!== // 메모리 주소를 비교하는 항등연산자 
```

항등연산자를 이용해 값을 비교할 경우 **같은 인스턴스를 참조한다면** `true`를 리턴합니다.

# 5. Nested Type

내포된 형식입니다. 형식 속의 형식으로, 가장 큰 장점은 가독성입니다. 

```swift
class One {
    class Two {
        enum Three {
            case a
            class Four {
                
            }
        }
    }
    var a = Two()
    // One scope 내부에 선언되었기 때문에 One. 삭제해도 문제 없습니다.
}

// example
let two: One.Two = One.Two()
let four: One.Two.Three.Four = One.Two.Three.Four()
var newCase: One.Two.Three = One.Two.Three.a // enum Three의 case a
```