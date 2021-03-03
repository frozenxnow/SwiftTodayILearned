# Property

# 1. Stored Property

**저장속성**입니다. 클래스와 구조체에서 선언하며, 인스턴스가 생성될 때마다 새로운 저장공간(메모리)이 생성됩니다. 인스턴스마다 속성 값이 달라집니다.

```swift
var name: Type = DefaultValue // 변수, 값 변경 가능
let name: Type = DefaultValue // 상수, 값 변경 불가능
```

- 클래스로 생성한 인스턴스는 참조형식입니다. 이 인스턴스를 let으로 선언할 경우 let이 고정하는 것은 참조하는 주소이기 때문에, 인스턴스가 참조하는 원본의 저장 속성이 var로 선언되어 있다면 값 변경이 가능합니다.
- 구조체로 생성한 인스턴스는 값형식입니다. 이 인스턴스를 let으로 선언할 경우 let이 고정하는 것은 각 값이기 때문에, 인스턴스가 var로 선언되어 있을 때 값 변경이 가능합니다.

**Lazy Stored Properties(지연 저장 속성)** : 초기화를 지연시킵니다. 인스턴스를 초기화하는 시점이 아니라 **속성에 처음 접근하는 시점을 지연**시킵니다.

인스턴스가 초기화된 이후 개별적으로 초기화가 진행되기 때문에 변수 저장속성으로 선언합니다.

```swift
lazy **var** x = Class()
// lazy let 로 선언할 경우 error! 
```

생성자에서 초기화하지 않기 때문에 선언 시점에 기본값을 저장해야합니다.

```swift
struct Image {
	init() {
		print("img")
	}
}

struct BlogPost {
    let title: String = "Title"
    let content: String = "Content"
    lazy var attachment: Image = Image()
    
    let date: Date = Date()
    lazy var formattedDate: String = {
       let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .medium
        return f.string(from: date)
    }()
}

var post = BlogPost() // 새 인스턴스 생성시 image는 초기화되지 않습니다.
post.attachment // attachment가 초기화되어 콘솔에 img가 출력됩니다. 
```

- attachment는 title과 content에 비해 크기가 크고 매번 사용하는 속성이 아닙니다. 때문에 인스턴스를 생성할 때마다 초기화를 하는것은 메모리를 낭비하는 것이므로 지연저장 속성으로 저장하는 것이 좋습니다.
- attachment는 lazy var 키워드로 생성했습니다.
- 인스턴스 또한 var 키워드를 사용해 변수로 선언해야합니다.
- 새 인스턴스를 생성할 때 아직 attachment는 초기화되지 않습니다.
- date 속성을 선언하고 이를 사용해 오늘의 날짜를 string 포맷으로 리턴하는 함수를 지연저장 속성으로 선언했습니다. 
함수에서 lazy 키워드를 삭제하면 컴파일 에러가 발생하는데, 저장속성을 초기화할 때 같은 **스코프 내 다른 속성에 접근해야 한다면** 지연저장 속성으로 선언해야하기 때문입니다.

# 2. Computed Property

계산 속성입니다. 다른 속성값을 기반으로 속성의 값이 결정되기 때문에 `var`로 선언해야 합니다. 메모리 공간을 갖지 않고, **선언 시점에 기본값을 저장**할 수 없습니다. 따라서 타입 추론이 불가능해 **타입을 반드시 선언**해주어야 합니다. 

```swift
var name: Type {
    get { // 읽기 
        statements
        return expr
    }
    set(name) { 
        statements
	// 쓰기 (parameter를 작성하지 않으면 기본으로 제공하는
	// newValue 파라미터를 사용할 수 있습니다.)
    }
}
```

위에서 set 블록은 생략이 가능합니다. get 블록만 있는 상태를 읽기 전용 속성이라고 말합니다. 

읽기 전용 문법은 아래와 같이 get { } 을 생략하고 작성할 수 있습니다.

