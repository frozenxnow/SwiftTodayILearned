# Memory, Value Type and Reference Type

# 1. Memory Basic

컴퓨터는 전압의 차이를 사용해 값을 저장합니다. 가장 작은 단위는 `Bit`이며 전압이 흐를 때 1, 전압이 흐르지 않을 때 0을 나타냅니다. 

Bit는 정보의 기본 단위이며 이진수로 저장됩니다.

컴퓨터에서는 8개의 Bit가 모인 Byte를 기본 단위로 사용합니다. 

## [Byte]

바이트는 2의 8승 즉, 256개의 값을 저장할 수 있습니다.

양수를 저장할 경우 0 ~ +255 까지 저장할 수 있고, 

음수를 저장할 경우 -128 ~ +127 까지 저장할 수 있습니다.

![Memory,%20Value%20Type%20and%20Reference%20Type%203851408275f4421a93badc4fadb992d7/_2021-03-12__1.52.47.png](Memory,%20Value%20Type%20and%20Reference%20Type%203851408275f4421a93badc4fadb992d7/_2021-03-12__1.52.47.png)

Byte에서 가장 왼쪽에 위치한 Bit를 최상위 비트(MSB: Most Significant Bit), 가장 오른쪽에 위치한 Bit를 최하위 비트(LSB: Least Significant Bit)라고 합니다 . 

실제 값을 저장하는 모든 비트를 데이터 비트(Data Bit)라고 하며, 양수를 저장할 경우 모든 비트를 데이터 비트로 사용합니다. 

최상위비트를 사용해 양수와 음수가 결정되기 때문에 이를 Sign Bit(부호 비트)라고 합니다. (0: 양수, 1: 음수)

음수를 표현할 때에는 `2의 보수` 방식을 사용합니다. 0과 1을 각각 바꾸어주고 1을 더해주면 최종적으로 음수를 나타내게됩니다. 

Bit → Byte (8배)

Byte → KB → MB → GB → TB → PB → EB → ZB → YB (1024배)

메모리는 1Byte를 저장할 수 있는 공간마다 주소가 지정되어 있습니다. CPU는 이 주소를 통해 메모리에 접근합니다. 

## [Memory]

운영체제는 프로그램이 실행될 때마다 필요한 프로그램이 사용할 메모리를 할당합니다. 용도에 따라 나뉩니다.

- `Code` : 기계어로 번역된 프로그램 코드 저장됩니다.
- `Data` : 정적변수, 전역변수 저장됩니다. 프로그램 시작시 생성, 종료시 제거됩니다.
- `Heap` : 동적으로 할당된 데이터가 저장됩니다. 따라서 공간의 크기를 예측하기 어렵습니다. 데이터의 생성 시점과 제거 시점을 명확히 알 수 없어 자동으로 생성, 제거되지 않고 직접 코드를 만들어야합니다. 제거하지 않고 그대로 두면 프로그램이 종료될 때까지 데이터가 유지되고 이런 메모리가 많아지면 메모리가 부족해집니다. 필요 없는 메모리가 정상적으로 제거되지 않는 것을 `메모리 누수(Memory Leaks)`라고 합니다.
- `Stack` : 지역변수, 파라미터, 리턴값 등이 저장됩니다. 함수 호출과 밀접하게 관련되어 있으며 함수를 호출하면 함수에서 사용하는 모든 값이 저장되는 메모리 공간이 지동으로 생성됩니다. 이 공간을 Stack Frame이라고 부릅니다. Stack Frame은 함수 종료시 자동으로 제거되고, 다른 함수에서 메모리를 다시 사용할 수 있습니다. **LIFO(Last-In-First-Out)**

`값 형식`은 **Stack**에 저장됩니다. 더이상 사용되지 않으면 자동으로 제거되기 때문에 상대적으로 메모리 관리가 편리합니다.

`참조 형식`은 실제 값을 **Heap**에 저장하고, 그 주소를 **Stack**에 저장합니다. 값에 접근할 때는 항상 주소를 이용해 접근합니다. 값을 더이상 사용하지 않는다면 두 공간에 있는 메모리를 제거해 메모리 누수를 방지해야합니다.

# 2. Value Type vs Reference Type

