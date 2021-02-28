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

Swift에서는 값이 없다는 것을 빈 괄호`()`로 표기합니다. 

```swift
// 파라미터와 리턴 값이 없는 functionType
functionName() -> ()
```

# 9. Nested Functions

함수에 포함된 즉, 내포된 함수를 의미합니다. 함수가 말 그대로 다른 함수 내부에 들어있는 경우인데, 이 경우에는 해당 함수를 호출할 수 있는 범위가 달라집니다. 

```swift
func outer() {
	print("outer")
}
func inner() {
	print("inner")
}

outer() // "outer"
inner() // "inner"
```

inner() 함수와 outer() 함수를 global scope에서 선언했을 때 이들은 global scope에서 호출이 가능합니다. 

```swift
func outer() {
	func inner() {
		print("inner")
	}
	print("outer")
	inner()
}

outer() // "outer" \n "inner"
// inner() error : 더이상 global scope에서 호출할 수 없다.
```

그러나 inner() 함수를 outer() 함수에 내포되도록 코드를 변경하면 inner() 함수는 더이상 global scope에서 호출이 불가능하고, outer() 함수 내부에서 호출이 가능해집니다.

함수를 리턴하는 outer() 함수를 선언하겠습니다.

```swift
func outer() -> () -> () {
	func inner() {
		print("inner")
	}
	print("outer")
	return inner
}

let f = outer() // inner
f() // inner() 호출
```

nested function을 리턴하면 이 함수를 사용할 수 있는 범위가 global scope로 확장됩니다. 직접 호출이 아닌 간접 호출입니다. outer() 함수를 상수에 저장하여 inner()를 호출해도 되지만, outer()()와 같은 방식으로도 호출이 가능합니다. 

# 10. Implicit Return

어떤 값을 리턴하는 함수에서의 표현식이 `단일표현식`일 경우 return 키워드를 생략할 수 있습니다.

```swift
func add (a: Int, b: Int) -> Int {
	/* return */ a + b
}

주석처리한 부분은 생략이 가능합니다. 
```

단일표현식일 경우에만 가능한 것입니다. 만약 함수 내부에 두 개 이상의 표현식이 구현되어 있다면 return 키워드를 반드시 작성해 어떤 값을 리턴하는 것인지 컴파일러에게 확실히 알려주어야합니다. 

`Impliccit Return`은 함수 뿐 아니라 값을 리턴하는 문법에서 동일하게 사용합니다. 

# 11. Nonreturning Functions

`return`에 대한 이해가 필요합니다.

return은 값을 리턴하는 의미와 동시에 현재 실행중인 함수를 종료합니다. 

또한 다음 함수로 제어를 전달하는 역할도 가지고 있기 때문에 전체 코드는 끊임없이 진행됩니다.

그렇다면 `Nonreturning`은 값을 리턴하지 않는다는 의미를 가지고 있으며, 또한 함수를 호출하는 코드 다음으로 제어를 전달하지 않습니다. Nonereturning Function을 실행할 경우 1) 함수 body에서 함수를 종료하거나 2) 에러를 처리하는 코드로 제어가 전달됩니다. 

```swift
func functionName() -> Never {
 // code
}
```

Never은 빈 열거형으로 선언되어 있고, 인스턴스를  생성할 수 없는 형식(Uninhabited Type)입니다. 

**1) 함수 body에서 함수를 종료하는 경우**

```swift
func functionName() -> Never {
	fatalError()
}
```

`fatalError()` 는 즉시 프로그램 실행을 중지하는 대표적인 함수로 주로 디버깅 용도로 사용합니다. 매개변수로 문자열을 전달해 콘솔에 출력할 수 있고, functionName()의 함수를 호출한 후의 메서드는 아무것도 실행되지 않습니다. 

**2) 에러를 처리하는 코드로 제어를 전달하는 경우**

```swift
enum Myerror: Error {
    case error
}

func doSomethingAndAlwaysThrow() throws -> Never {
    throw Myerror.error  // 항상 error를 던지는 함수
}

do {
    try doSomethingAndAlwaysThrow() // error를 던지기 때문에
    print("after try") // 이 함수는 항상 실행되지 않습니다
} catch {
    print(error) // 콘솔에 출력되는 내용
}

// 콘솔 결과 : error
```

항상 error를 던지는 doSomethingAndAlwaysThrow()로인해 do 블럭에서는 해당 함수를 실행한 후 (print()함수는 실행하지 않고) 블록을 빠져나와 catch 블록을 실행합니다.

```swift
func terminate() -> Never {
    fatalError("positive only") // 프로그램을 중지 시키고 콘솔에 error: positive only 출력
~~}~~

func doSomething(with value: Int) -> Int {
    guard value >= 0 else {
        terminate() // 매개변수가 음수일 경우 terminate() 실행
    }
    return 0
}

doSomething(with: -1) // 음수이기 때문에 terminate()에 의해 프로그램 종료
```

doSomething의 매개변수로 음수를 받을 경우 guard문의 else 블록이 실행됩니다. 

guard문은 함수를 중지하는 메서드를 가지고 있어야 하는데, fitalError()문을 실행하는 nonreturning function인 `terminate()` 함수 자체가 프로그램을 종료하는 함수이기 때문에 guard문을 중지하는 제어문 역할을 하고있습니다. 

 `Void`와의 차이점을 살펴보겠습니다.

Void도 마찬가지로 리턴이 없다는것을 의미하지만 흐름을 제어하는 문장이 아니기 때문에, terminate() 함수를 호출했을 때 프로그램이 종료된다는 보장이 없습니다. 따라서 위의 guard문에서는 'throw이나 return이 없다'는 내용의 컴파일 에러가 발생합니다.