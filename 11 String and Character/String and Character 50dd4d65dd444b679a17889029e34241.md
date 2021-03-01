# String and Character

# 1. Strings & Characters

```swift
var s1 = "String" // String
var s2 = "S" // String
var s3 = " " // String
var s4 = "" // String
```

따옴표 안에 있는 것들을 문자열이라고 합니다. 위의 s1, s2, s3는 모두 문자열입니다. 타입을 명시해주지 않았기 때문에 컴파일러는 기본적으로 문자열이라고 추론합니다. s3의 경우 공백을 포함한 문자열이라고 하며, s4는 빈 문자열이라고 칭합니다. 빈 문자열은 `var s5 = String()`과 같이 생성자를 사용해 만들 수 있습니다. 문자열의 길이를 확인하는 함수는 `.count`를 사용하며, `s4.count`의 결과는 `0`입니다.

```swift
var c1: Character = "C" // Character
var c2: Character = " " // Character
```

문자 타입으로 선언했기 때문에 c1, c2는 모두 문자입니다. c2는 빈 문자라고 하며, 문자열과 달리 공백이 있습니다. 무조건 하나의 문자가 있어야 합니다. 

문자열에는 두 가지 타입이 있습니다.

`String` 은 `구조체`이며 `값 형식`으로, Swift String이라고 하겠습니다.

`NSString` 은 `클래스`이며 `참조 형식`으로, Foundation String이라고 하겠습니다.

두 문자열 타입은 서로 호환이 가능하나 `타입캐스팅`이 필요합니다.

```swift
var nsstr: NSString = "str"
let swiftStr: String = nsstr as String
```

서로의 변수나 상수에 저장할 수 있지만 `as` 를 사용해 해당 타입으로 타입캐스팅을 해주었습니다. 

( Toll-Free Bridged : 타입캐스팅으로 서로 호환이 가능한 관계 )

문자열의 가변성은 var, let 키워드로 결정됩니다.

스위프트에서 유니코드를 사용할 때에는 직접 이모티콘을 사용하는 것도 가능하고, 유니코드 값으로 사용하는 것도 가능합니다. 

```swift
var thumbup = "👍🏻"
thumbup = "\u{1F44D}"
```

# 2. Multiline String Literals

```swift
"""
명시적으로
줄바꿈을
허용하는
여러줄의 문자열입니다.
저장방식이 singleline과 달라 주의해야 합니다. 
"""
```

주의해야할 점은 

1) 큰 따옴표의 위치 : 첫 줄에는 큰 따옴표 세개만 입력합니다. 새로운 라인에서 Literal을 시작해야 하며, 마지막 줄에서도 마찬가지로 큰 따옴표 세개만 입력합니다.

2) 들여쓰기 적용 : 들여쓰기의 기준은 마지막 줄의 따옴표 위치입니다. 시작 위치보다 앞에 쓰여진 문자열이 있다면 컴파일 에러가 발생합니다.

3) back-slash(\) : \를 줄 마지막에 입력하면 줄바꿈이 사라집니다.

# 3. Raw Strings

큰 따옴표를 포함한 문자열 양 끝을 # 문자로 감싸면 Raw String이 됩니다. 기호 표기를 무시하고 문자 그대로 처리하게 됩니다. 문자열을 쉽게 구성하고 Literal과 최종 결과에 큰 차이가 없어 가독성이 높아집니다. 또한 정규식 문자열을 직관적으로 작성할 수 있다는 장점이 있습니다. 

```swift
var str = "\"Hello\", Swift!" // "Hello", Swift!
var rawStr = #""Hello", Swift!"# // "Hello", Swift!
```

back-slash와 함께 붙여야 했던 기호들을 그대로 출력합니다. 

```swift
var str = "\"Hello\",\n Swift!" 
// "Hello", 
// Swift!

var rawStr = #""Hello", \#n Swift!"# 
// "Hello", 
// Swift!
```

`\n` 은 기존 줄바꿈을 대신했습니다. Raw String에서 사용하기 위해서 `\#n`으로 사용합니다.

```swift
var rawStr = ###""Hello", \###n Swift!"###
// "Hello", 
// Swift!
```

#는 여러개를 사용해도 괜찮습니다. 그러나 앞 뒤, 중간에 있는 #의 개수를 모두 일치시켜야 합니다. 