- Value Type : Structure, Enumeration, Tuple
- Reference Type : Class, Closure

Value Type은 Stack에 저장된 값을 복사해 Stack에 새로운 메모리를 생성합니다. 

```jsx
struct SizeValue {
    var width = 0.0
    var height = 0.0
}

var value = SizeValue()
var value2 = value

value2.width = 1.0
value2.height = 2.0

// value: 0.0, 0.0
// value2: 1.0, 2.0
```

value와 value2는 각각 다른 메모리를 가지고 있고, value2.를 통해서 값을 변경하더라도 value의 값은 변경되지 않습니다. 

반면 Reference Type은 Heap에 저장된 값을 참조하는 주소가 복사됩니다.

```jsx
class SizeObject {
    var width = 0.0
    var height = 0.0
}

var obj = SizeObject()
var obj2 = obj

obj2.width = 1.0
obj2.height = 2.0

// obj: 1.0, 2.0
// obj2: 1.0, 2.0
```

obj와 obj2는 각자 다른 메모리 공간을 가지고 있지만 그 메모리에는 Stack에 저장된 주소값이 복사됩니다. 따라서 참조하는 값이 같기 때문에 obj.를 통해서 혹은 obj2.를 통해서 값을 변경하면 저장되어 있는 원본의 값이 변경됩니다. 

여기에서 SizeValue 인스턴스와 SizeObject 인스턴스를 let 키워드로 선언하게되면, SizeValue 인스턴스는 값 자체의 변경이 불가능한 상수가 되고, SizeObject 인스턴스는 참조하는 주소가 상수가 됩니다. 따라서 SizeObject의 실제 값은 상수가 아니기 때문에 변경이 가능합니다. 아래는 참조형식을 let으로 선언했을 때를 나타낸 그림입니다.

![Memory,%20Value%20Type%20and%20Reference%20Type%203851408275f4421a93badc4fadb992d7/_2021-03-12__10.11.09.png](Memory,%20Value%20Type%20and%20Reference%20Type%203851408275f4421a93badc4fadb992d7/_2021-03-12__10.11.09.png)

==. !=은 Stack에 저장된 값을 비교하는 데 쓰입니다. Value Type과 Reference Type 모두 Stack에 저장된 값을 비교하여 Bool을 리턴합니다.

Reference Type에서 ===, !==은 Heap에 저장된 주소를 비교하는 데 쓰입니다. 

# 3. ARC (Automatic Reference Counting)

메모리 관리 모델에 대해 알아보겠습니다. Heap에 저장된 값은 직접 제거해야하는데, 메모리 관리 모델은 이 데이터를 저장합니다. Swift에서 사용하는 메모리 관리 모델은 ARC 하나만 지원합니다. 

- Ownership Policy(소유 정책) : 인스턴스는 하나 이상의 소유자가 있는 경우 메모리에 유지됩니다. 소유자가 없으면 메모리에서 제거됩니다.
- Reference Count(참조 카운트) : 제거 시점을 파악하기 위해 소유자 수를 저장합니다. 참조 카운트가 1 이상이면 인스턴스는 유지되고, 0이 되면 제거됩니다.

![Memory,%20Value%20Type%20and%20Reference%20Type%203851408275f4421a93badc4fadb992d7/_2021-03-12__10.20.07.png](Memory,%20Value%20Type%20and%20Reference%20Type%203851408275f4421a93badc4fadb992d7/_2021-03-12__10.20.07.png)

 → 인스턴스를 변수에 저장하면 이 변수는 소유자가 되고, 참조 카운트는 1이 됩니다.

![Memory,%20Value%20Type%20and%20Reference%20Type%203851408275f4421a93badc4fadb992d7/_2021-03-12__10.20.40.png](Memory,%20Value%20Type%20and%20Reference%20Type%203851408275f4421a93badc4fadb992d7/_2021-03-12__10.20.40.png)

 → 또 다른 변수가 같은 인스턴스를 참조하면 참조 카운트는 2가 됩니다. 

인스턴스를 소유하기 위해서 변수에서 retain 메서드를 호출합니다.

인스턴스의 소유권을 포기하기 위해서 변수에서 Release 메서드를 호출합니다.

