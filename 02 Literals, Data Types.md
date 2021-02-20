# Literals, Data Types

리터럴, 숫자와 같이 다양한 값을 프로그래밍 언어에서 표현하는 방법에 대해 공부하고, Swift에서 제공하는 기본 자료형에 대해 알아봅니다.

---

# 1. Data Types with Memory

데이터 타입에는 기본 내장 자료형(Built-in data type)과 사용자 정의 자료형이 있습니다. 

Integer, Floating, Boolean, Character, String Type

## 1) 정수

- Bit : 컴퓨터에서 사용하는 가장 작은 단위 (0, 1로 이루어져 있으며 8bit = 1byte 입니다)
- Signed Data Type : 양수, 0, 음수를 모두 저장할 수 있습니다. ( -128 ~ +127 )
- Unsigned Data Type : 양수, 0을 저장할 수 있습니다. ( 0 ~ +255 )
- Sign Bit : 1Byte를 나열했을 때 가장 처음에 오는 Bit 값입니다. Signed Data Type의 경우 최상위 비트값으로 양수와 음수를 결정합니다.

## 2) 실수

- 부동소수점 방식을 사용합니다. 이 또한 1Byte입니다.
- Sign Bit가 있고, 3Bit는 지수부, 4Bit는 가수부로 이루어져 있습니다.
- 실수 저장 시 지수와 가수를 나누어 저장합니다.
- 동일한 메모리 크기에서 정수보다 더 넓은 범위를 표현합니다.
- 부동소수점 오차로 인해 완벽한 실수 저장은 불가능합니다.

# 2. Numbers

정수 자료형 : Int8, Int16, Int32, Int64 / UInt8, UInt16, UInt32, UInt64
실수 자료형 : Float(4Byte), Double(8Byte)

# 3. Boolean

true/false로 값을 반환합니다. 1/0으로 대체할 수 없습니다.
Bool Type을 return하는 method의 접두어는 is가 많습니다. ex) isEmpty

# 4. Strings and Characters

"Strings" : 큰 따옴표로 감싸면 문자열 리터럴이 되고, 선언시 Type을 명시해주지 않으면 String Type이 됩니다.
 "C" : 문자가 하나 있는 문자 리터럴입니다. 반드시 Type을 명시해주어야 합니다. 문자가 두 개 이상일 경우 에러가 나타납니다. 빈 문자도 불가능합니다. " "와 같이 공백을 넣어야합니다.

# 5. Type Inference

선언시 Type을 지정하지 않으면 숫자는 Int, 소수는 Double, 문자열은 String으로 선언됩니다.

데이터를 선언할 때 변수명, 혹은 상수명 뒤에 (:Type)를 붙여 형식을 제시해준다면 형식 추론을 거치지 않아 컴파일 시간이 단축됩니다. 

# 6. Type Safety

서로 다른 Type끼리는 어떠한 연산도 불가능합니다. Int와 Int8도 연산이 불가능합니다. 할당은 물론이고 계산식에서도 마찬가지입니다. 

# 7. Type Conversion

형변환입니다. Type이 다른 Data끼리 연산하기 위해서는 형변환을 해주어야합니다. 크기가 큰 타입에서 작은 타입으로 변경할 경우 디바이스에서 크래시가 일어나 주의해야합니다. 이후에 공부하게 될 Type Casting과는 다릅니다. 

# 8. Type Alias

별명을 만듭니다. 자주 사용하지 않습니다.