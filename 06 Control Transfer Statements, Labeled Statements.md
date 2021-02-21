# Control Transfer Statements, Labeled Statements

# 1. Control Transfer Statements

제어를 전달하는 `흐름제어문` 입니다. 

1. fallthrough
2. throw
3. return
4. break
5. continue

```swift
continue // 다음 회차로 전달합니다. 이후의 코드는 무시
break // 반복문을 종료하고 루프를 벗어나는 흐름제어문
 >> 비슷한 역할을 하지만 종류에 따라 제어가 전달되는 곳이 다릅니다. 
```

# 2. Break statement

switch문, 반복문을 멈추고 이어지는 코드를 전달합니다.

중첩되었을 경우에는 가까이에 인접한 반복문만 정지합니다.

# 3. Continue statement

반복문에서만 사용합니다.

현재 반복을 중지하고 다음 반복을 실행합니다. 중첩되었을 때 인접한 반복문에 영향을 줍니다. 

# 4. Labeled Statement

구문에 이름을 붙이는 것입니다. break, continue와 함께 사용합니다.

if문, 반복문, switch문에서 사용 가능하며, 내부에서 외부의 흐름을 제어하기 위해 사용하는 이름표입니다.

```swift
**outSide**: for i in 1...3 {
	print("outerLoop", i)
		for j in 1...3 {
			print("innerLoop", j)
			break **outSide**
		}
}

/*
outerLoop 1
innerLoop 1
*/
```

외부의 for-in문에 `outSide`라는 명칭을 붙여주고, 내부에서 `outSide`를 정지하는 모습입니다.

내부의 for-in문에서 외부의 for-in문을 종료시켰습니다.