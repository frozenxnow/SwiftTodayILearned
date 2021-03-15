# Error Handling

# 1. Error Handling

에러를 미리 파악하면 프로그램이 비정상적으로 종료되지 않도록 조치를 취할 수 있습니다. 에러의 종류에는 두가지가 있습니다. 

- 컴파일 에러 : 주로 문법적인 에러입니다. 고치기 쉬운 편입니다.
- 런타임 에러 : 주로 실행 시 발생하며 강제종료됩니다. 런타임 에러를 처리하는 코드를 작성하면 강제종료되는 횟수를 줄일 수 있습니다.

```jsx
// 함수를 던지는 표현 
throw expression

// 함수 : Throwing function/method
func name(parameters) throws -> ReturnType {
		statements
}

// 생성자 : Throwing initializer
init(parameters) throws {
		statements
}

// 클로저 : Throwing closure
{ (parameters) throws -> ReturnType in
		statements
}
```

`throw` / `throws` 비교 

throw : 함수를 던진다
throws : (이 함수, 생성자, 클로저가) 함수를 던질 수 있다

throw문은 return문과 마찬가지로 코드 블록의 실행을 중지합니다. 이후의 실행문은 작동하지 않습니다. 

## try Statements

```jsx
try expression // do-catch문과 함께 사용됩니다. 
try? expression // optional try : nil을 리턴합니다.
try! expression // forced try : runtime error가 발생합니다. 
```

expression에는 주로 throwing function, throwing method, throwing initializer, throwing closure를 호출하는 코드가 옵니다. 

에러를 처리하는 방법에는 세가지가 있습니다.

1. do-catch문을 사용합니다.
2. try 표현식과 optional binding을 사용합니다.
3. hand over(에러를 전달받아 다른 코드로 전달)합니다. 

# 2. do - catch Statements

```jsx
do {
		try expression
		statements
} catch pattern { // 까다로운 패턴일수록 먼저 작성합니다. 
		statements
} catch pattern where condition {
		statements
}
```

- do block : 필수 블록입니다. 에러가 발생할 수 있는 코드를 실행합니다. 
try 표현식에서 에러가 발생하면 이후의 코드는 실행되지 않고 catch block으로 넘어갑니다.
- catch block : do block에서 발생하는 에러를 처리합니다. 몇 가지 패턴을 정해 처리할 수 있고, 패턴을 생락하고 모든 에러를 처리할 수도 있습니다. where절을 통해 조건을 추가할 수 있습니다. 
catch block에서는 모든 에러를 처리할 수 있어야합니다. 그렇지 않으면 다른 코드로 에러를 전달하도록 구현해야합니다.

```jsx
func handleError() {
    do {
        try parsing(data: ["name":""])
    } catch DataParsingError.invalidType {
        print("invalid type error")
    }
}
```

이 메소드는 오류가 발생합니다. 개선하는 방법은 두 가지입니다.

1. handleError() 함수를 throwing method로 작성합니다. 함수 실행시 에러가 발생하면 이 함수를 호출한 코드로 에러를 전달합니다. 

    ```jsx
    func handleError() **throws** {
        do {
            try parsing(data: ["name":""])
        } catch DataParsingError.invalidType {
            print("invalid type error")
        }
    }
    ```

2. handleError() 함수 안에 있는 do-catch문에서 모든 에러를 처리할 수 있는 catch 블록을 작성합니다.

    ```jsx
    func handleError() {
        do {
            try parsing(data: ["name":""])
        } catch DataParsingError.invalidType {
            print("invalid type error")
        } **catch {
    				print("추가된 catch block")
    		}**
    }
    ```

3. catch block이 없는 throwing method로도 작성이 가능합니다. 이 때는 do block도 삭제 가능합니다. 이 함수는 무조건 에러를 발생하는 함수가 됩니다. 

    ```jsx
    func handleError() **throws** {
        try parsing(data: ["name":""])
    }
    ```

do-catch 문은 일반적으로 do 블럭에서 발생할 수 있는 모든 에러를 catch 블럭에서 처리해야합니다. 

처리되지 않은 에러가 있을 경우 다른 코드로 전파될 수 있도록 해야합니다. 

pattern이 없는 catch 블럭을 살펴보겠습니다.

```jsx
func handleError() {
    do {
        try parsing(data: ["name":""])
    } catch {
        if let **error** = **error** as? DataParsingError {
            switch **error** {
            case .invalidType:
                print("invalid type")
            default:
                print("handle error")
            }
        }
    }
}
```

패턴이 없는 catch 블럭에서는 `error`라는 특별한 로컬상수가 제공되며, 이 형식으로 에러를 전달합니다. 이것은 에러 프로토콜이기 때문에 타입캐스팅이 필요합니다. 주로 switch문을 사용해 위와 같이 사용합니다.