# 4. String Interploation

`문자열 보간법` 입니다. 문자열을 동적으로 구성하는 방법에 대해 알아보겠습니다. 

문자열은 따옴표 안에 작성해야 하며, 중간에 표현식을 넣을 때 문자열을 쪼갤 필요가 없습니다.

```swift
var lang = "swift"
return "Hello, " + lang + "!" // Hello, swift!
return "Hello, \(lang)!" // Hello, swift!
```

두 리턴식은 모두 같은 문자열을 반환합니다. 작성하기에도 간편하고 가독성도 높습니다. 

![String%20and%20Character%2050dd4d65dd444b679a17889029e34241/_2021-03-01__12.40.35.png](String%20and%20Character%2050dd4d65dd444b679a17889029e34241/_2021-03-01__12.40.35.png)

문자열의 포맷을 사용해 자료를 표현하는 방법입니다. 

`f는 float`로 실수, `d는 decimal`로 십진수를 의미합니다. 

![String%20and%20Character%2050dd4d65dd444b679a17889029e34241/_2021-03-01__12.45.44.png](String%20and%20Character%2050dd4d65dd444b679a17889029e34241/_2021-03-01__12.45.44.png)

문자열 포맷에 입력값의 순서를 지정해주는 방법입니다. 입력하는 순서대로 `%@` 위치에 값이 입력 되었기 때문에 한글 포맷과 영어 포맷에서 firstName 과 lastName의 순서를 바꾸어야 했습니다. 

그러나 `%1$@`, `%2$@`로 입력값의 순서를 지정하니 포맷에서 입력되는 값의 순서에 따라 위치를 찾아 입력되는 모습입니다. 

back-slash는 문자열에서 특수한 기능을 가지고 있습니다. `escape sequence`라고 합니다.

```swift
\t : 간격(tab)
\n : 줄바꿈
\" : 문자열 내에서 큰 따옴표 출력
\' : 문자열 내에서 작은 따옴표 출력
```

# 5. New String Interpolation System

이전의 방식으로 모든 문자열의 포맷을 설정하기에는 약간의 제약이 있습니다.

```swift
struct Size {
	var width = 0.0
	var height = 0.0
}

let s = Size(width: 1.2, height: 3.4)
print("\(s)") // Size(width: 1.2, height: 3.4) 
```

이용자가 보기에는 좋은 출력 화면이 아닙니다. Size에 저장된 값을 `1.2 x 3.4` 형태로 출력해보겠습니다.

이전에는 `CustomStringConvertible` 프로토콜을 채용해 표현했습니다. 

```swift
extension Size: CustomStringConvertible {
    var description: String {
        return "\(width) x \(height)"
    }
}
print("\(s)") // 1.2 x 3.4
```

스위프트의 새로운 기능인 `String Interpolation`을 사용해 표현하겠습니다.

이는 출력시 포맷을 변경하고자 할 때 사용하는 것입니다. 

appendInterpolation은 반드시 `mutating instance`로 선언해야합니다.

그리고 parameter 형식은 StringInterpolation을 지원할 형식으로 선언합니다.

appendInterpolation에서 선언할 수 있는 메서드는 두가지입니다.

```swift
appendLiteral(literal: String) // 문자열 리터럴 추가
appendInterpolation(value: CumtomStringConvertible & TextOutputStreamable)
// StringInterpolation 결과 문자열에 새로운 문자열 추가 
```

위의 규칙을 참고하여 String.StringInterpolation을 확장했습니다. 

```swift
extension String.StringInterpolation {
    mutating func appendInterpolation (_ value: Size) {
        appendInterpolation("\(value.width) x \(value.height)")
    }
}
print(s) // Size(width: 1.2, height: 3.4)
print("\(s)") // 1.2 x 3.4
```

s를 그대로 출력하지 않고 보간법을 사용해 출력했을 때 기본 설정되어 있는 문자열 포맷이 변경된 것을 확인할 수 있습니다. String.StringInterpolation을 하나 더 선언하고, 매개변수로 스타일도 함께 주어 출력할 때마다 이용하고자 하는 포맷을 파라미터로 전달하는 방법도 있습니다. 

String.StringInterpoltaion 내부의 두 번째 함수를 살펴보겠습니다.

