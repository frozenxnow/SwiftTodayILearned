# Operators

Swift가 제공하는 다양한 연산자를 활용해서 값을 계산하고 결과를 얻는 방법에 대해 공부합니다.

---

# 1. Operator Basics

1. 단항연산자 : `+a`, `-b`와 같이 양수와 음수를 표현합니다. 문자 사이 공백이 없어야합니다. 
2. 이항연산자 : 연산자 양 옆에 공백을 추가해주는 것이 좋습니다.
3. 삼항연산자 : `a ? b : c` 마찬가지로 공백을 추가해주는 것이 좋습니다.
4. `+a` Prefix Operator
5. `a+` Postfix Operator
6. `a+b` Infix Operator

# 2. Arithmetic Operator

1. 단항연산자에서 `-`는 값의 부호를 바꾸어줍니다.
2. 단항연산자에서 `+`는 아무 의미 없습니다.
3. `%` 연산자는 정수형에서 사용 가능합니다.

# 3. Overflow Operator

+, -, * 에서 사용이 가능하며, 각 부호 앞에 &문자를 공백 없이 붙여줍니다.

```swift
a &+ b
c &- d
e &* f

let a: Int8 = Int8.max // 127
a &+ 1 = -128

let b: Int8 = Int8.min // -128
b &- 1 = 127
```

연산의 결과로는 순환하는 값이 나옵니다. ( Int8의 범위 : -128 ~ 127 )

# 4. Comparison Operation

비교연산자는 모두 이항연산자이며, 결과값은 Bool Type입니다.

```swift
==, !=, >, >=, <, <=
```

# 5. Logical Operators

1. Logical NOT Operator
논리부정연산자의 피연산자는 Bool Type이며, 피연산자 앞에 `!` 부호를 붙여줌으로써 Bool 값을 변경합니다.
2. Logical AND Operator
`a && b` 형태로 작성하며, a와 b가 모두 true일 때 true를 반환합니다. 
3. Logical OR Operator
`a || b` 형태로 작성하며, a와 b 둘 중 하나라도 true일 때 true를 반환합니다.

# 6. Ternary Conditional Operator

 `a ? b : c`  a의 연산 결과 자료형은 Bool Type이어야 하며, true일 때 b, false일 때 c가 리턴됩니다. b와 c의 자료형은 같아야합니다. 중첩하여 사용할 수 있지만, 중첩하게될 경우 코드가 복잡해져 가독성이 떨어집니다. if 혹은 switch를 사용하는 것이 좋습니다.

# 7. Short-circuit Evaluation, Side Effect

연산의 방향은 왼쪽에서 오른쪽입니다. 논리연산자 AND와 OR에서의 예를 들어보겠습니다.

```swift
(5<1) && (1<5) // EX1
(3>1) || (3>9) // EX2
```

EX1의 경우 첫 피연산자는 false, 그 다음 논리연산자는 &&로 두번째 피연산자의 결과에 관계 없이 전체 문장이 false가 됩니다. 두번째 피연산자는 연산될 필요가 없어 컴파일러가 논리연산자 이후로 결과값을 계산하지 않습니다.

EX2의 경우 마찬가지로 첫 피연산자는 true, 논리연산자는 ||이므로 두번째 피연산자의 결과에 관계 없이 전체 문장이 true가 됩니다. 두번째 피연산자는 연산될 필요가 없어 컴파일러가 논리연산자 이후로 결과값을 계산하지 않습니다.

이를 Short-circuit Evaluation, 단락평가라고 합니다. 

Side Effect는 이 때 발견됩니다. 부작용이라는 뜻을 가지고 있지만 Swift에서는 부정적인 의미로 사용되지 않습니다. 값이 변경됨을 의미합니다. 값이 의도와 다르게 변경될 경우 이후 코드 작성시 오류가 생길 수 있기 때문에 논리식을 작성할 때에는 Side Effect가 일어나지 않도록 주의해야 합니다.

# 8. Bitwise Operators

```swift
~, &, |, ^, <<, >>, 
```

비트연산자의 사용 빈도는 낮기 때문에 설명은 생략하도록 하겠습니다.

`^`만 작성하겠습니다. `^`는 두 비트의 각 자리수를 비교해 값이 같으면 0, 값이 다르면 1을 반환합니다.

# 9. Assignment Operator

`할당연산자`는 값을 리턴하지 않습니다. 

```swift
+=, -=, *=, /=, %=
```

위의 복합연산자는 왼쪽 값과 오른쪽 값을 연산해 왼쪽의 값에 할당하는 연산자입니다.

# 10. Range Operator

Swift에서는 범위를 표현하는 색다른 방법이 있습니다. 

### 1) Closed Range Operator

`a...b` a 이상, b 이하 : a와 b를 포함한 범위를 뜻합니다.

`...a` a 이하 / `a...` a 이상 : 이 범위를 사용할 때 무한루프를 조심해야합니다. 

