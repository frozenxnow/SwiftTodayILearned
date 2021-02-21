# Loop Statements

# 1. for - in 반복문

```swift
for 반복상수 in 범위(collection) {
	code
}
```

반복상수를 사용하지 않는다면 생략해도 좋고, 와일드카드(언더스코어)로 처리해도 좋습니다. 

범위는 collection의 형태로도 가능합니다. 

```swift
for 반복상수 in stride( from: - , to: - , by : -) {
	code
}
```

범위 대신 `stride(from:to:by:)` 함수를 사용할 수 있습니다. 순서대로 `시작값, 끝값, 증감`을 입력해줄 수 있습니다. by 뒤에 음수를 넣으면 from 부터 값이 감소합니다. 

for - in 문은 얼마든지 중첩해서 사용할 수 있습니다.

# 2. while 반복문

while문과 for-in문의 차이점은, while문에는 범위가 지정되지 않는다는 점입니다.

```swift
while condition(BoolType) {
	code 
}
```

기본적인 while문의 구조입니다. 

```swift
repeat {
	code
} while condition(BoolType)
```

적어도 한 번 실행되는 반복문입니다. 먼저 코드가 한번 실행되고, 그 다음 condition을 판단해 코드를 반복할지, 중지할지 결정합니다. 

condition이 특정 시점에 false가 되는지 확인해보는 것은 매우 중요합니다. false가 되지 않는다면 멈추지 않고 반복문이 끊임 없이 실행되기 때문에 무한루프에 빠질 수 있습니다.