```swift
extension String.StringInterpolation {
    mutating func appendInterpolation (_ value: Size) {
        appendInterpolation("\(value.width) x \(value.height)")
    }

    mutating func appendInterpolation(_ value: Size, style:NumberFormatter.Style) {
        let formatter = NumberFormatter()
        formatter.numberStyle = style

        if let width = formatter.string(for: value.width), let height = formatter.string(for: value.height) {
            appendInterpolation("\(width) x \(height)")
        } else {
            appendInterpolation("\(value.width) x \(value.height)")
        }
    }
}
```

파라미터로 value와 style을 받았습니다. value는 string interpolation을 지원받을 값을, style에는 지정하고자 하는 스타일을 넣기 위해 NumberFormatter.Style을 입력했습니다. (여기에 대해서는 포맷을 더욱 공부해야할 것 같습니다.) 

특정 포맷을 formatter 상수에 저장했습니다. 

입력받은 스타일을 formatter의 numberStyle 속성에 저장하고, 바인딩합니다.

바인딩이 성공적으로 이루어졌다면 호출시 입력받은 Style의 형식으로 Size 인스턴스가 출력될 것이고,

바인딩에 실패했다면 1.2 x 3.4의 형식으로 출력될 것입니다. 

```swift
print(s) // Size(width: 1.2, height: 3.4)
print("\(s)") // 1.2 x 3.4

// style 파라미터로 .spellOut 을 전달하면 아래와 같이 출력됩니다.
print("\(s, style: .spellOut)") // one point two x three point four
```

어떤 형식으로 사용되는지 이제 조금 알 것 같습니다. 아래의 글이 많은 도움이 되었습니다.