`(10...1).reversed()`를 사용하면 1 이상 10 이하의 범위가 됩니다. 내림차순 범위를 다시 뒤집는 메서드입니다.

### 2) Half-Open Range Operator

`a..<b` a 이상, b 미만 : a는 포함하되 b는 포함하지 않는 범위를 뜻합니다. 

`..<a` a 미만 : a를 포함하지 않는 범위를 뜻합니다. 이 또한 무한루프를 주의해야하며, postfix로만 사용 가능합니다. 

# 11. Operator Method

이미 존재하는 메서드와 같은 이름으로 정의가 되었지만 다른 피연산자를 처리할 수 있도록 하기 위해 메서드를 `오버로딩`하는 것입니다.

```swift
struct Point {
    var x = 0.0
    var y = 0.0
}
let p1 = Point(x: 12, y: 34)
let p2 = Point(x: 67, y: 89)

p1 == p2 // error
```

예시로 확인하겠습니다. `==` 연산자의 기존 기능을 떠올려보면 Point 의 객체끼리의 값을 비교할 수 없는 연산자입니다. 비교할 수 없는 값끼리 비교를 시도해 error가 발생합니다.

이제 이 `==` 연산자를 Point 구조체의 인스턴스끼리 값을 비교할 수 있도록  오버로딩하겠습니다.

```swift
extension Point: Equatable {
    static func == (lhs: Point, rhs: Point) -> Bool {
        return (lhs.x == rhs.x) && (lhs.y == rhs.y)
    }
}
```

`extension` 을 사용해 기존 Equatable의 기능을 `확장`했습니다. 

함수를 살펴보면 파라미터로 Point Type의 값을 받아 각 x와 y를 비교하여 Bool Type을 리턴하는 형태입니다.

기존 Equatable의 경우 또한 Bool Type을 리턴하는 함수였습니다. 

위의 예시에서는 해당 규칙을 모두 지키고 있습니다. 

여기에서 메서드를 확장(오버로딩)할 때 지켜야하는 규칙이 있습니다

1. 연산자가 가지고 있는 기존의 우선순위와 결합규칙을 바꾸지 않는다.
2. 가능한 원래 기능과 동일하거나 유사한 기능을 구현해야 한다.
3. 이미 존재하는 연산자의 파라미터와 리턴 타입을 일치시켜야 한다.

오버로딩한 Equatable 연산자로 p1과 p2를 비교했을 때 이는 올바르게 실행됩니다.

```swift
p1 == p2 // false
p1 != p2 // true
```

- 메소드 선언시 `prefix`, `postfix` 라는 키워드를 앞에 붙여 구현하면 단항연산자에 대한 오버로딩도 가능합니다.
- `inout` : 함수가 호출되었을 때 값으로 전달받은 인자가 파라미터에 복사되고, 함수가 반환될 때 함수 내에서 변경된 값이 본래의 값에 할당됩니다. `(copy-in , copy-out)`

# 12. Custom Operators

사용자 정의 연산자를 구현할 수 있습니다. 기존에 없는 메서드를 새로 생성하는 것입니다. 

타입에 대한 확장 개념이라고 생각하겠습니다.

연산자의 이름을 정의하기 전 아래 키워드를 가지고 피연산자와의 위치 관계를 명시해주어야 합니다.

```swift
prefix operator ~~, postfix operator ~~, inout operator ~~ 
```

~~ 위치에는 연산자 기호를 작성하면 되고, 전치 연산자와 후치 연산자의 경우 아주 간단합니다.

```swift
prefix operator +++

extension Int {
		static prefix func +++(num: inout Int) {
				num += 2 
		}
}

prefix operator ---

extension Int {
		static prefix func ---(num: inout Int) {
				num -= 2 
		}
}
```

Custom Infix Operator는 우선순위 정의가 필요합니다. 따로 정의하지 않을 경우 DefaultPrecedence 그룹에 포함되며, 다른 연산자들과 함께 사용될 경우 에러가 발생합니다. 

```swift
infix operator *+* : MultiplicationPrecedence

extension Int {
    static func *+*(left: Int, right: Int) -> Int {
        return (left*right) + (left*right)
    }
}
```

기존의 우선순위를 알고 있으면 첫줄 옆에 해당 순위의 이름을 적어주면 되는데, 새로운 우선순위 그룹을 생성할 수 있습니다.

```swift
precedencegroup Name {
	higherThan:
	lowerThan:
	asscociativity:
}
```

`Name` 이라는 우선순위 그룹보다 낮은 그룹명을 `higherThan`, 높은 그룹명을 `lowerThan`에 입력해줍니다. 

`asscociativity`에는 해당 우선순위 그룹의 결합 규칙에 대해 정의합니다. `left`, `right`, `none` 중 하나를 지정합니다. 

세 필드는 모두 생략 가능하지만 기준이 되는 `higherThan`, `lowerThan` 중 하나는 반드시 입력해야합니다.