모든 변수가 소유권을 포기해 참조 카운트가 0이 되면 해당 인스턴스는 즉시 메모리에서 제거됩니다. 

Objective-C에서는 ARC와 MRC를 모두 사용했는데, ARC는 MRC(Manual Reference Counting)보다 코드의 양이 줄어들고 안정성이 높습니다. ARC는 소유 정책을 자동으로 처리하기 때문에 상대적으로 편리하고 안전합니다. 

ARC를 기본 모델로 사용하며, ARC를 이해하기 위해 세 가지 참조인 Strong Reference, Weak Reference, Unowned Reference를 알아야합니다. (강한 참조, 약한 참조, 비소유 참조)

## Strong Reference

강한 참조입니다. 기본적으로 소유자와 인스턴스는 강한 참조로 결합되어 있습니다. 대상을 참조할 때마다 참조 카운트는 1씩 증가하고 소유권을 포기할 때마다 1씩 감소합니다. 참조 카운트가 0이 되기 전까지 인스턴스는 메모리에서 제거되지 않습니다.

```jsx
class Person {
    var name = "John Doe"
    deinit {
        print("person deinit")
    }
}

var person1: Person?
var person2: Person?
var person3: Person?

person1 = Person()
person2 = person1
person3 = person1
```

Person 인스턴스가 메모리에서 제거되는 시점에 deinit이 실행됩니다. 

우선 Person() 인스턴스를 생성해 person1에 그 주소를 저장합니다. 그리고 person2와 person3에도 같은 주소(person1)를 저장합니다. 그렇게 되면 메모리에 있는 인스턴스의 참조카운트는 3이 됩니다. 

```jsx
person1 = nil
person2 = nil
```

변수에 nil을 저장하는 것은 소유권을 포기하는 것입니다. 소유권을 포기하는 즉시 강한참조가 사라지게 되고 참조 카운트도 1씩 감소하게 됩니다. person1과 person2가 소유권을 포기했고, 현재 메모리에 있는 인스턴스의 참조 카운트는 person3인 하나밖에 없는 상태입니다. 아직 인스턴스가 존재하기 때문에 deinit이 실행되지 않습니다.

```jsx
person3 = nil // console: "person deinit"이 출력됩니다.
```

마지막으로 person3에도 nil을 저장하게 되면 메모리의 인스턴스의 참조 카운트는 0이 되고, 비로소 삭제되며 deinit이 실행됩니다. 

# 4. Strong Reference Cycle

우선 강한참조의 문제점을 알기 위해 두개의 클래스를 만들고 각각의 인스턴스를 생성해, 서로 가지고 있는 인스턴스의 속성끼리 강한 참조를 하도록 구현하겠습니다.

```jsx
class Person {
    var name = "John Doe"
    var car: Car?
    deinit {
        print("person deinit")
    }
}

class Car {
    var model: String
    var lessee: Person?
    
    init(model: String) {
        self.model = model
    }
    
    deinit {
        print("car deinit")
    }
}

var person: Person? = Person()
var rentedCar: Car? = Car(model: "Porsche")
person?.car = rentedCar
rentedCar?.lessee = person
```

![Memory,%20Value%20Type%20and%20Reference%20Type%203851408275f4421a93badc4fadb992d7/_2021-03-13__2.07.12.png](Memory,%20Value%20Type%20and%20Reference%20Type%203851408275f4421a93badc4fadb992d7/_2021-03-13__2.07.12.png)

위 코드를 그림으로 나타낸 것입니다. 이렇게 인스턴스의 속성이 서로의 인스턴스와 강한 참조로 결합되어 있습니다. 이 때 각 변수에 nil을 할당할 경우 각각의 인스턴스에 대한 소유권을 포기하고, 인스턴스와 속성 남은 상태가 됩니다. 이들의 연결은 끊어지지 않은 상태가 됩니다.

```jsx
person = nil
rentedCar = nil
```

각 변수에 nil을 할당해 변수는 제거되었지만 여전히 서로를 참조하는 모습입니다. 여기에서 남아있는 연결을 제거하기 위해서는 변수를 통해 접근해야하는데, 변수가 없으니 제거할 방법이 없습니다. 