[Swift) swift 5에 추가된 String Interpolation](https://koggy.tistory.com/16)

# 6. String Indices

문자열에도 인덱스가 존재합니다. 이 인덱스는 정수형이 아님을 기억해둡시다.

```swift
let str = "Swift"

let firstCh = str[str.startIndex] // S
let lastCh = str[str.index(beford: str.endIndex)] // t
```

`startIndex`는 말 그대로 문자열의 첫 문자의 위치입니다.

`lastIndex`는 문자열의 끝 문자가 아닌 그 다음 위치를 가리킵니다. 그 이전의 인덱스를 추출하고 싶을 때 단순히 -1을 해서 추출할거라 생각했는데, 앞서 언급했던 사실을 돌이켜보면 "인덱스는 정수형이 아닙니다".  그렇기 때문에 `index(before:)` 함수를 사용해야합니다. 파라미터로 endIndex를 전달하면 그 앞 인덱스가, 즉 문자열의 마지막 문자가 추출됩니다.

```swift
str.index(after:)
str.index(before:)
str.index(기준index, offsetBy:정수)
// 기준 index로부터 정수만큼 떨어진 위치의 인덱스 
// 양수일 경우 오른쪽으로, 음수일 경우 왼쪽으로 이동 
```

만약 빈 위치의 인덱스를 반환하려고 하면 크래쉬가 발생하기 때문에 `if문`을 이용해 `유효성을 검사`하는 과정을 필요로 합니다. 정수형은 아니지만 대소비교가 가능하기 때문에 아래와 같은 조건을 추가해줍니다.

```swift
if x < str.endIndex && x >= str.startIndex {
	// code
}
```

# 7. String Basics

문자열에 대한 기본적인 내용을 정리하겠습니다.

```swift
var str = String() // String() 은 생성자로, 빈 문자열을 생성하는 코드입니다. 
str.count = 0 // 이렇게 생성한 문자열은 빈 문자열이기 때문에 문자열의 길이는 0입니다.
str.isEmpty // true를 반환하는 메서드입니다. 빈 문자열인지 확인하기 위해 사용합니다.

str = String(123, radix: n) // 123을 n진수로 표현하여 저장합니다.
str = String(repeating: "👻", count: n) // repeating의 문자를 n개 반복하여 문자열을 생성합니다.

str = \u{abcdef} // 유니코드를 표현합니다.

// >, <, >=, <= 비교 연산자를 사용할 수 잇습니다. 소문자>대문자, 사전식 배열에서 뒤로 갈수록 큽니다.
// 비교연산자를 사용할 때 컴파일러는 대소문자를 구분하여 비교하기 때문에 대소문자의 구분을 없애기 위해
str.lowercased() // 와 같은 함수를 사용합니다. 원본을 수정하지 않고 잠시 소문자로 모두 변환합니다. 
str.uppercased() // 마찬가지로 원본을 수정하지 않고 잠시 대문자로 모두 변환합니다. 주로 비교에 사용

str.capitalized() // 원본을 수정하지 않고 잠시 upperCamelCase로 변환합니다.
// var string = "hello swift"
// string.capitalized() "Hello Swift"

str.randomElement() // 문자열 중 랜덤으로 한 문자를 추출합니다.
str.shuffled() // 문자열을 무작위로 섞어 배열로 반환합니다.
```

문자열은 문자의 집합으로 단어를 하나씩 쪼개 열거할 수 있습니다.

```swift
var str = "Swift"
for index in str {
    print(index)
}

// S
// w
// i
// f
// t
```

# 9. Substring

문자열을 처리할 때 메모리를 절약하기 위해 사용합니다. 

![String%20and%20Character%2050dd4d65dd444b679a17889029e34241/_2021-03-01__2.40.19.png](String%20and%20Character%2050dd4d65dd444b679a17889029e34241/_2021-03-01__2.40.19.png)

str 변수 중 첫번째 단어를 저장하는 `str.prefix(1)` 은 변수 first에 저장되었습니다.

이 때 first의 타입은 `substring`으로, 새로운 메모리를 생성하지 않고 기존 문자열의 일부 문자를 가리키고 있습니다. 메모리를 절약하는 것입니다. 

first를 변경할 경우 새로운 문자열이 생성되는데, 이 때 새로운 메모리를 생성하게 됩니다. 

![String%20and%20Character%2050dd4d65dd444b679a17889029e34241/_2021-03-01__2.45.23.png](String%20and%20Character%2050dd4d65dd444b679a17889029e34241/_2021-03-01__2.45.23.png)

insert() 메서드는 원본을 변경하는 메서드이기 때문에 first의 원본인 "H"를 "H!"로 변경해 새로운 메모리를 생성하고 그곳에 저장합니다. 이 때 메모리가 생성되는 것이지 단순히 perfix(1)로 값을 추출했을 때에는 새로운 메모리가 생성되지 않습니다. 그리고 기존 str에는 영향을 주지 않습니다. 이를 copy-on-write Optimization(최적화)라고 부릅니다. 

Copy-on-Write Optimization은 스위프트 전반에서 사용되고 있으며, 이는 불필요한 메모리 생성을 최소한으로 줄여 메모리를 효율적으로 사용하게 합니다.

```swift
let newStr = String(str.prefix(1))
type(of: newStr) // String
```

만약 Substring이 아닌 String으로 바로 저장하고자 한다면 String() 생성자를 사용합니다.

```swift
let s = str[str.startIndex ..< str.index(str.startIndex, offsetBy: 2)]
let s = str[..<str.index(str.startIndex, offsetBy: 2)]
 // 시작범위를 생략할 경우 startIndex로 자동 설정됩니다. 모두 같은 실행결과를 얻을 수 있습니다.

let s = str[str.index(str.startIndex, offsetBy: 2)...]
 // 마찬가지로 마지막 범위를 생략할 경우 문자열 마지막까지 추출됩니다.
```

일정 범위의 문자열을 추출하기 위해 `substring()` 메서드를 사용했지만 (현재도 사용이 가능하지만) 앞으로는 사용할 수 없게 되므로 위와 같이 추출해야합니다. 인덱스는 정수형이 아니기 때문에 코드가 지저분해보이지만, 앞으로 배우게 될 extension으로 해결할 수 있습니다.  여기에서 s의 타입은 역시나 `substring`입니다.

# 9. String Editing #1

## 1) Appending Strings and Characters : 문자열 추가

문자열을 편집하는 방법 중 함수를 사용하는 방법에 대해 알아보겠습니다.

```swift
var str = "Hello"
str.append(", ") // print(str) : Hello,

var s = str.appending("Swift") // print(s) : Hello, Swift

"File size is ".appendingFormat("%.1f", 12.3456)
```

`.append(value)` 는 원본 값을 변경하는, Void를 리턴하는 함수이고 

`.appending(value)` 은 새로운 문자열을 반환하는 함수입니다. 새로운 문자열을 생성해 s에 저장합니다.

메서드 중 `동사원형`의 형태인 것은 대부분 대상 문자열을 직접 변경하기 때문에 상수로 선언되었을 경우 사용할 수 없습니다. 반면 `-ing`, `-ed` 형태의 메서드는 대상 문자열을 변경하지 않습니다. 원본을 기반으로 작업한 후 새로운 문자열을 리턴하는 방식입니다. 원본 값을 변경하지 않기 때문에 대상 문자열이 var와 let 중 어느것으로 선언되어 있어도 상관 없습니다. 

`.appendingFormat(format, value)`은 문자열을 리턴하는 함수입니다. -ing의 형태이기 때문에 원본 값을 변경하지 않는 함수입니다. 

문자열을 문자열의 중간에 추가하는 방법에 대해 알아보겠습니다.

```swift
var str = "Hello Swift"

str.insert(",", at: str.index(str.startIndex, offsetBy: 5))

if let sIndex = str.firstIndex(of: "S") {
    str.insert(contentsOf: "Awesome ", at: sIndex)
}
```

insert 메서드는 하나의 문자를 추가할 수 있습니다. 파라미터로 추가할 문자와 추가할 위치를 입력합니다. 

특정 위치에 문자열을 추가하기 위해서는 해당 인덱스를 알아내야 합니다. 위 예제에서는 Swift 앞에 Awesome을 추가하기 위해 S 인덱스의 위치를 `.firstIndex(of:)` 함수로 알아내 sIndex에 바인딩 했습니다. `.firstIndex` 함수는 어떤 문자열이 최초로 등장하는 위치 인덱스를 반환하는 함수입니다. 

# 10. String Editing #2

## 2) Replacing Substrings : 문자열 수정

```swift
.replaceSubstarnge(범위, 대체문자)
.replacingCharacters(범위, 대체문자)
.replacingOccurrences(변경할문자, 변경될문자)
```

위 세가지 메서드는 모두 문자열을 수정하는 메서드입니다. 여기에서 범위는 정수가 아니기 때문에 인덱스를 사용해 나타내어야 하는데 이렇게 작성하면 코드가 지저분해지므로 `range(of:)`를 사용해 구할 수 있으며, 옵셔널 바인딩을 통해 사용해주어야 합니다. 범위를 작성할 필요 없이 문자열을 찾아 다른 문자열로 바꾸는 간편한 메서드도 존재합니다. 

```swift
var str = "Hello, Objective-C"

if let range = str.range(of: "Objective-C") {
    str.replaceSubrange(range, with:"Swift")
} // Hello, Swift

if let range = str.range(of: "Hello") {
    let s = str.replacingCharacters(in: range, with: "Hi")
    str // Hello, Swift 
    s // Hi, Swif
} // replacing(-ing)이므로 원본 값은 변경되지 않습니다. 변경된 새로운 문자열 생성

var s = str.replacingOccurrences(of: "Swift", with: "Awesome Swift")
s // Hello, Awesome Swift
str // Hello, Swift // 마찬가지로 원본 값은 변경되지 않습니다.

s = str.replacingOccurrences(of: "swift", with: "Awesome Swift")
// 기본적으로 문자열을 비교할 때에는 대소문자를 구분하기 때문에 
// 소문자로 작성된 swift는 문자열에 존재하지 않는다고 판단합니다. 

s = str.replacingOccurrences(of: "swift", with: "Awesome Swift", 
	options: [.caseInsensitive]) // Hello, Awesome Swift
// 대소문자를 무시하고 비교하기 위해서는 .caseInsensitive 옵션을 추가해주어야 합니다.
```

## 3) Removing Substrings : 문자열 삭제

`**remove**` **로 시작하는 메서드입니다.**

```swift
let lastCharIndex = str.index(before:str.endIndex) // 마지막 문자의 인덱스
str.remove(at: lastCharIndex) // 마지막 문자의 인덱스에 위치한 문자 삭제 ==str.removeLast()
str.removeFirst() // 첫 문자 삭제 
str.removeFirst(6) // 앞 6개의 문자 삭제 
str.removeLast() // 마지막 문자 삭제 
str.removeLast(6) // 마지막 6개의 문자 삭제 

if let range = str.range(of: "Awe") {
    str.removeSubrange(range)
} // range(of:)로 특정 문자열의 인덱스를 구해 그 범위 문자열 삭제 

str.removeAll() // 문자열과 메모리 공간을 다 삭제해버리는 메서드 
str.removeAll(keepingCapacity: true) // 메모리 남기고 문자열만 삭제
 // 다시 그 메모리 공간에 문자열을 추가할것이라면 keepingCapacity: true
```

`**drop` 으로 시작하는 메서드입니다.**

```swift
substr = str.dropLast()
substr = str.dropLast(3)
substr = str.dropFirst()
substr = str.dropFirst(3)

substr = str.drop(while: { (ch) -> Bool in
    return ch != ","
})
```

`drop`으로 시작하는 메서드의 리턴은 substring type으로, 이는 원본 문자열과 메모리를 공유한다는 의미입니다. 

대부분 remove 함수와 비슷하지만, drop() 메서드는 파라미터로 Bool을 리턴하는 클로저를 받습니다. Bool이 ture인 동안 문자를 삭제하는 형식입니다. 위 함수는 처음으로 `콤마(,)`가 나오기 전까지의 문자를 삭제합니다. 

# 11. String Comparison

문자열의 대소비교는 기본적으로 대소문자를 구분합니다. 

크고 작음을 비교할 때에는 1) 소문자가 대문자보다 크고 2) 사전식 배열에서 뒤로 갈수록 큽니다. 

