# Coding Convention
## 네이밍

### View Controller
* View Controller 이름에는 Upper Camel Case를 사용하자
* 각각의 View의 메인 View Controller의 이름은 되도록 '기능'+ViewController로 설정하자

### 함수
* 함수명은 Lower Camel Case를 사용하자
* 함수명은 되도록 동사를 사용하자

### 변수
* 변수명은 Lower Camel Case를 사용하자
  
### 상수
* 상수명은 Lower Camel Case를 사용하자

### IBOutlet
* IBOutlet 이름은 Lower Camel Case를 사용하자
* IBOutlet 이름은 되도록 '특징'+'IBOutlet 종류'로 설정하자

    #### 좋은 예
    ```swift
    @IBOutlet var titleLabel: UILabel!
    ```

    #### 나쁜 예
    ```swift
    @IBOutlet var title: UILabel!
    ```

### identifier
* identifier는 Lower Camel Case를 사용하자