이러한 문제를 강한 참조 사이클(Strong Reference Cycle)이라고 하며, 약한 참조(Weak Reference)와 비소유 참조(Unowner Reference)로 해결이 가능합니다. 

![Memory,%20Value%20Type%20and%20Reference%20Type%203851408275f4421a93badc4fadb992d7/_2021-03-13__2.12.13.png](Memory,%20Value%20Type%20and%20Reference%20Type%203851408275f4421a93badc4fadb992d7/_2021-03-13__2.12.13.png)

## Weak Reference : 약한 참조

![Memory,%20Value%20Type%20and%20Reference%20Type%203851408275f4421a93badc4fadb992d7/_2021-03-13__2.16.40.png](Memory,%20Value%20Type%20and%20Reference%20Type%203851408275f4421a93badc4fadb992d7/_2021-03-13__2.16.40.png)

변수는 인스턴스를 참조하지만 소유하지는 않습니다. 참조 카운트의 수에도 영향을 미치지 않습니다.

참조하고 있는동안 언제든지 인스턴스가 사라질 수 있습니다. 소유자에 비해 짧은 생명주기를 가진 인스턴스를 참조할 때 사용합니다. 항상 Optional Type으로 선언합니다. 참조하고 있는 인스턴스가 사라지면 자동으로 이 변수는 nil로 초기화됩니다. 

```jsx
class Person {
    var name = "John Doe"
    var car: Car?
    deinit {
        print("person deinit")
    }
}

class Car {
    var model: String
    weak var lessee: Person? // 약한 참조
    
    init(model: String) {
        self.model = model
    }
    
    deinit {
        print("car deinit")
    }
}

var person: Person? = Person()
var rentedCar: Car? = Car(model: "Porsche")
person?.car = rentedCar
rentedCar?.lessee = person
```

![Memory,%20Value%20Type%20and%20Reference%20Type%203851408275f4421a93badc4fadb992d7/_2021-03-13__2.21.25.png](Memory,%20Value%20Type%20and%20Reference%20Type%203851408275f4421a93badc4fadb992d7/_2021-03-13__2.21.25.png)

lessee가 약한 참조로 선언되어 있습니다. 이전과 동일하게 연결되어 있지만 lesses는 car 속성을 약한 참조로 참조하고 있습니다. 따라서 person 인스턴스를 소유하지 않기 때문에 참조 카운트를 증가시키지 않습니다. 

```jsx
person = nil // console: "Person deinit"
rentedCar?lessee // nil이 할당됩니다.
```

person 변수에 nil을 할당하면 참조카운트가 1이었던 person 인스턴스는 즉시 메모리에서 제거됩니다. lessee는 약한 참조로 연결되어 있어 소유권이 없기 때문입니다. 약한 참조로 참조하고 있던 person이 제거되어 lessee에는 자동으로 nil이 저장됩니다.

```jsx
rentedCar = nil // console: "car deinit"
```

![Memory,%20Value%20Type%20and%20Reference%20Type%203851408275f4421a93badc4fadb992d7/_2021-03-13__2.25.19.png](Memory,%20Value%20Type%20and%20Reference%20Type%203851408275f4421a93badc4fadb992d7/_2021-03-13__2.25.19.png)

rentedCar에도 nil을 할당하여 소유권을 포기하게 되면 car 인스턴스와 강한 참조결합이 해제되며 변수가 제거되고 인스턴스 또한 참조 카운트가 0이 되어 인스턴스에서 제거됩니다.

메모리 누수 없이 모든 메모리가 정상적으로 제거되었습니다.

## Unowned Reference : 비소유 참조

![Memory,%20Value%20Type%20and%20Reference%20Type%203851408275f4421a93badc4fadb992d7/_2021-03-13__2.31.43.png](Memory,%20Value%20Type%20and%20Reference%20Type%203851408275f4421a93badc4fadb992d7/_2021-03-13__2.31.43.png)

약한 참조와 비슷하지만 약한 참조는 Optional Type이었던 반면 비소유 참조는 Non-Optional Type입니다.

속성이 non-optinal이어야 하거나, 인스턴스 생명 주기가 소유자와 같거나 더 긴 인스턴스를 참조할 때 주로 사용합니다. 

