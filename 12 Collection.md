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

# 8. Set #1

'집합'의 개념입니다. 중복된 값을 저장할 수 없고, 요소의 유일성을 판단하고, 검색 속도가 빠르기 때문에 검색 속도가 중요한 경우 사용합니다. 엘리먼트의 각 값이 요소가 됩니다. 

```swift
let set: Set<Int> = [1, 2, 5, 4, 2, 1] // 중복 값은 한번만 저장되고 {1,2,4,5}이 생성됩니다.
```

위에서 Set의 자료형은 추론이 가능하기 때문에 <Int>는 생략이 가능합니다. 

- Single type
- Single Unique Value
- Unordered  Collection
- `insert("~")`, `update(with:"~")`, `remove("~")`, `removeAll()` 메서드를 사용할 수 있습니다. 
update(with:)의 경우 존재하는 값이라면 아무 일도 일어나지 않고, 존재하지 않는 값이 입력되면 set에 새로운 값이 저장됩니다.

# 9. Set #2

비교 연산자를 살펴보겠습니다.

```swift
var set1: Set = [1,3,5,3,1]
var set2: Set = [5,5,5,3,1]

set1 == set2 // true
set1.elementsEqual(set2) // false
```

- ==, != 연산자의 경우 Set은 정렬되지 않은 자료구조이기 때문에 요소의 존재만 확인하여 비교합니다.
- `.elementsEqual`을 사용하면 false가 리턴되는 이유는 값을 순서대로 비교하기 때문입니다. 
이 함수를 사용해 비교하기 위해서는 순서값을 가진 배열로 정렬이 필요합니다.

**집합과 관련된 메서드**를 살펴보겠습니다.

```swift
a.isSubset(of: b) // 부분집합 확인
a.isStrictSubset(of: b) // 진부분집합 확인

a.isSuperset(of: b) // 상위집합 확인
a.isStrictSuperset(of: b) // 진상위집합 확인

a.isDisjoint(with: b) // 교집합이 존재하는지 확인 (true:교집합 존재, false: 서로소)
```

**집합의 연산**도 가능합니다.

```swift
a.union(b) // 합집합 : 새로운 set으로 리턴
a.formUnion(b) // 합집합 : 연산 후 a에 저장

a.intersection(b) // 교집합 : 새로운 set으로 리턴
a.formIntersection(b) // 교집합 : 연산 후 a에 저장

a.symmetricDifference(b) // 여집합 : 새로운 set으로 리턴
a.formSymmetricDifference(b) // 여집합 : 연산 후 a에 저장

a.subtracting(b) // 차집합 : 새로운 set으로 리턴 (a-b)
a.subtract(b) // 차집합 : 연산 후 a에 저장 (a-b)
```

원본을 변경하는 메서드의 접두어는 대부분 `form`입니다. 차집합에서 원본을 저장하는 차집합 연산 메서드는 예외이기 때문에 잘 기억해두어야 합니다. 

# 10. Iterating Collections

## 1) for-in 반복문

```swift
for element in collection {
	statements
}
```

- collection 위치에 `Array`가 오는 경우 : 배열의 수만큼 순서대로 반복
- collection 위치에 `Set`이 오는 경우 : 배열의 수만큼 랜덤순서로 반복, 실행할 때마다 그 순서도 변경
- collection 위치에 `Dictionary`가 오는 경우: element 위치에 (key, value)가 튜플 형태로 입력되어 랜덤 순서로 반복

## 2) forEach

함수형 패러다임으로 코드 작성시 자주 사용하며, 반복적으로 실행하는 코드를 클로저 형태로 작성해 `클로저를 파라미터로` 받습니다. 이 클로저는 하나의 파라미터를 가지고 있고 값을 리턴하지 않습니다. collection에 저장된 `요소가 클로저의 파라미터`가 됩니다. 

```swift
// Array
let arr = [1, 2, 3]
arr.forEach { (num) in
    print(num)
} // 순서대로 1, 2, 3 출력

// Set
let set: Set = [1, 3, 5]
set.forEach { (num) in
    print(num)
} // 1, 3, 5가 랜덤 순서로 한번씩 출력

// Dictionary
let dict: Dictionary<String, String> = ["A":"Apple", "B":"Banana"]
dict.forEach { (elem) in
    print("\(elem.key), \(elem.value)")
} // "A, Apple", "B, Banana"가 랜덤 순서로 한번씩 출력 
```

dictionary를 사용할 경우 for-in 반복문에서처럼 요소가 튜플로 전달됩니다. 

## 3) for-in, forEach 차이점

- for-in문은 반복문입니다. 따라서 continue, return을 사용할 수 있습니다. return 키워드를 사용할 경우 반복문 전체가 종료되기 때문에 반복 함수가 전체 중지됩니다.
- forEach문은 반복문이 아니기 때문에 continue, return을 사용할 수 없습니다. return 키워드를 사용할 경우 return을 내부에 가지고 있는 클로저의 실행만 중지되고, 따라서 함수 실행에 영향을 주지 않아 전체 반복 횟수에 영향을 주지 않습니다.

```swift
func withForIn() {
    let arr = [1,2,3]
    for num in arr {
        print(num)
        return
    }
}
// 1 출력 후 return에 의해 반복함수 종료 

func withForEach() {
    let arr = [1,2,3]
    arr.forEach { (num) in
        print(num)
        return // 현재 실행하는 클로저에 영향, 반복 횟수에는 영향을 주지 않는다
    }
}
**/**/ 1
// 2
// 3 출력 후 종료 
```

# 11. KeyValuePairs

swift에서 제공하는 경량 collection입니다. dictionary와 비슷하지만 array와 유사한 특징도 가지고 있습니다.

```swift
let pairs: KeyValuePairs<String, Int>
```

마찬가지로 Key와 Value의 타입이 추론 가능하다면 `<keyType, valueType>`은 생략이 가능합니다. 

- KeyValuePairs는 dictionary와 마찬가지로 key, value값을 저장합니다. 
타입 어노테이션을 작성하지 않을 경우 컴파일러는 Dictionary 타입으로 인식하기 때문에 반드시 타입을 명시적으로 선언해야 합니다.
- Array처럼 순서를 기억하는 collection입니다.
- 기존의 Dictionary와 달리 key 형식에 제한이 없습니다. 동일한 key를 여러번 사용할 수 있습니다.

```swift
let words: KeyValuePairs<String, String> = ["A": "Apple", "B": "Banaba", "C": "City"]

words[0] // 순서대로 저장하기 때문에 index값으로 출력할 수 있습니다.
words[0].key // A
words[0].value // Apple

for elem in words {
    print(elem.key, elem.value)
}
// A Apple
// B Banaba
// C City
// 순서를 기억하는 collection이기 때문에 저장된 순서대로 출력됩니다. 
```

KeyValuePairs에서는 저장된 값을 변경하는 메서드가 존재하지 않습니다.

~~`append(), insert(), update(), replace(), remove()`~~

검색을 제외한 곳에서는 사용 빈도가 떨어지기 때문에, 파라미터로 전달하거나, 리턴값과 같은 임시데이터를 저장하는 경우가 아니면 잘 사용하지 않습니다. 대개 이 경우에도 Dictionary를 사용할 수 있기 때문에 KeyValuePairs를 사용해야하는 것은 아닙니다. 

1. 데이터를 key-value의 쌍으로 저장해야하고
2. 동일한 key를 여러번 저장해야하고
3. 동일한 순서로 처리해야 하고
4. 동일한 순서로 어떠한 실행을 반복해야할 경우

`KeyValuePairs`를 사용합니다.