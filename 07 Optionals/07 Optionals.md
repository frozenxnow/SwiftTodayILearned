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

# 5. Optional Chaining

체인처럼 옵셔널을 연달아 연결합니다. 중요한 특징은 이 두가지 입니다.

1. 옵셔널 체이닝의 결과는 항상 **옵셔널**입니다.
2. 옵셔널 체이닝에 포함된 표현식 중 하나라도 **nil**을 리턴한다면 이어지는 표현은 평가하지 않고 **nil**을 리턴합니다.

![Optionals%20c185e96c878a4b84adb190adb29c6eed/_2021-02-27__12.06.29.png](Optionals%20c185e96c878a4b84adb190adb29c6eed/_2021-02-27__12.06.29.png)

Conatcts, Person 구조체를 선언한 후 Person 객체를 생성했습니다. 

p는 Person 구조체로 생성된 인스턴스이고,

optionalP는 Person? 구조체로 선언된 인스턴스입니다.

각 인스턴스를 통해 address를 얻는 a, b, c를 선언했습니다.

이때 optionalP는 옵셔널이기 때문에 optionalP? 를 통해 contacts에 접근했습니다.

```swift
var p = Person(name: "James", email: "swift@example.com")
let a = p.contacts.address // "Seoul"
```

다른 언어에서처럼 p를 통해 contacts에 접근하고 이를 통해 address에 접근할 수 있습니다. 

이 때 a는 String 타입입니다.

```swift
var optionalP: Person? = Person(name: "James", email: "swift@example.com")
let b = optionalP?.contacts.address // "Seoul"
```

optionalP를 이용해 접근하기 위해서는 인스턴스명 뒤에 옵셔널을 표기해주어야 합니다. optionalP가 nil이 아니라면 contacts에 접근할 수 있습니다.

이 때 b는 Optional String 타입입니다.

```swift
optionalP = nil // nil
let c = optionalP?.contacts.address // nil
```

optionalP에 nil이 저장되었을 경우 contacts까지 넘어가지 않고 바로 nil을 리턴합니다.

이 때 c는 Oprional String 타입입니다.

a, b, c로 리턴되는 address의 최종 자료형은 **String 타입**입니다.

이를 구하는 전체 표현식 중 옵셔널 표현식이 포함이 있다면 **Optional String 타입**으로 리턴됩니다. 이를 옵셔널 체이닝이라고 합니다. 

**contacts의 타입을** `Contacts?`**로 바꾸었습니다.**

![Optionals%20c185e96c878a4b84adb190adb29c6eed/_2021-02-27__12.21.28.png](Optionals%20c185e96c878a4b84adb190adb29c6eed/_2021-02-27__12.21.28.png)

이때 a, b, c의 contacts는 모두 `contacts?`로 바꾸어주고, 모든 타입은 Optional String이 됩니다.

**address의 타입을** `String?`**으로 바꾸었습니다.**

![Optionals%20c185e96c878a4b84adb190adb29c6eed/_2021-02-27__12.24.37.png](Optionals%20c185e96c878a4b84adb190adb29c6eed/_2021-02-27__12.24.37.png)

address의 마지막에 optional 표기를 해주지 않아도 에러가 나지 않습니다. address를 통해 다른 인자에 접근하지 않기 때문입니다. 만약 address를 통해 또 다른 값에 접근을 해야한다면 address?라고 작성해주어야 합니다.

![Optionals%20c185e96c878a4b84adb190adb29c6eed/_2021-02-27__12.26.23.png](Optionals%20c185e96c878a4b84adb190adb29c6eed/_2021-02-27__12.26.23.png)

**Person 구조체에 새로운 method를 추가했습니다.** 

```swift
struct Person {
    var name: String
    var contacts: Contacts?
    
    init(name: String, email: String) {
        self.name = name
        contacts = Contacts(email: ["home":email], address: "Seoul")
    }
    
    func getContacts() -> Contacts? {
        return contacts
    }
}
```

`getContacts()`**메서드를 통해 contacts를 리턴하는 함수**입니다. 이를 통해 **address에 접근**하겠습니다.

![Optionals%20c185e96c878a4b84adb190adb29c6eed/_2021-02-27__12.30.07.png](Optionals%20c185e96c878a4b84adb190adb29c6eed/_2021-02-27__12.30.07.png)