non-optional이기 때문에 약한 참조와 달리 참조할 대상이 사라지면 nil로 초기화되는 것이 아니라 런타임 에러가 발생합니다. 

```jsx
class Person {
    var name = "John Doe"
    var car: Car?
    deinit {
        print("person deinit")
    }
}

class Car {
    var model: String
    unowned var lessee: Person
    
    init(model: String, lessee: Person) {
        self.model = model
        self.lessee = lessee
    }
    
    deinit {
        print("car deinit")
    }
}

var person: Person? = Person()
var rentedCar: Car? = Car(model: "Porsche", lessee: person!)

person?.car = rentedCar

person = nil // console: "person deinit"
rentedCar = nil // console: "car deinit"
```

Car 클래스의 lessee 속성을 non-optional로 선언하고, unowned 키워드를 붙였습니다. 생성자를 통해 lessee를 초기화하여 기본값을 지정합니다. 

기본적인 사이클은 weak와 비슷합니다. 

# 5. Unowned Optional Reference

앞서 비소유 참조는 non-optional로 선언해야한다고 했으나 Swift 5+ 부터는 Optional도 가능합니다.

이렇게 선언할 경우 weak reference와 더욱 비슷해집니다. 차이점은 참조하고 있던 인스턴스가 사라질 때 속성이 업데이트 되는 방식에 있습니다. 

weak로 선언할 경우 참조 대상이 제거될 때 변수에는 nil이 할당됩니다. 그러나 unowned로 선언할 경우 참조 대상이 제거되는 시점에 변수가 업데이트 되지 않습니다. 그렇기 때문에 직접 nil로 초기화하는 것이 좋습니다. 때문에 알고있되 자주 사용하지 않도록 해야합니다. 

Type을 non-optional로 선언하는 경우 unowned reference를 사용하고
Type을 optional로 선언하는 경우 weak reference를 사용하도록 합니다.

# 6. Closure Capture List

클로저의 `self.` 키워드는 기본적으로 강한 참조로 이루어지며 클로저 종료시까지 존재하고, 메모리에서 제거되지 않습니다. 문제점을 살펴보기 위해 예제를 확인하겠습니다.

```jsx
class Car {
    var totalDrivingDistance = 0.0
    var totalUsedGas = 0.0
    
    lazy var gasMileage: () -> Double = {
        return self.totalDrivingDistance / self.totalUsedGas
    } // 클로저에서 self.는 강한 참조로 연결합니다.
    
    func drive() {
        self.totalDrivingDistance = 1200.0
        self.totalUsedGas = 73.0
    }
    
    deinit {
        print("car deinit")
    }
}
```

```jsx
var myCar: Car? = Car()
myCar?.drive() 
myCar = nil // colsole: "car deinit"
```

Car 인스턴스를 생성하고 drive()를 실행했습니다. 

이 때 강한 참조는 이루어지지 않기 때문에 car 인스턴스에 nil을 저장하면 참조 카운트가 0이 되어 인스턴스가 사라지고, 콘솔에는 deini이 실행된 결과가 출력됩니다.

그렇다면 클로저를 실행하는 코드를 살펴보겠습니다.

```jsx

var myCar: Car? = Car()
myCar?.masMileage()
myCar = nil // console: none

```

`self.` 를 통해 인스턴스 속성에 접근하고 있습니다. self 는 인스턴스 자체를 나타내는 속성으로 클로저가 실행될 때 self가 타내는 인스턴스 강한 참조로 캡쳐됩니다. 이 인스턴스는 클로저가 실행 완료될 때까지 메모리에서 제거되지 않습니다. 인스턴스를 캡쳐하는 클로저는 인스턴스 속성에 저장되어 있습니다. 인스턴스는 속성에 저장된 클로저를 강하게 참조합니다. 클로저와 인스턴스는 강한 참조로 연결됩니다. 

이를 해결하기 위해 클로저 캡쳐 리스트를 사용하는데, 문법을 먼저 살펴보겠습니다.

```jsx
{ [list] (parameters) -> ReturnType in
		code
}

{ [list] in
		code
}
```

여기에서는 `in` 키워드를 생략할 수 없습니다.

## Value Type의 Closure Capture List

