# Enumerations

# 1. Enumerations Types

- 연관된 상수들을 하나로 묶은 형태입니다.
- 독립적인 자료형입니다.
- 각 case도 독립성을 가지고 있습니다.
- 코드의 가독성과 안정성이 높습니다.

```swift
enum TypeName {
	case caseName
	case caseName, caseName, ...
}
```

`TypeName.caseName`으로 호출합니다. (enum의 이름을 생략하고 `.caseName`만으로도 호출 가능합니다.)

if문에서 case를 비교할 때 `value == .caseName`과 같이 작성합니다. 하지만 열거형은 조건을 확인할 때 `switch문`을 사용하면 코드가 간결해져 가독성이 높아지고 작성하기에도 편리합니다. 

# 2. Raw Values

각 case는 `원시값`을 가지고 있습니다. 원시값의 자료형은 String, Character, Number Type 중 하나입니다. 

```swift
enum TypeName: **RawValuesType** {
	case caseName = value
	case caseName = value
}
```

선언 시점에 저장된 원시값은 후에 변경할 수 없습니다. 원시값 타입을 선언해주고 값 지정을 생략했다면 자료형마다 정해진 규칙에 따라 `기본 원시값`이 저장됩니다. `Int type의 원시값은 0부터` 저장됩니다.

```swift
enum Alignment: Int {
    case left // 0
    case right // 1
    case center // 2
}

enum Alignment: Int {
    case left // 0
    case right = 100 // 100
    case center // 101
}
```

원시값을 지정해주지 않을 경우 0부터 저장이 되지만 중간에 원시값을 지정해준다면 해당하는 원시값부터는 다음 기본값이 해당 원시값을 기준으로 변경됩니다.

이미 저장된 원시값은 변경할 수 없습니다.

생성자를 사용해보겠습니다. 

```swift
Alignment(rawValue: 0) // left
Alignment(rawValue: 200) // nil
```

rawValue가 200에 해당하는 케이스가 없기 때문에 위 함수는 `nil`을 리턴합니다. 따라서 생성자의 타입은 `Optional<Alignment>` 입니다.

나머지 String과 Character로 원시값이 지정된 열거형을 살펴보겠습니다.

```swift
enum Weekday: String {
    case sunday
    case monday = "MON"
    case tuesday
    case wednesday
    case thursday
    case friday
    case saterday
}

Weekday.sunday.rawValue // sunday : 저장한 String이 그대로 원시값이 됩니다.
Weekday.monday.rawValue // MON : 직접 저장한 원시값이 출력됩니다.

enum ControlChar: Character {
    case tab = "\t"
    case newLine = "\n"
}
// Character타입의 원시값을 생략할 수 없고, 반드시 직접 지정해주어야 합니다.
```

# 3. Associated Values

원시값은 열거형을 선언할 때 저장합니다. 반면 연관값은 인스턴스를 생성할 때 값을 저장합니다.

열거형을 선언할 때에는 연관값으로 받을 값의 타입을 입력합니다. 

```swift
enum VideoInterface {
    case dvi(width: Int, height: Int)
    case hdmi(Int, Int, Double, Bool)
    case displayPort(CGSize)
}
```

VideoInterface 열거형을 생성했습니다. `연관값은 tuple 형태로 입력받으며` 이름을 정해 가독성을 높일 수 있습니다. 

```swift
var input = VideoInterface.dvi(width: 2048, height: 1536)
```

input `인스턴스를 생성함과 동시에 연관값을 저장`했습니다. 

주로 switch문을 사용해 처리합니다. 

```swift
switch input {
case .dvi(2048, 1536):
    print("div 2048 x 1536") // .dvi의 width, height가 각각 일치할 때 출력됩니다.
case .dvi(2048, _):
    print("dvi 2048 x Any") // .dvi의 width가 2048일 때 출력됩니다.
case .dvi:
    print("dvi") // .dvi일 때 출력됩니다. 점점 범위가 확대되는 조건입니다. 
case .hdmi(let width, let height, let version, let audioEnabled):
    print("hdmi \(width) x \(height)") // 연관값을 바인딩해서 출력에 사용할 수 있습니다. 
case let .displayPort(size):
    print("dp")
}
```

input의 case와 연관값에 따라 처리하는 코드를 `switch문`으로 작성했습니다. (Enumeration Case Pattern)

위에서 생성한 input은 첫 switch문에서 처리되며 콘솔에 "div 2048 x 1536"를 출력합니다.

```swift
input = .hdmi(3840, 2160, 2.1, true)
```

input의 타입은 `VideoInterface`입니다. `.dvi`로 생성된 VideoInterface 타입이므로 이는 `.hdmi로 다시 저장할 수 있습니다.`