두 문자열을 비교하기 위해서는 compare 메서드를 사용할 수 있습니다.

```swift
let largeA = "Apple"
let smallA = "apple"
let b = "Banana"

largeA.compare(smallA) == .orderedSame // 대소문자를 구분하기 때문에 false
largeA.caseInsensitiveCompare(smallA) == .orderedSame // 대소문자 무시한채 비교하기 때문에 true

largeA.compare(smallA, options: [.caseInsensitive]) == .orderedSame 
// 위에서 caseInsensitiveCompare로 비교한 것과 같은 메서드입니다.
```

prefix와 suffix를 포함하는지 알아보는 함수가 존재합니다.

```swift
let str = "Hello, Swift Programming!"
let prefix = "Hello"
let suffix = "Programming"

str.hasPrefix(prefix) // true
str.hasSuffix(suffix) // false (느낌표 부재)
```

위 함수도 대소문자를 구분하여 비교합니다. 이를 무시하고 비교하기 위해서는 `.lowerCased` 등을 사용해 모든 문자열을 하나로 통일시킨 후 비교해야합니다. 

# 12. Finding Substrings

문자열을 포함하는지 알아보기 위한 함수입니다.

```swift
str1.contains(str2)
```

str1에 str2가 있다면 true, 없다면 false를 리턴하는 함수입니다. 마찬가지로 대소문자를 구분하며, 이를 무시하기 위해서는 .lowerCased 등으로 문자열의 대소문자를 일치시켜야 합니다.

