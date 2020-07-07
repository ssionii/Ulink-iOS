# Ulink-iOS 성은's Work ❣️🌝❣️

## CalendarView🗓


### <img src="https://emoji.slack-edge.com/T016U39U5K2/ulink-white/7a9f6567dc63c937.png" width=2%> 사전준비
- #### 캘린더뷰 디자인   
  
  <img src="./image/calendarDesign.png" width="40%">

- #### 해야할 일
  1. 전체 캘린더 짜기   
       * 레이아웃
       * 다음달, 이전달 버튼
       * 윤달 설정
       * 이전달의 마지막 주, 다음달의 첫 주 - placeholder
       * 일요일 숫자 색깔 다르게   
  
  2. 달력에서 일정 보여주기    
       * 서버에서 데이터 받기 (과목 색상, 날짜, 이름, 내용)
       * 해당 날짜에 해당 색깔로 이름 일정 찍기
       * 사용자 개인의 추가 일정 입력   
  
  3. 날짜 클릭 이벤트   
       * 날짜 셀을 터치하면 해당 날짜의 일정 정보 서브 뷰 띄우기
       * 서브 뷰에 버튼
       * 어디론가 이동하기


### <img src="https://emoji.slack-edge.com/T016U39U5K2/ulink-purple/2e44cf60188f40d7.png" width="2%"> 개발내용
- #### ~~라이브러리 삽질~~  

    캘린더 라이브러리 : "FSCalendar"   
    ➡️ [FSCalendar 라이브러리 github](https://github.com/WenchaoD/FSCalendar)   
    캘린더가 완벽하게 구현되어 있고 어느정도 커스텀이 가능하다는 특징!   

     FSCalendar 라이브러리를 열어서 씹고 뜯고 맛보기   
     
    
    #### <테스트 해본 결과>
     <img src="./image/fscalendar.png" width="40%">   

     디자인 일정 부분 변경, 이벤트 추가 등이 가능했지만 디자인단에서 원하는 뷰를 만들기에는 어려움이 있었다.   
     결국 FSCalendar는 사용하지 않기로...

***

- #### CollectionView로 캘린더 처음부터 짜기
  
  - 월 별 날짜 수를 배열로 저장
  ``` swift
  var numOfDate = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  ```
  - 윤년 설정   
    4년에 한번 2월의 일 수를 29로 변경
  ``` swift
  if (todayYear % 4 == 0){
            numOfDate[1] = 29
        } else {
            numOfDate[1] = 28
        }
  ```

  - 캘린더를 처음 열었을 때 오늘 날짜의 달을 띄워주기 위해 오늘 날짜(today)를 알아내고 현재 페이지 날짜(current)에 저장   
  다음달, 이전달 버튼을 터치하면 current 변수를 1씩 변경

  - 1일의 요일을 알아내기   
  (일요일 - 1, 월요일 - 2 ... 값을 return)
  ``` swift
  func getFirstWeekDay() -> Int{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-M-yyyy"
        let dateString = "01-" + String(currentMonth) + "-" + String(currentYear)
        let myDay = dateFormatter.date(from: dateString)
        let first = cal.dateComponents([.weekday], from: myDay!)
        
        let firstWeekDay = first.weekday!
        return firstWeekDay
  }
  ```

  - 전체 cell 개수
    이전달 placeholder와 이번달 일 수의 합이 
    - 28이면 cell 수는 28
    - 35보다 크면 cell 수는 42
    - 나머지는 cell 수 35

  - cell 날짜 찍는 함수   
  textColor 변수로 글자 색 구분   
     * 저번달, 다음달 placeholder : 회색 글씨
     * 오늘 날짜 : 흰색 글씨 + 보라색 배경
     * 일요일 : 보라색 글씨
     * 나머지 : 검정색 글씨
  ```swift
  func setDayCell(firstDay: Int, textColor: Int)
  ```

  - 날짜 구분 조건   
     * 이전달 placeholder
     ```swift
     indexPath.row >= 0 && indexPath.row < first
     ```
     * 이번달
     ```swift
     indexPath.row >= first && indexPath.row < last + first
     ```
     * 이번달 토요일
     ```swift
     (indexPath.row % 7) == 0
     ```
     * 이번달 오늘
     ```swift
     ((indexPath.row - first + 1) == todayDate) && (currentMonth == todayMonth) && (currentYear == todayYear)
     ```
     * 다음달 placeholder - else

  - 일정 제목 padding   
    디자인적으로 padding이 필요해서 UILabel에 padding 넣는 방법을 찾다가 inset 설정이 있는 UIButton에 사용자 interaction enabled를 해제해서 사용

  - cell에 일정 추가하는 함수   
  날짜, eventName 배열, color 배열을 서버에서 받아서 해당 날짜에 개수만큼 일정을 찍어준다.
  ```swift
  func setEvent(eventName: [String], color: [UIColor])
  ```

     #### <여기까지 뷰 완성본>
     <img src="./image/calComplete.png" width="40%">


***   
- #### 뷰 수정(07/06)
  #### 오늘이 포함된 달로 돌아오는 버튼 추가

  - current 변수를 today 변수로 변경 후 collection view reload
  ```swift
  @IBAction func backToToday(_ sender: Any) {
      currentMonth = todayMonth
      monthLabel.text = String(currentMonth) + "월"
      calendarCollectionView.reloadData()
  }
  ```

  - 버튼 이미지를 배경으로 깔고, text는 오늘 날짜로

  #### <여기까지 뷰 완성본>
  <img src="./image/calModified.png" width="40%">

***

- #### 날짜 셀 클릭 이벤트
  - 팝업 창 띄우기   
  새로운 VC ! (DetailEventViewController)   
  배경 검정색으로 지정 후 opacity까지 지정해줌

    calendar view 위에 overCurrentContext 설정으로 modal 띄워주기
  ```swift
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let popUpVC = self.storyboard?.instantiateViewController(identifier: "detailEvent") as? DetailEventViewController else {return}

        popUpVC.modalPresentationStyle = .overCurrentContext
        present(popUpVC, animated: false, completion: nil)
    }
    ```

  - 빈 부분 클릭하면 팝업 창 닫기   
  touch한 부분이 collection view가 아니면 팝업 창 dismiss
  ```swift
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch = touches.first
        if touch?.view != self.detailEventCollectionView
        { self.dismiss(animated: false, completion: nil) }
    }
  ```
  - calendar view에서 서버로부터 데이터를 받아 detail event view로 넘겨줄 예정
  - 일단 더미 데이터를 띄워보았다😲
  ```swift
  func setEventList(date: String, eventName: [String], category: [Int], time: [String]){
  ```
