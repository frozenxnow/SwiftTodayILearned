# Method and Subscript

# 1. Instance Method

인스턴스를 통해 호출하는 메서드입니다. 

인스턴스마다 호출 결과가 달라집니다. 클래스, 구조체 외부에서 호출할 경우 인스턴스 생성 후 아래와 같이 그 인스턴스로 호출합니다. 속성 호출시에도 마찬가지입니다.

```swift
***instance***.method(parameter)
***instance***.property
```

구조체 내 함수를 선언할 경우 `mutating`으로 선언해야 합니다. 구조체에서는 값을 복사한 후 그 값을 변경하는 것이기 때문에 인스턴스를 상수가 아닌 변수로 선언해야합니다. 

# 2. Type Method

class, struct, enum에서 선언하고 사용하는 타입메서드입니다. `static` 키워드를 가지고 있으며, 호출시에는 타입 이름으로 호출합니다. 인스턴스 메서드와 달리 속성 호출시에는 Type.을 제외한 `속성명`으로만 호출합니다. 

```swift
***Type***.method(parameter)
property
```

타입 속성으로 선언한(static) 속성과 메서드는 자식클래스에서 오버라이딩할 수 없습니다. 오버라이딩이 필요한 메서드는 static이 아닌 `class` 키워드로 선언해야합니다. 

# 3. Subscript

사용자 정의 script입니다. 

```swift
subscript(parameters) -> ReturnType {
				get {
						return statements
				}
				set(name) {
						statements
				}
	}
```

`get` : 값을 읽어오는 block 입니다. (읽기)

`set` : 값을 입력하는 block 입니다. (쓰기)

get block은 반드시 있어야 하며, set block이 없는 경우 `읽기 전용 subscript`가 됩니다. 이 때 아래와 같이 get block을 생략할 수 있습니다. 

```swift
subscript(parameters) -> ReturnType {
						return statements
	}
```

argument Label을 사용할 수 있지만 특별히 필요한 경우가 아니라면 가독성을 떨어뜨리기 때문에 자주 사용하지 않습니다.

이중배열로 자료가 주어졌을 때 값을 읽어오기 위해 두 개의 파라미터가 필요합니다. 

```swift
ex)

struct Matrix {
			var data = [[1, 2, 3], [4, 5, 6], [7,  8, 9]]
			subscript(row: Int, col: Int) -> Int {
						return data[row][col]
						}
}
```

Matrix 구조체 안에서 data는 이중배열의 형태입니다. row와 col을 입력받아 위치에 해당하는 값을 읽기 위해서는 우선 Matrix 타입의 인스턴스를 생성하고, 그 인스턴스를 통해 subscript를 호출해야합니다.

```swift
let m = Matrix()
m[1,2]
```

return받아야하는 값은 data[a][b] 형태를 띠고 있지만 그 형태는 return에서 잡아주었습니다. 

인스턴스를 통해 파라미터를 순서대로 나열함으로써 subscript를 실행해 올바른 data 값을 읽어올 수 있습니다.

# 4. Dynamic Member Lookup

`@dynamicMemberLookup` 키워드를 사용할 경우, subscript에 대한 구현이 필요합니다. 다시 살펴봐야 할 필요가 있습니다. 

```swift
p[dynamicMember:"nameKey"] => p.nameKey
```

`dynamicMemberLookup` 을 사용하면 위와 같이 단축할 수 있습니다. 이는 후에 다시 내용을 보완하도록 하겠습니다.

장점 : 코드의 유연성이 높아집니다.

단점 : 대상에 접근하는 시점이 런타임 시점으로, 컴파일 당시 자동완성을 제공하지 않아 오타가 날 경우 에러가 발생합니다. 가독성이 떨어지고, 유지와 보수가 어렵다는 단점이 있습니다.