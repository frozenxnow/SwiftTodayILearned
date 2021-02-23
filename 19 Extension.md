# Extension

# 1. Extension

class / struct / enumeration / protocol 에서 사용이 가능합니다.

멤버를 추가하는 것(Adding member)은 가능하지만 오버라이딩(member overriding)은 불가능합니다.

몇 가지 제약, 규칙이 있습니다.

 - 속성은 `계산 속성`만 추가할 수 있습니다.

 - ~~property observer~~는 추가할 수 없습니다.

 - `instance method` / `type method` 모두 추가할 수 있습니다.

 - `간편 생성자`를 추가할 수 있습니다.

 - ~~지정 생성자 / 소멸자~~는 원본 형식에서 구현해야합니다. (구현이 필요한 경우 상속을 이용합니다)

 - `subscript`를 추가할 수 있습니다.

 - `Nested Type`을 추가할 수 있습니다.

Extension을 사용해 필요한 `protocol을 채용`할 수 있습니다.

```swift
extension Type: protocol1, protocol2, .. {

}
```

# 2. Adding Properties

저장 속성은 추가할 수 없으며 계산 속성으로 제한됩니다. 오버라이딩 또한 불가능합니다.

# 3. Adding Methods

함수를 추가할 수 있습니다.

# 4. Adding Initializers

생성자를 추가할 수 있습니다. 매개변수로 형식에 어긋나는 값이 들어올 수 있으니 Failable initializer로 선언하여 guard문을 통해 파라미터 검증을 해야합니다. 

```swift
self에 새로운 인스턴스를 할당하는 방식으로 초기화 할수 있습니다.

struct에서 생성자를 선언하지 않을 경우,
파라미터가 없는 기본 생성자와 memberwise 생성자가 기본으로 제공되어 사용이 가능합니다.
이때 struct에서 ***다른 생성자를 정의***할 경우 
기본으로 제공된 생성자 중 memberwise 생성자는 사용이 불가능하게 됩니다.
 -> 이는 ***다른 생성자***를 extension으로 추가할 경우 기본 생성자를 사용할 수 있습니다.
```

# 5. Adding subscripts

정수를 파라미터로 받는 형식을 subscript에 추가하고, 해당 위치의 문자열을 return할 때 리턴은 `String?` 타입으로 받습니다. 범위를 벗어나는 정수을 입력받았을 때 `nil`을 리턴하는 검증 과정이 필요합니다. 형식에 구현되어 있는 다른 subscript를 호출할 때 `self expression`을 사용합니다.