```swift
str1.range(of:str2)
```

str1에서 str2가 존재하는 위치의 인덱스를 반환하는 함수입니다. 이는 optional로 선언되어 있기 때문에 주로 옵셔널 바인딩과 함께 사용합니다. range(of:) 외에도 options를 추가할 수 있습니다. options: [.caseInsensitive]를 추가하면 대소문자를 무시한 채 str2를 찾습니다. 

```swift
let str = "Hello, Swift Programming!"
let str2 = "Hello, Programming"
let str3 = str2.lowercased()

var common = str.commonPrefix(with: str2) // Hello,
common = str.commonPrefix(with: str3) // ""

str.commonPrefix(with: str3, options: [.caseInsensitive]) // Hello,
```

`commonPrefix`는 공통된 부분을 `substring`으로 반환하는 함수입니다. 공통되는 부분이 없다면 빈 문자열을 출력합니다. `options`를 추가할 수 있으며, `[.caseInsensitive]`로 대소문자를 무시할 수 있습니다.  대소문자를 무시하고 비교한 뒤 공통된 문자열을 substring으로 반환할 때에는 파라미터로 받는 문자열이 아닌 함수가 사용되는 문자열을 기준으로 문자열이 생성됩니다.

# 13. String Options #1

## 1) Case Insensitive Option

대소문자를 비교하는 옵션입니다. 주로 문자열을 검색하거나 비교할 때 사용합니다. 

## 2) Literal Option

'한' 이라는 문자를 비교하겠습니다. 유니코드로 한 글자로 전달하는 한과, 초성 중성 종성으로 각각 나누어 전달하는 한을 비교하겠습니다.

