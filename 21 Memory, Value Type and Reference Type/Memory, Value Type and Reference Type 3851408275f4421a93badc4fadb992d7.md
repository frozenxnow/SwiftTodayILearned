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

→ 강의 더 남아있음!