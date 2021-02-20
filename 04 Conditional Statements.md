# Conditional Statements

다른 언어를 학습한적이 있다면 조건문과 반복문은 어렵지 않게 작성할 수 있을것입니다. 한 가지 가장 큰 차이점을 꼽자면 조건문의 조건절에 `{중괄호}`를 생략할 수 있다는 점입니다.

# 1. If 조건문

어렵지 않으니 생략하겠습니다.

# 2. Switch 조건문

`switch조건문`은 if문과 같이 조건을 판별하여 상황에 맞는 블럭을 찾아 실행한다는 점은 동일하나, 조건이 여러개일 경우 if문을 중첩하거나 이어 붙이는 것보다 switch문을 적절히 사용하는 것이 더욱 효율적이고 가독성이 높아집니다. 이는 주로 pattern matching이나 value matching에 사용합니다.

각 `case`마다 시행되어야 하는 실행문을 각각 나열해주는 것입니다. case 뒤에 `where절`을 작성하면 한 번 더 확인하는 코드가 됩니다. 

`Interval Matching`이 가능합니다. 이는 범위 매칭입니다. case 에 범위를 작성할 수 있습니다.

switch문은 조건을 찾아 해당 조건에 맞는 실행문을 실행한 후 switch문을 빠져나갑니다. 이에 관계 없이 다음 case를 반드시 실행하는 제어문이 있습니다. `fallthrough`입니다. case에 맞는 구문을 실행하던 중 `fallthrough`를 만나면 즉시 실행을 멈추고 다음 case를 조건에 관계없이 실행합니다.

```swift
switch witchType {
case .j:
    print("원래는 여기만 출력되어야 함")
    print("This is \(witchType)")
    fallthrough
    print("이후의 문장은 실행하지 않습니다")
case .p:
    print("fallthrough를 사용하여 여기도 출력됩니다")
    print("This is \(witchType)")
    fallthrough
    print("이후의 문장은 실행하지 않습니다")
case .w:
    print("fallthrough를 여기도")
    print("This is \(witchType)")
}
```

선언한 case가 .j에서 일치한다고 가정했을 때, 첫 케이스의 구문을 출력하던 컴파일러는 `fallthrough`를 만나 다음 케이스인 .p를 실행합니다. 마찬가지로 `fallthrough`를 만나 .w의 구문을 실행하고 종료됩니다.

# 3. Guard Statement

우선 Early Exit란, 원하는 조건이 충족되면 불필요한 코드를 실행하지 않고 일찍 종료함을 뜻합니다.

```swift
guard *condition* else {
									statements
								}

guard *optionalBinding* else {
												statements
											}
```

가드문을 사용할 때 주의할 점이 있습니다. 

첫번째는 else를 생략할 수 없다는 점이고, 

두번째는 반드시 가드문 내에서 실행구문을 멈추는 구문이 있어야한다는 점입니다. 

guard문의 condition이 `false일 경우 else block이 실행`됩니다. 

guard문은 if문으로 대체가 가능하지만, if문의 중첩을 피할 수 있고 코드가 간결해진다는 장점을 가지고 있습니다. 

Optional Binding과 함께 사용할 수 있다는 점도 기억해주세요. 

```swift
func validateUsingIf() {
    var id: String? = nil
    if let str = id {
        if str.count >= 6 {
            print(str)
        }
    }
}

func validateUsingGuard() {
    var id: String? = nil
    guard let str = id else { return }
    guard str.count >= 6 else { return }
    print(str)
}
```

If문과 guard문을 비교해보았습니다. 

조건을 추가할수록 if문은 중첩되는 반면 guard문으로 작성한 함수는 중첩이 없어 코드가 깔끔합니다. 

바인딩할 경우 if문에서는 바인딩한 임시 상수를 if문 내에서 사용해야 하지만 guard문에서 바인딩한 임시 상수는 else문에서 상용하지 못하고 guard문 밖에서 사용할 수 있습니다. else block은 바인딩에 실패했을 때 실행되는데, 바인딩에 실패했기 때문에 임시상수가 생기지 않는 것입니다. 

# 4. Value Binding Pattern

switch block 내부에서 주로 where절과 함께 사용합니다. 매칭시킬 대상을 `case에서 상수나 변수에 바인딩한다`고 이해했습니다.

예문을 보겠습니다.

```swift
var a = 100

switch a {
case var x where x < 100 :
    print("x<100")
case var x where x > 100 :
    print("x>100")
default:
    print("x=100")
}
```

x라는 변수에 a를 바인딩 했습니다. 

간단한 예문이기 때문에 불필요한 단어가 섞인것 같지만, 알고 있으면 유용하게 사용할 수 있을것 같습니다. 바인딩 되는 숫자가 두 개 이상(튜플)이어도 가능합니다.

```swift
var pt = (1,2)

switch pt {
case var (x,y) :
    print(x,y)
}
```

혹은

```swift
switch pt {
case (let x,var y) :
    print(x,y)
}
```

이렇게 바인딩할 수 있습니다. x와 y를 각각 상수와 변수에 하나씩 지정해야할 경우 따로 선언해주기 위함입니다. 

필요 없는 값은 바인딩하지 않도록 와일드카드(_)를 사용할 수 있습니다.

```swift
switch pt {
case let (x, _) :
    print(x,y)
}
```

# 5. Expression Pattern

......ㅠ_ㅠ