```swift
let a = "\u{D55C}"
let b = "\u{1112}\u{1161}\u{11AB}"

a == b // true
a.compare(b) == .orderedSame // true
a.compare(b, options: [.literal]) == .orderedSame // false
```

단순히 코드를 비교하는 함수가 아니라 최종 문자열을 비교하는 함수입니다. Objective-C에서는 false가 리턴되기 때문에 두 언어를 함께 사용한다면 주의해야합니다. 만약 Objective-C처럼 코드를 비교해야한다면 `options: [.literal]` 옵션을 사용합니다.

## 3) Backwards Option

검색 방향을 지정하는 옵션입니다. 검색 방향은 `Leading → Trailing`입니다. 

![String%20and%20Character%2050dd4d65dd444b679a17889029e34241/_2021-03-01__8.21.40.png](String%20and%20Character%2050dd4d65dd444b679a17889029e34241/_2021-03-01__8.21.40.png)

문자열 "p"의 위치를 인덱스 숫자로 반환하는 함수입니다. option이 없는 경우 `Leading에서부터 검색`을 하면 처음으로 등장하는 p의 인덱스 값은 5이고, `options: [.backwoards]`를 추가했을 경우 `Trailing에서부터 검색`을 하게되어 더 뒤에 있는 p의 인덱스 값인 6을 반환합니다.

## 4) Anchored Option

단독으로 사용되는 일이 거의 없고 사용 빈도가 매우 낮습니다. 

단독으로 사용할 경우 접두어를 비교하는 것이고, .`backwards`옵션과 함께 사용하면 접미어를 비교하는 것입니다.

## 5) Numeric Option

문자열에 포함된 숫자를 비교하는 옵션입니다.

```swift
let file9 = "file9.txt"
let file10 = "file10.txt"

file9.compare(file10) == .orderedAscending
file9.compare(file10, options: [.numeric]) == .orderedAscending
```

옵션 없이 비교할경우 앞 문자부터 차례로 비교하기 때문에 file9>file10이 true가 됩니다.

옵션을 추가해줄 경우 문자를 제외한 숫자만 비교를 하기 때문에 file9<file10이 true가 됩니다.

## 6) Diacritic Insensitive

발음기호를 무시하는 옵션입니다.

```swift
let a = "Cafe"
let b = "Cafè"

a == b // false
a.compare(b) == .orderedSame // false
a.compare(b, options: [.diacriticInsensitive]) == .orderedSame // true
```

## 7) Width Insensitive Option

전각문자와 반각문자를 무시하는 옵션입니다.

```swift
let a = "\u{30A1}" // 전각문자 ァ
let b = "\u{ff67}" // 반각문자 ァ

a == b // false
a.compare(b) == .orderedSame // false
a.compare(b, options: [.widthInsensitive]) == .orderedSame // true
```

## 8) Forced Ordering Option

강제정렬 옵션입니다. 다른 옵션에 비해 사용 빈도는 낮으며 다른 옵션을 무시한 채 강제로 정렬하는 옵션을 의미합니다. 

## 9) Regular Expression

정규식 표현 옵션입니다. 주로 입력값을 검증하는 데 사용합니다.

```swift
// email 패턴의 정규표현식입니다
let emailPattern = "([0-9a-zA-Z_-]+)@([0-9a-zA-Z_-]+)(\\.[0-9a-zA-Z_-]+){1,2}"
let emailAddress = "user@example.com"

if let _ = emailAddress.range(of: emailPattern) {
    print("found")
} else {
    print("not found")
} // not found : 단순히 표현식과 이메일이 같은지 비교하기 때문에 바인딩 실패

if let _ = emailAddress.range(of: emailPattern, options: [.regularExpression]) {
    print("found")
} else {
    print("not found")
} // found : 첫번째 파라미터로 전달된 표현식을 정규식으로 처리하게 되어 바인딩 성공
```

하지만 위와 같은 방법으로만 이메일을 검증할 경우 한계가 있습니다. 

`range(of:)`는 해당 패턴이 존재한다면 범위를 리턴하는 함수입니다. 이것만으로 이메일을 검증하기에는 부족하기 때문에, 리턴된 범위가 입력된 문자열의 전체 범위와 같은지 다시 한 번 확인하는 절차가 필요합니다. 