원시값과의 차이점은

1. 자료형을 선언하는 문법과
2. 값을 저장하는 시점

입니다.

**원시값은 열거형을 선언할 때 값이 저장되고, 연관값은 인스턴스를 생성할 때 값이 저장됩니다.** 

# 4. Enumeration Case Pattern

연관값을 가진 열거형 케이스를 매칭시킬 때 사용합니다. switch, if, while, guard, for-in문에서 사용합니다. 

```swift
case Enum.case(let name)
case Enum.case(var name) // 연관값을 개별로 바인딩할 때 각 연관값을 let, var로 선언합니다.

case let Enum.case(name)
case var Enum.case(name) // 모든 연관값을 바인딩할 때 사용 가능합니다. 
```

보통 Enum은 생략한 형태로 사용할 수 있습니다. 

```swift
enum Transportation {
    case bus(number: Int)
    case taxi(company: String, number:String)
    case subway(lineNumber: Int, express: Bool)
}

var tpt = Transportation.bus(number: 7)

switch tpt {
case .bus(let n):
    print("\(n)번 버스")
case .taxi(let c, var n):
    print("\(c) 회사의 \(n)번 택시")
case let .subway(l, e):
    print(l, e) // 모든 연관값을 바인딩하기 때문에 let을 case 앞에 작성해 효율적인 코드가 되었습니다.
}
```

if문을 사용해서 작성할 수 있습니다. 바인딩을 사용하지 않고 조건만 확인할 경우 if문의 condition에서 var 또는 let을 생략할 수 있습니다. 

부가적인 조건을 확인하기 위해서는 `where절`을 사용합니다.

```swift
let list = [Transportation.subway(lineNumber: 2, express: false),
            Transportation.bus(number: 4412),
            Transportation.subway(lineNumber: 7, express: true),
            Transportation.taxi(company: "SeoulTaxi", number: "1234")]

for case let .subway(n, _) in list {
    print("subway \(n)")
} // 급행 여부에 관계 없이 모든 지하철을 리턴합니다.
for case let .subway(n, true) in list {
    print("subway \(n)")
} // 급행 지하철을 리턴합니다.
for case let .subway(n, true) in list where n == 2 {
    print("subway \(n)")
} // 급행 지하철을 리턴하되 2호선 라인을 리턴합니다. 
```

# 5. CaseIterable

열거형의 기능을 확장하는 프로토콜입니다. 이 프로토콜을 채용하면 열거형의 모든 케이스를 `collection`으로, `배열`로 리턴하는 allCases 속성이 추가됩니다. 

```swift
enum Weekday: CaseIterable {
    case sunday 
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
}
```

랜덤으로 요일을 리턴하겠습니다. 기존의 방법으로라면 원시값을 랜덤으로 추출하도록 하겠지만 만일 원시값을 중간에 다르게 지정할 경우 오류가 생길 확률이 높기 때문에 `CaseIterable` 프로토콜을 채용한 후 실행하겠습니다.

```swift
Weekday.allCases.randomElement()
// Weekday.allCases는 배열이기 때문에 저장된 값 중 하나를 랜덤으로 추출하는 방식입니다.

for w in Weekday.allCases {
    print(w)
}
// Weekday.allCases는 배열이기 때문에 for-in문에서도 사용이 가능합니다.
```

# 6. Non-frozen Enumeration

기본적으로 switch문은 모든 경우를 처리할 수 있어야합니다. enum과 함께 사용할 경우 모든 case를 처리하도록 구현해야 합니다. 모든 case를 처리하도록 코드가 구현되어 있다면 default block은 필요가 없습니다. 

하지만 enum에 새로운 case를 중간에 추가할 경우, 새로운 case에 대한 실행문을 모든 switch문에 추가해주어야 컴파일 에러가 사라집니다. default가 있다면 컴파일 에러는 없지만 특정 case가 default로 처리되어버립니다.

이 때, default 앞에 @unknown 특성을 추가하면 컴파일러가 `개별적으로 처리되지 않은 case가 있음`을 경고합니다.

![Enumerations%208775b1c868a84b7ea7b42fc4ff9a67d1/_2021-03-02__8.48.44.png](Enumerations%208775b1c868a84b7ea7b42fc4ff9a67d1/_2021-03-02__8.48.44.png)

다음 코드를 살펴보면 case3에 대한 처리 내용이 없습니다. 이렇게 될 때 case3은 default 블록에 의해 처리될 것입니다. 그렇다면 컴파일러가 경고를 띄웁니다. "case3이 default로 처리되는데, 일단 실행은 하겠지만 괜찮은지? 혹시 별도로 처리해야하는 것 아니니?"