contacts는 `Contacts?` 타입입니다. 메소드에서 리턴되는 값에 옵셔널 표기를 해주어야 하기 때문에 괄호 뒤에 물음표를 붙여줍니다. 

함수명과 괄호 사이에 물음표를 표기해야하는 경우도 물론 있습니다. 아주 드물지만 함수 자체가 옵셔널이라면 함수의 뒤, 괄호 앞에 물음표를 입력합니다. 아래와 같습니다.

![Optionals%20c185e96c878a4b84adb190adb29c6eed/_2021-02-27__12.35.03.png](Optionals%20c185e96c878a4b84adb190adb29c6eed/_2021-02-27__12.35.03.png)

**Contacts 구조체에 새로운 method를 추가했습니다.** 

```swift
struct Contacts {
    var email: [String: String]
    var address: String?
    
    func printAddress() {
        print(address ?? "no address")
    }
}
```

printAddress() 메소드를 통해 address 값을 출력하거나, nil일 경우 no address를 출력하는 함수를 작성했습니다.

![Optionals%20c185e96c878a4b84adb190adb29c6eed/_2021-02-27__12.39.52.png](Optionals%20c185e96c878a4b84adb190adb29c6eed/_2021-02-27__12.39.52.png)

printAddress()를 호출하기 위해서는 `p.getContacts().printAddress()`와 같이 접근해야 하며 이 때 address가 정상적으로 호출되었다면 (printAddress() 함수가 아무것도 리턴하지 않기 때문에) 상수 d의 자료형은 void 타입일 것이고 옵셔널 체이닝이 있으니 최종 자료형은 `Optional Void`입니다.

if문을 통해 실제로 메소드가 호출되었는지 확인하는 코드를 작성할 수 있습니다. 블록 내부의 코드들이 실행된다면 address가 콘솔에 바르게 출력되는 것이겠지요. 

나아가 optional binding과 wild card pattern을 통해 위의 if let _ 으로 시작하는 코드를 작성할 수 있습니다. printAddress()가 바르게 실행된다면 이를 바인딩 해야하는데 리턴값이 없는 void이기 때문에 와일드카드로 바인딩을 하는 문장입니다. 바인딩 성공 여부를 판단하여 바인딩에 성공한다면 블록 내부의 코드를 실행하는 것입니다.

**Contacts 구조체에 선언된 email을 [String:String]? 타입으로 변경했습니다.**

```swift
struct Contacts {
    var email: [String: String]?
    var address: String?
    
    func printAddress() {
        print(address ?? "no address")
    }
}
```

key를 통해 value를 받아 상수 e에 저장하는 문장입니다. 

![Optionals%20c185e96c878a4b84adb190adb29c6eed/_2021-02-27__12.55.25.png](Optionals%20c185e96c878a4b84adb190adb29c6eed/_2021-02-27__12.55.25.png)

이 때 email["home"]에서 물음표는 브라켓 앞에 위치해야 합니다.

상수 e의 자료형은 email의 value값인 String이며, 옵셔널 체이닝으로 인해 Optional String 타입입니다.

마찬가지로 subscript가 리턴하는 이 값을 통해 count 속성에 접근하기 위해서는 끝에 물음표를 붙여주어야 합니다. 

key를 통해 값을 구할 때에는 스퀘어브라켓 앞에 물음표를, 

그 값을 통해 또다른 속성에 접근할 때 혹은 메소드를 호출할 때에는 스퀘어브라켓 뒤에 물음표를 붙여주어야 합니다.

마지막으로 옵셔널 체이닝의 두번째 특징에 대해 알아보겠습니다.

옵셔널 체이닝에 포함된 표현식 중 하나라도 **nil**을 리턴한다면 이어지는 표현은 평가하지 않고 **nil**을 리턴합니다.

![Optionals%20c185e96c878a4b84adb190adb29c6eed/_2021-02-27__1.06.02.png](Optionals%20c185e96c878a4b84adb190adb29c6eed/_2021-02-27__1.06.02.png)

p 에는 값이 저장되어 있고 address에 접근이 가능하기 때문에 값을 변경할 수 있습니다.

optionalP는 nil이기 때문에 `optionalP?.` 에서 바로 nil이 리턴되어 뒤에 있는 문장이 실행되지 않습니다. 따라서 address에 접근할 수 없어 address의 값을 변경할 수 없습니다.