```jsx
{ [valueName] in
		code
}
```

값을 리스트로 저장하는 문법입니다. 위에서 언급했듯 in은 생략할 수 없습니다. 반드시 리스트와 바디를 구분합니다.

```jsx
var a = 0
var b = 0
let c = { print(a, b) }

a = 1
b = 2
c() // 1 2 출력 
```

클로저 캡쳐 리스트를 사용하지 않았을 때 클로저 c를 실행하면 변경된 a, b값이 출력되는 것을 확인할 수 있습니다.

```jsx
var a = 0
var b = 0
let c = { [a] in print(a, b) }

a = 1
b = 2
c() // 0 2 출력 
```

클로저 캡쳐 리스트를 사용해 [a]를 캡쳐했습니다. 이 시점에 캡쳐된 a가 저장되어 값을 변경한 후에도 캡쳐 당시의 a 값인 0이 출력됩니다. 반면 b는 캡쳐되지 않았기 때문에 변경된 값이 출력됩니다.

## Reference Type의 Closure Capture List [weak, unowned]

```jsx
{ [weak instanceName, unowned instanceName] in
		statements
}
```

참조형식을 리스트에 저장하는 문법입니다. 반드시 weak나 unowned 키워드를 추가합니다.

위에서 강한 참조 사이클 문제가 발생했던 코드를 해결하기 위해 클로저 캡쳐 리스트를 사용해 클로저를 수정하겠습니다.

- Weak

```jsx
lazy var gasMileage: () -> Double = { **[weak self] in**
        **guard let strongSelf = self else { return 0.0 }**
        return strongSelf.totalDrivingDistance / strongSelf.totalUsedGas
    }
```

약한 참조로 weak 키워드를 사용했습니다. weak는 옵셔널 형식이기 때문에 언래핑이나 옵셔널 체이닝을 해서 멤버에 접근해야합니다. 클로저의 실행이 완료되지 않은 시점에 캡쳐 대상이 해제될 수 있다면(nil로 초기화될 수 있다면) 주로 약한 참조를 사용합니다. 약한 참조를 사용할 때에는 반드시 참조 대상이 제거되어 참조가 해제되는 경우를 고려해야합니다. 

약한 참조를 사용하기 때문에 더이상 강한 참조 사이클이 발생하지 않습니다. 따라서 myCar에 nil을 저장할 경우 정상적으로 메모리에서 인스턴스가 삭제되고 deinit이 실행됩니다. 

- Unowned

```jsx
lazy var gasMileage: () -> Double = { **[unowned self] in**
        return self.totalDrivingDistance / self.totalUsedGas
}
```

비소유 참조로 unowned 키워드를 사용했습니다. 옵셔널 형식이 아니기 때문에 클로저 캡쳐 리스트를 사용하지 않은 방식과 동일한 코드를 사용하고, 변경된 부분은 리스트를 추가하고 in을 사용해 리스트와 바디를 구분하는 부분 뿐입니다. `self.`는 이제 비소유 참조로 연결되어 더 이상 강한 참조 사이클 문제가 발생하지 않습니다. 

다만 클로저의 실행이 완료되기 전에 해제될 수 있고, 해제된 후 대상에 접근할 경우 런타임 오류가 발생할 수 있습니다. 따라서 캡쳐 대상의 주기가 클로저와 같거나 더 긴 경우에 주로 사용합니다.

# 7. Explicit Strong Capture

클로저 내부에서 모든 속성에 self.를 사용해 코드가 더욱 복잡해지는 것을 더욱 단순화시켜줍니다. 

구조체와 클래스를 나누어 살펴보겠습니다. 

구조체에서의 클로저에서는 self. 를 생략해도 문제가 발생하지 않습니다. 

Explicit Strong Capture 를 사용할 경우에도 [self]를 리스트에 추가할 경우 self. 를 생략할 수 있습니다. 

클래스에서는 강한 참조 사이클 문제가 발생할 확률이 높기 때문에 self.를 무작정 생략할 수 없습니다.

약한 참조나 비소유 참조를 사용하거나, 강한 참조로 연결해야하는 경우 

Closure Capture List를 사용해 [self]를 리스트에 추가할 경우 self. 생략이 가능합니다.