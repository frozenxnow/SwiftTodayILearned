# Collection

# 1. Collection Overview

Array(순서가 있는 배열) / Dictionary(key-value) / Set(집합)

전반적인 Collection에 대한 내용과 Foundation Collection vs Swift Collection에 대한 내용입니다.

# 2. Array #1

- Ordered Collection : 순서가 있는 콜렉션입니다.
- Single Type : value는 중복이 가능합니다.
- 0-based Index : 인덱스는 자동으로 부여되며 0부터 시작됩니다. 중간 값이 사라지면 뒤에 있는 인덱스 값도 변경됩니다.
- 배열 값에 array[0], array[1] 이렇게 접근할 경우, 해당 요소(element)가 nil 상태라면 에러가 발생합니다. `Array.first, Array.last, Array.startIndex, Array.index(before: Array.endIndex)`와 같은 표현으로 접근하도록 합니다.

# 3. Array #2

배열에 요소를 추가, 삭제하는 함수입니다.

```swift
array.append("A") // 배열의 끝에 요소를 추가합니다.

array.append(contentsOf: ["F", "G"]) // 배열의 끝에 여러개의 요소를 추가합니다.

array.insert("T", 2) 
// 원하는 위치에 요소를 추가할 수 있으나 다른 배열들의 인덱스 값을 변경해야하므로 사용을 지양합니다.

array.replaceSubrange(1...2, ["X","Y"]) 
// 원하는 위치의 요소를 다른 요소로 변경합니다. 빈 배열 전달시 범위의 요소를 삭제합니다.

array.remove(at:0) // 해당 위치의 요소 삭제 : 존재하지 않을 경우 에러가 발생합니다.
array.removeAll() // 모든 배열 삭제

array.popLast()
// 마지막 요소를 삭제한 후 배열의 마지막 요소를 리턴합니다. 
// 빈 배열일 경우 nil을 리턴하기 때문에 에러가 발생하지 않습니다. 
```

# 4. Array #3

배열을 정렬하는 함수입니다.

```swift
array.sort() // 원본 배열을 직접 정리합니다. 
array.sorted() // 정렬된 새로운 배열을 리터합니다.

array.swapAt(0,1) // 인덱스 0,1에 위치한 값을 서로 변경합니다.

array.shuffle() // 랜덤으로 순서를 섞어줍니다.
```

# 5. Dictionary #1

```swift
var dic: Dictionary<K,V> = [key: value, key: value, key: value, ...]

let dic1: Dictionary<String, Int>
let dic2: [String:Int]
let dic3 = ["A":"a", "B":"b"]

// 빈 Dictionary 생성
let empty1: [String:Int] = [:] // 비어있기 때문에 형식을 추론할 수 없어 타입을 작성해주어야 합니다.
let empty2 = [String:Int]()
let empty3 = Dictionary<String,Int>()
```

- unrecorded collection : 정렬되지 않은 collection입니다.
- Single type : 각 요소의 key는 중복될 수 없고, value는 중복이 가능합니다.
- value에는 반드시 key를 통해 접근해야합니다.
- dic에 없는 key를 사용해 value를 꺼내면 `nil`이 리턴됩니다. (Optional)
- `dic.count`로 요소의 수를 확인할 수 있고 `dic.isEmpty`로 빈 Dictionary인지 확인할 수 있습니다.

```swift
let dic = ["A":"a", "B":"b"]
dic["A"] // "a" , Optional<String> 타입
dic["C"] // nil , Optional<String> 타입
dic["D", default: "Empty"] // "Empty", String 타입 (value가 있어도, 없어도 문자열 리턴)
```

- 존재하지 않는 key로 value를 호출할 경우 nil이 리턴되는 것을 확인할 수 있습니다. 
이 때 nil 대신 리턴될 값을 `default`를 사용해 미리 정할 수 있습니다.
default가 문자열로 리턴될 경우, key가 존재해 값을 리턴해도 String이고 nil 대신 Empty가 리턴되어도 String타입입니다. 
따라서 `dic["D", default:"~"]는 String타입`입니다.

```swift
let dic = ["A":"a", "B":"b"]

for k in dic.keys {
    print(k)
} // 각 key가 무작위로 출력됩니다.

for v in dic.values {
    print(v)
} // 각 value가 무작위로 출력됩니다.

var arrKeys = Array(dic.keys) // 각 key가 무작위로 배열로 생성됩니다.
var arrValues = Array(dic.values) // 각 value가 무작위로 배열로 생성됩니다.
```

- `dic.keys, dic.values`는 collection의 형태이므로 `for-in`문에서 사용이 가능합니다.
- 배열로 전달하여 각 keys, values로 배열을 생성할 수 있습니다.

# 6. Dictionary #2

요소를 insert, update, remove하는 함수를 알아보겠습니다.

```swift
dic[key] = value // upsert = insert + update 함수
// 존재하는 key일 경우 : 기존의 value를 새로운 value로 변경합니다. (update)
// 존재하지 않는 key일 경우 : 해당 key와 value를 새로운 요소로 추가합니다. (insert)

dic[key] = nil // 요소를 삭제합니다.
dic.removeValue[forkey: key] // 요소를 삭제합니다.
removeAll() // 전체 요소를 삭제합니다.
```

# 7. Dictionary #3

- Dictionary를 비교할 때에는 key-value가 모두 일치할 경우 같다고 판단합니다. 물론 대소문자를 구분합니다.
- 대소문자 구분 없이 비교하기 위해서는 Dictionary를 먼저 `정렬(sort)`하고 key를 기준으로 각 value를 `비교(elementEqual)`해야합니다. Dictionary는 정렬되지 않은 Collection이기 때문에 반드시 정렬을 먼저 해야합니다.

**Finding element(검색) 메서드**를 알아보겠습니다.

```swift
var words = ["A": "Apple", "B": "Banana", "C": "City"]
// 검색에는 클로저가 필요하기 때문에 별도의 상수에 클로저를 저장하겠습니다.
// (key,value) 튜플을 파라미터로 받아 Bool을 리턴하는 클로저를 생성합니다.

let c = ((String, String)) -> Bool = {
	$0.0 == "B" || $0.1.contains("i")
} // key 값이 "B" 이거나, value 값에 "i"가 포함되어있을 경우 True return
```

## 1) contains(where:)

```swift
words.contains(where: c) // true return
```

## 2) first(where:)

```swift
let r = words.first(where: c) // 검색된 요소를 tuple로 리턴
r?.key // B 혹은 C 
r?.value // Banana 혹은 City
```

검색을 실행할 때마다 값이 B:Banana, C:City 둘 중 하나로 변경됩니다. Dictionary는 `정렬되지 않은 형태`이므로 어떤것이 먼저 저장 되었는지 알 수 없기 때문입니다.

## 3) filter(closure)

```swift
words.filter(c) // 검색에서 true return한 key,value로 새로운 dictionary를 생성해서 반환합니다.
```