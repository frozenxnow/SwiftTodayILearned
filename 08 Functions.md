# Functions

# 1.Functions

함수의 장점은 Reusability(재사용성)입니다. 함수는 선언(defining)하고, 호출(calling)하는 방법을 알고 있어야합니다.

```swift
// 함수 호출
func name(params)

// 함수 선언
func name(params) -> returnType {
	statements
	return expression
}
```

# 2. Return Values

함수를 정의할 때에는 `returnType`을 명시해주어야합니다. 그리고 `return문`이 반드시 있어야 합니다.

`return`은 함수를 종료하고, 결과 값을 도출하는 역할을 합니다.

# 3. Parameters

```swift
(name: Type, name: Type)
```

함수 내부에서 사용하는 임시상수를 뜻합니다. 

```swift
functionName(paramName: expr) // 함수 호출

func functionName(paramName: Type = "defaul value") -> returnType {
	statements
	return expression
} // 기본값을 지정할 경우 위와 같이 선언합니다
```

# 4. Argument Label

파라미터에 레이블을 추가합니다.

```swift
(name: Type)
// ParameterName: name
// ArgumentLabel: name

(label name: Type)
// ParameterName: name
// ArgumentLabel: label
```

- `함수 body에서` 파라미터에 접근할 땐 `parameterName으로 접근`하고,
`함수를 호출`할 때에는 `argumentLabel을 사용`합니다.
- argumentLabel에 wildcard(언더바)를 입력할 경우 함수 호출시 `argumentLabel을 생략`할 수 있습니다.

# 5. Variadic Parameters : 가변 파라미터

가변 파라미터로 선언되었을 경우 `하나 이상의 argument를 전달`할 수 있습니다. 전달 가능한 argument가 고정되어 있지 않아 가변 파라미터라고 칭합니다. 함수당 한개만 가질 수 있으며 기본값을 가질 수 없습니다.

대표적으로 `print` 함수가 있습니다.

```swift
(name: Type...) // 선언

print(text: String...)
print("Hello", "Swift")
// argument *2
// parameter *1
```

# 6. In-Out Parameters : 입출력 파라미터

기존 함수에서 parameter를 사용하는 방법을 `call by value`라고 한다면
inout parameter를 사용하는 방법은 `call by reference`라고 생각할 수 있겠습니다.

```swift
(name: inout Type)
```

- 3번에서 언급했듯, 함수 파라미터는 임시상수이기 때문에 원본의 값 변경이 불가능합니다. 그러나 `inout 파라미터로 선언`할 경우 원본의  값이 변경 가능합니다. (호출 시: 앞에 `&` 표시를 붙입니다.)
- 값이 변경되기 때문에 파라미터로 불변값(상수)를 사용할 수 없습니다.
- 메모리 공간을 가진 변수여야 메모리 주소에 대한 copy-out이 가능하기 때문에 리터럴을 직접 입력할 수 없습니다.
- 기본값 설정이 불가능합니다. 마찬가지로 메모리 공간이 없기 때문입니다.
- 가변 파라미터 또한 불가능합니다.

```swift
// 두 변수에 저장된 값을 서로 변경하기 
func swapInts(a: inout Int, b: inout Int) {
    let x = a
    a = b
    b = x
}

// 원본의 값이 변경되기 때문에 let으로 선언할 수 없습니다. 
var value1 = 12
var value2 = 34

// 변경되어야 하는 값이기 때문에 바로 리터럴을 넣을 수 없고 변수에 담아 사용합니다.
swapInts(a: &value1, b: &value2)
```

# 7. Function Notation : 함수 표기법

함수 표기법을 알아야 공식 문서를 이해할 수 있고, 함수 타입을 이해하고 호출 방법을 유추할 수 있습니다. 

```swift
functionName(label:)
functionName(label:label:)
functionName
// function() 괄호를 붙이면 함수를 호출하는 식이 됩니다
```

# 8. Function Types (first-class-citizen)

Swift에서는 값이 없다는 것을 void가 아닌 빈 괄호`()`로 표기합니다.

```swift
// 파라미터와 리턴 값이 없는 functionType
functionName() -> ()
```

 ** 함수 9~12 다시 한번 듣고 정리하기