옵셔널 체이닝을 통해 최종 속성에 접근했다면 값 변경이 가능하고, 최종 속성에 접근하지 못하고 중간에 종료되었다면 값을 변경할 수 없습니다.

위에서 작성된 모든 코드입니다.

```swift
struct Contacts {
    var email: [String: String]?
    var address: String?
    
    func printAddress() {
        print(address ?? "no address")
    }
}

struct Person {
    var name: String
    var contacts: Contacts?
    
    init(name: String, email: String) {
        self.name = name
        contacts = Contacts(email: ["home":email], address: "Seoul")
    }
    
    func getContacts() -> Contacts? {
        return contacts
    }
}

var p = Person(name: "James", email: "swift@example.com")
let a = p.contacts?.address
type(of: a)

var optionalP: Person? = Person(name: "James", email: "swift@example.com")
let b = optionalP?.contacts?.address
type(of: b)

optionalP = nil
let c = optionalP?.contacts?.address
type(of: c)

p.getContacts()?.address

let f: (() -> Contacts?)? = p.getContacts
f?()?.address

let d = p.getContacts()?.printAddress()
type(of: d)

if p.getContacts()?.printAddress() != nil { }
if let _ = p.getContacts()?.printAddress() { }

let e = p.contacts?.email?["home"]
type(of: e)

p.contacts?.email?["home"]?.count

p != nil
p.contacts?.address
p.contacts?.address = "Jeju"
p.contacts?.address

optionalP == nil
optionalP?.contacts?.address
optionalP?.contacts?.address = "Jeju"
optionalP?.contacts?.address
```

# 6.  Optional Pattern

우선 옵셔널의 형태에 대해 파악해보겠습니다.

![Optionals%20c185e96c878a4b84adb190adb29c6eed/_2021-02-27__1.12.56.png](Optionals%20c185e96c878a4b84adb190adb29c6eed/_2021-02-27__1.12.56.png)

옵셔널은 열거형이고 제네릭 타입으로 선언되어 있습니다. 그렇기 때문에 어떠한 형태의 자료형도 옵셔널로 선언이 가능합니다. case는 두가지로 `.none`과 연관값을 받는 `.some`이 있습니다. 값이 있으면 .some, 없으면 .none 케이스에 속하는 것입니다. 

이를 확인해보겠습니다.

![Optionals%20c185e96c878a4b84adb190adb29c6eed/_2021-02-27__1.17.08.png](Optionals%20c185e96c878a4b84adb190adb29c6eed/_2021-02-27__1.17.08.png)

Optional<Int> 형태로 선언된 a가 nil인지 확인하는 과정입니다. 이는 .none 케이스와 일치하는지 확인하는 코드와 일치하는 코드입니다. 

a에 저장된 값이 0이 맞는지 확인하는 과정입니다. .some 케이스와 일치하며 그 값으로 0을 받는것이 맞는지 확인하는 코드와 일치하는 코드입니다.

이를 이해했으니 다음 코드를 작성하겠습니다. enumeration case pattern과 optional pattern을 혼합하여 사용하는 것입니다. 코드가 간결해진다는 장점이 있습니다.

```swift
if let x = a { print(x) }

// enum case를 알고있기 때문에 아래와 같이 표현할 수 있습니다.
if case .some(let x) = a { print(x) } 

// 이를 옵셔널 패턴으로 바꾸면 아래와 같습니다.
if case let x? = a {
    print(x)
    // 내부에서 x의 자료형은 Int입니다. 바인딩 시점에 동시에 unwrapping 된것입니다.
}
```

마지막 코드에서 x는 identifier입니다. a에 값이 있다면 임시상수 x에 값을 저장(바인딩)하는 것이기 때문에 x의 자료형은 Int입니다. 

이렇게 보면 장점이 있는지 잘 모르겠습니다. 배열에서 확인해보겠습니다.

```swift
let list: [Int?] = [ 0, nil, nil, 3, nil, 5]

for item in list {
    guard let x = item else { continue }
    print(x)
}

for case let x? in list {
    print(x)
}
```

두 for문을 실행하면 동일한 실행결과를 확인할 수 있습니다.

enum의 case를 사용하면 x?로 바로 바인딩하기 때문에 guard문을 작성할 필요가 없습니다. 

enum과 optional을 적절히 이해하고 있다면 코드를 더욱 간결하게 작성할 수 있습니다.