한가지 조건을 더 추가했습니다. range로 바인딩하고 튜플을 선언한 후 인덱스를 비교하는 것입니다. 

```swift
if let range = emailAddress.range(of: emailPattern, options: [.regularExpression]), 
	(range.lowerBound, range.upperBound) 
	== (emailAddress.startIndex, emailAddress.endIndex) {
    print("found")
} else {
    print("not found")
}
```

위 실행문이 이해가 가지 않아서 문의를 남겼는데 빨간날에도 답변이 왔습니다. 

**질의내용**

![String%20and%20Character%2050dd4d65dd444b679a17889029e34241/_2021-03-01__11.39.51.png](String%20and%20Character%2050dd4d65dd444b679a17889029e34241/_2021-03-01__11.39.51.png)

패턴과 일치하는 문자열과 검색을 실행했던 문자열의 범위가 서로 일치하는지 확인하는 과정이었습니다. 바꾸어 말하면 `내가 검색했던 그 이메일이 패턴과 일치하는 문자열만 존재하는지!` 이것을 알아본다고 생각하면 될 것 같습니다. 

# 15. Character Set

문자의 집합입니다. 

```swift
let a = CharacterSet.uppercaseLetters // 대문자들로 이루어진 문자의 집합
let b = a.inverted // 대문자를 제외한 문자들의 집합

var str = "loRem Ipsum"
var charSet = CharaterSet.uppercaseLetters // 대문자들로 이루어진 문자들의 집합

if let range = str.rangeOfCharacter(from: charSet) {
	print(str.distance(from: str.startIndex, to: range.lowerBound))
} // str에서 처음으로 검색되는 대문자 R의 인덱스인 2 출력

if let range = str.rangeOfCharacter(from: charSet, options: [.backwards]) {
    print(str.distance(from: str.startIndex, to: range.lowerBound))
} // str 뒤에서부터 처음으로 검색되는 대문자인 I의 인덱스 6 출력
```

str에는 대소문자가 섞여있는 문자열이 저장되어 있습니다. charSet은 대문자들로만 이루어진 문자들의 집합입니다. `rangeOfCharacters(from:)` 함수는 대상 문자열에서 `characterSet에 포함되는 문자를 검색`하는 기능을 하고, 그것을 `range로 바인딩` 합니다. distance() 함수를 통해 index를 숫자로 반환하면 각 문자의 인덱스가 반환됩니다. 

첫번째 함수에서는 첫 대문자인 R의 인덱스인 2를 출력합니다. 

두번째 함수에서는 `options: [.backwards]` 옵션에 의해 검색 방향이 바뀌고, 뒤에서부터 검색을 시작합니다. 뒤에서부터 가장 먼저 검색되는 I의 인덱스인 6을 출력합니다. 

공백, 탭 문자들의 집합 : `CharacterSet.whitespaces` 입니다. 

```swift
str = " A p p l e "
charSet = CharacterSet.whitespaces

let trimmed = str.trimmingCharacters(in: charSet)
print(trimmed) // "A p p l e"
```

`trimmingCharacters(in:)` 함수는 `characterSet에 포함되는 문자를 삭제`하는 기능을 합니다. ing이기 때문에 원본을 변경하지 않고 새로운 문자열을 리턴합니다. 공백을 제거한 후 출력하니 양 끝의 공백이 제거되었습니다. 문자 사이사이의 공백은 제거되지 않고, 양 끝의 불필요한 공백이 제거됩니다.

특정 characterSet을 `편집`할 수 있습니다.

```swift
var editTarget = CharacterSet.uppercaseLetters // 대문자들로 이루어진 문자 집합
editTarget.insert("#") // 문자 # 하나 추가 
editTarget.insert(charactersIn: "~!@") // 문자 ~,!,@ 세 개 추가
editTarget.remove("A") // 문자 A 하나 제거
editTarget.remove(charactersIn: "BCD") // 문자 B,C,D 세 개 제거
```

`사용자가 직접 정의`할 수 있습니다. (custom characterSet)

```swift
let custom = CharacterSet(charactersIn: "@.") // @와 . 두개로 이루어진 문자 집합

// 활용 : 각 문자를 기준으로 이메일 분리
let email = "userId@example.com"
let components = email.components(separatedBy: custom) // ["userId", "example", "com"] 
```