# Tuples

# 1. Tuples

`Compound type`의 자료형입니다. 하나 변수에 두 개 이상의 값을 저장하는 것입니다.

```swift
(expr1, expr2, ...)
```

각 하나하나를 tuple member라고 하며, 새로운 멤버를 저장하거나 삭제하는 것은 불가능합니다. 튜플에 저장되는 멤버의 수는 튜플을 만들 때 결정되고, 이후 멤버의 수를 변경할 수 없습니다. 

하지만 `멤버의 값`을 바꾸는 것은 가능합니다.

튜플의 멤버에 접근할 때에는 `점문법`을 사용합니다.

```swift
let data = ("<html>", 200, "OK", 12.34)
data.0 // <html>
data.1 // 200
data.2 // OK
data.3 // 12.34
```

# 2. Named Tuples

```swift
(name1: expr1, name: expr2, ...)
```

튜플의 멤버에 이름을 붙여주면 각 튜플 멤버가 어떤것을 나타내는지 알 수 있어 `가독성`이 높아집니다.

```swift
let named = (body: "<html>", statusCode: 200, statusMsg: "OK", dataSize: 12.34)
named.0 // <html>
named.body // <html>
```

# 3. Tuple Decomposition

튜플 멤버를 각각 개별 변수/상수에 저장하는 문법입니다.

```swift
let (name1, name2, ...) = tupleName
// 이 때 name의 수는 tuple의 멤버의 수와 일치해야 합니다.
```

예시를 살펴보겠습니다.

```swift
let data = ("<html>", 200, "OK", 12.34)

// let body = data.0
// let code = data.1
// let msg = data.2
// let size = data.3
// 각각 저장해주어도 되지만 매우 번거로운 방법입니다. 

let (body, code, msg, size) = data

// 분해하고싶지 않은 멤버가 있을 경우 와일드 카드를 사용합니다.
let (body, code, msg, _) = data
```

# 4. Tuple Matching

switch문은 `tuple matching`을 허용합니다. 

```swift
case (tupel, tuple): // 스위치문의 케이스에서 튜플과 비교가 가능합니다.
case (1...100, 200): // 튜플 내에서의 인터벌 매칭도 가능합니다.
case (_, 1080): // 앞의 숫자는 신경쓰지 않고 다음 튜플멤버만 비교합니다.
case let(a, b) where a/b == 1.0/2.0: // value binding을 사용할 수 있습니다.
```

if문으로 조건을 확인해도 되지만 스위치문을 사용할 경우 더욱 코드가 단순해집니다.

`interval matching`, `wild card pattern`, `value binding`을 자유롭게 조합할 수 있습니다.