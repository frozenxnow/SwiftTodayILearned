# Optionals

# 1. Optionals

옵셔널이란 값을 갖지 않는다는 의미입니다. `nil` 은 swift에서 값이 없음을 표현합니다. 

값을 저장하지 않고 변수나 상수를 선언할 때 컴파일러는 값을 추론할 수 없기 때문에 에러가 발생합니다. 

이를 위해 `Type annotation`이 필요하고, 이 때 값이 없을수도 있을 경우 Type 뒤에 `?` 를 붙입니다.

```swift
let a: String?
var b: Int?
```

위에서 선언한 a와 b에는 값이 있을수도, 없을수도 있습니다. 

### Unwrapping

옵셔널타입에 저장된 값을 추출하는 것을 의미합니다. 값이 있다면 제대로 추출되겠지만, nil이 강제로 추출된다면 컴파일러에서는 에러가 발생합니다. Optional의 표현식을 언래핑하면 Non-Optional 형태의 값으로 리턴됩니다.

# 2. Optional Binding

```swift
if let ~ else { }
while let ~ else { }
guard let ~ else { }
```

옵셔널을 안전하게 추출하기 위해 nil 값이 아닌지 확인한 후 추출한 값을 바인딩하는 문법입니다. 

`,` 로 나열하여 한번에 바인딩 하는 것도 가능합니다. 

# 3. Implicitly Unwrapped Optionals(IUO)

암시적(자동)추출입니다. 특정 조건에서 자동으로 추출되는 것이며, `!` 가 붙어있으면 자동으로 추출된다는 것을 기억해주세요. 자주 사용하지는 않지만, outlet을 연결할 때, API에서 UIO를 리턴할 때 사용됩니다.

# 4. Nil-Colaescing Operation

nil 병합연산자입니다. 아래와 같이 표현하며

```swift
OptionalExpression ?? Expression
```

왼쪽은 옵셔널 값입니다. 옵셔널 안에 값이 있다면 값을 반환하고, 없다면 오른쪽 값을 반환합니다. 이때 양쪽 모두 같은 타입이어야 합니다.