```swift
var name: Type {
      statements
      return expr
}
```

클로저와 비슷한 모습이지만 Type 뒤에 할당연산자(=)가 없다면 계산속성을 의미하는 것입니다. 

# 3. Property Observer

속성을 감시하는 속성감시자입니다.

```swift
var name: Type = DefaultValue {
    willSet(name) {
        statements
    }
    didSet(name) {
        statements
    }
}
```

- willSet : 속성에 값이 저장되기 직전에 호출됩니다. willSet에는 전달 되어야 하는 값이 파라미터가 되며 생략할 경우 newValue라는 기본 파라미터가 제공됩니다.
- didSet : 값이 저장된 직후 호출됩니다. didSet에는 이전 값이 파라미터로 전달됩니다. 파라미터 이름을 생략하면 oldValue라는 기본 파라미터가 제공됩니다.

property observer는 변수 저장속성에 추가할 수 있습니다. 상수 저장속성은 값이 변경되지 않기 때문에 감시라는 개념이 적용되지 않습니다. 지연 속성과 계산 속성에도 추가할 수 없습니다. 

```swift
class Size {
    var width = 0.0 {
        willSet {
            print(width, "=>", newValue)
        }
        didSet {
            print(oldValue, "=>", width)
        }
    }
}

let s = Size()

s.width = 123

// 콘솔 출력
// 0.0 => 123.0 : willSet 
// 0.0 => 123.0 : didSet
```

필수 요소는 아니지만 property observer가 되기 위해서는 willSet과 didSet블록 중 하나는 반드시 구현해야 합니다. 

[Swift ) Properties - Property Observers(프로퍼티 옵저버)](https://zeddios.tistory.com/247)

이해가 잘 가지 않아서 다른 자료를 찾아보았습니다. 

프로퍼티 옵저버는 프로퍼티 값이 변경되는 것을 감시(모니터링)하는 것입니다. 

내가 정의한 저장속성에 추가할 수 있고, superClass를 상속한 속성에도 추가할 수 있습니다. 

다만, superClass의 willSet, didSet 옵저버는 superClass의 Initializer가 호출된 후 자식의 initializer에서 set될 때 호출됩니다.

옵저버를 이해하는데 큰 도움이 된 예제가 있습니다. 

```swift
class StepCounter {
    var totalStep: Int = 0 {
        willSet {
            print("totalSteps를 \(newValue)로 설정합니다.")
        }
        didSet {
            if totalStep > oldValue {
                print("\(totalStep - oldValue)걸음이 추가되었습니다.")
            }
        }
    }
}
```

위 코드는 만보기의 걸음 수를 세팅하는 코드입니다. 인스턴스 생성 후 새로운 값을 저장할 때마다 기존의 값이 어떻게 변화하는지를 변경 전/후 모두 출력합니다. 

```swift
let stepCounter = StepCounter()

stepCounter.totalStep = 200
// totalSteps를 200로 설정합니다.
// 200걸음이 추가되었습니다.

stepCounter.totalStep = 1000
// totalSteps를 1000로 설정합니다.
// 800걸음이 추가되었습니다.
```

클래스에서 기본값은 0으로 설정되어 있습니다. 그러니 totalStep을 200으로 변경하는 시점에 값은 0 → 200이 되고, 변경 전에는 willSet에 정의된 세팅한 값에 대한  코드가 실행되고, 변경 후에는 didSet에 정의된 추가되는 걸음 수에 대한 내용에 대한 코드가 실행됩니다. 

한번 더 보겠습니다. 200 → 1000 으로 만보기의 세팅이 변경됩니다. 

willSet은 1000으로 설정한다는 메시지를 출력하고, didSet은 추가된 걸음수(800)에 대한 메시지를 출력합니다.

어떤 상황에서 사용하는 것인지는 아직 잘 모르겠습니다만 이해는 했습니다! 🤧