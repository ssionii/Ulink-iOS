시연이의 개발 일지 
===================

[26th SOPT APP-JAM]
팀 **유링크**의 iOS 개발자 🍎

## 개요

역할: 시간표 기능 구현

기간: 2020/06/28 ~
 
## 개발 내용

### 1. 메인 시간표
**라이브러리**
github에서 찾은 Library를 참고해서 시간표의 전체적인 구성을 그렸다.
👉 github 주소: https://github.com/della-padula/Elliotable
<br>

**개발 과정**

1. 시간표에 관한 data 및 operation을 가지고 있는 클래스를 생성한다.

해당 클래스는 이 시간표를 다루는 controller와 과목을 시간표 형태로 뿌려 줄 수 있는 collectionView를 가지고 있다. 또한, 시간표가 기본으로 가져야 할 디폴트 시작 및 끝나는 시간, 과목 아이템의 높이 등을 가지고 있다. 시간표 안의 label이나 border등의 속성 값들을 가지고 있으며 이들을 바탕으로 makeTimeTable() 함수에서 시간표를 그려준다. 그리고 TimeTableDelegate, TimeTableDataSource 프로토콜을 만들어준다.

중요한 부분을 뽑아낸 코드는 다음과 같다. (중간 중간 넘어간 부분이 많고, 어떤 일을 하는지 보여주기 좋은 코드만 가져왔다.)

TimeTable.swift
```swift
public protocol TimeTableDelegate {
    func timeTable(timeTable: TimeTable, didSelectSubject selectedSubject: Subject)
}

public protocol TimeTableDataSource {
    func timeTable(timeTable: TimeTable, at dayPerIndex : Int) -> String
    func numberOfDays(in timeTable: TimeTable) -> Int
    func subjectItems(in timeTable: TimeTable) -> [Subject]
}


@IBDesignable public class TimeTable : UIView {
    private var controller = TimeTableController()
    public var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    public let defaultMinHour : Int = 9
    public let defaultMaxHour : Int = 19
    public var subjectItemHeight : CGFloat = 50.0
    
    public var delegate : TimeTableDelegate?
    public var dataSource : TimeTableDataSource?

    private var subjectCells = [SubjectCell]()
    public var startDay = TimeTableDay.monday
    public var subjectItems = [Subject]()
    
    // setter option
    @IBInspectable public var symbolFont = UIFont(name: "AppleSDGothicNeo-Medium", size: 14){
        didSet { makeTimeTable() 
     }

    private func initialize(){
        controller.timeTable = self
        controller.collectionView = collectionView

        collectionView.dataSource = controller
        collectionView.delegate = controller

        addSubview(collectionView)

        makeTimeTable()
    }

    private func makeTimeTable(){
        // 시간표의 시작 시간 및 끝나는 시간 계산
        // 시간표 안의 요소 (과목) 그리기
        // 소스코드가 너무 길어서 리드미에서는 생략한다.
    }
}

```
<br>

2. 과목들(Subject Cell)로 채워지는 CollectionView 설정을 위해 TimeTableViewController 클래스를 생성한다. 이 클래스에서 UICollectionViewDataSource, UICollectionViewDelegate를 상속받아 구현한다.
<br><br>
3. 스토리보드에 UIView를 추가하고 Custom 클래스를 TimeTable로 지정해준다. 
<br><br>
4. 스토리보드에 그린 뷰컨에 연결할 TimeTableUIViewController 클래스를 생성하고한다. 이 클래스에서는 버튼 설정, backgroundView gradient 설정, TimeTableViewDataSource, TimeTableViewDelegate를 상속받아 구현한다.
<br> <br><br> <br>

<b>결과 화면</b>

<div align="center">
<img width="210" alt="스크린샷 2020-07-08 오전 3 38 53" src="https://user-images.githubusercontent.com/37260938/86827100-8ececb80-c0cc-11ea-8649-61c4396556a2.png">
<img width="300" alt="스크린샷 2020-07-08 오전 3 37 00" src="https://user-images.githubusercontent.com/37260938/86826906-4b745d00-c0cc-11ea-8b2f-ee98f2fb5f2c.png">
</div>

왼쪽이 제플린으로 디자이너가 넘겨준 뷰이고 오른쪽이 실제로 구현된 결과 화면이다. 

<br><br>
**어려웠던 점/새로 배운 점**

처음에 시간표 개발을 시작할 때 시간표 뷰를 어떻게 구성해야할지 막막했다.
CollectionView의 layout을 UICollectionViewFlowLayout으로 설정하면 셀마다 크기가 다르고, 위치가 다른 특징들을 신경써서 개발할 수 있다는 것을 알았다. 따라서 위의 개발 과정 1에서 볼 수 있듯이 TimeTable 클래스에서 아래와 같은 코드를 통해 layout을 설정해주었다.
```
public var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
```

----


### 2. 시간표 설정
**개발 과정**

메인에 위치한 시간표 설정 아이콘을 클릭 했을 때, 전체는 어둡게 어두워지고 뷰만 애니메이션이 적용되어 위로 올라와야 했다. 이를 위해 뷰컨 전환을 할 때 밑에서 올라오는 애니메이션을 적용하지 않고 다음과 같이 개발을 진행하였다. 


1. 시간표 설정 뷰컨을 생성하고 제일 상단에 위치한 뷰의 배경을 어둡게 설정하고 Xcode의 inspector에서 presentation을 Over Current Context로 설정해준다.

<img width="300" alt="스크린샷 2020-07-08 오전 4 16 50" src="https://user-images.githubusercontent.com/37260938/86831444-dc9a0280-c0d1-11ea-995b-04d2ca2ba5d6.png">


2. 밑에서 올라올 뷰를 만들고 bottom constant를 이용해 해당 뷰의 height 만큼 아래로 내린다. 예시는 다음과 같다.

<img width="300" alt="스크린샷 2020-07-08 오전 4 20 06" src="https://user-images.githubusercontent.com/37260938/86831802-503c0f80-c0d2-11ea-809a-5a768f823852.png">


3. 뷰컨에 연결할 TimeTableSettingViewController 클래스를 생성한다. 이 클래스에서 viewWillAppear 를 통해 뷰가 나타나기 전에 설정을 변경해서 뷰가 밑에서 위로 나타날 수 있도록 한다. 자세한 코드는 아래와 같다.

```swift
class TimeTableSettingViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var botLayout: NSLayoutConstraint!
   
    private let viewHeight: CGFloat = 300
    private let hideBotViewHeight : CGFloat = 223
 
    override func viewWillAppear(_ animated: Bool){
        isDismiss ? disAppearAnim() : appearAnim()
    }

    func appearAnim(){
        self.botLayout.constant = hideBotViewHeight - viewHeight
        UIView.animate(withDuration: 0.3){
            self.view.layoutIfNeeded()
        }
    }

    func disAppearAnim(){
        self.botLayout.constant = -self.viewHeight
        UIView.animate(withDuration: 0.3){
            self.view.layoutIfNeeded()
        }
        dismiss(animated: true)
    }
}
```

<br><br>

**결과 화면**

![ezgif com-video-to-gif (8)](https://user-images.githubusercontent.com/37260938/86833553-a316c680-c0d4-11ea-803a-47f3689450f0.gif)

<br>

**어려웠던 점/새로 배운 점**

iOS파트 2주차 과제 때 배웠던 Constant를 코드 상에서 조절하는 법을 이렇게도 사용할 수 있다는 것을 처음 알았다. 또한, iOS 파트 OB 김남수님 덕분에 viewDidLoad - viewWillAppear - viewDidAppear 라는 생명주기가 있다는 것을 알게 되었다. 

----


### 3. 시간표 리스트로 보기
**개발 과정**

위의 것들과 비교했을 때 가장 무난하게 개발할 수 있었던 기능이었다. 하지만,, 여기에도 변수가 존재했으니,,


1. 뷰컨을 생성하고 해당 뷰컨에 UICollectionView를 추가한다. 또한, 섹션마다 위 아래에 header와 footer가 필요하므로 Collectoin Reuseable View도 Cell과 함께 추가해준다.


2. TimeTableListViewController 클래스를 생성해준다. 
👉 다른 것들은 평소 했던것과 비슷한데 한가지 다른 점이 있다! 바로 header와 footer를 이용하려면 TimeTableListHeader와 TimeTableListFooter를 만들어주고 ViewController에 아래와 같은 코드를 작성해줘야 한다.

```swift
func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
    switch kind {
    case UICollectionView.elementKindSectionHead            let headerView : TimeTableListHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "timeTableListHeader", for: indexPath) as! TimeTableListHeader
            
        headerView.setSemester(semester: listDummy[indexPath.section].semesterName)
        return headerView
    case UICollectionView.elementKindSectionFooter:
        let footerView : TimeTableListFooter = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "timeTableListFooter", for: indexPath) as! TimeTableListFooter
            
        return footerView
    default:
        assert(false, "안돼 돌아가")
            
        }
    }

```


3. 해당 뷰컨은 메인에서 push 형태로 넘어오는 것이 아니지만 오른쪽에서 나오는 애니메이션이 필요하다. 따라서 메인 시간표 뷰에서 리스트 버튼을 누를 때는 아래와 같은 코드로 뷰컨을 전환 시켜주고,

```swift
 @IBAction func listBtn(_ sender: UIButton) {
    guard let nextVC = self.storyboard?.instantiateViewController(identifier: "timeTableListViewController") as? TimeTableListViewController else { return }
        
    nextVC.modalPresentationStyle = .fullScreen
        
    let transition = CATransition()
    transition.duration = 0.3
    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
    transition.type = CATransitionType.moveIn
    transition.subtype = CATransitionSubtype.fromRight
    view.window!.layer.add(transition, forKey: kCATransition)
        
    present(nextVC, animated: false, completion: nil)
        
}
```
시간표 리스트 뷰에서는 아래와 같은 코드로 뷰컨을 없애 준다.
```swift
private func dismissVC(){
        let transition: CATransition = CATransition()
        transition.duration = 0.3
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
               
        dismiss(animated: false, completion: nil)
    }
```


**결과 화면**

![ezgif com-video-to-gif (8)](https://user-images.githubusercontent.com/37260938/86836487-88dee780-c0d8-11ea-993e-82a74ac69444.gif)


<br>

**어려웠던 점/새로 배운 점**

메인에서 리스트 시간표로 전환을 할 때 navigation controller에서 push를 할 때 처럼 오른쪽에서 뷰컨이 나와야 해서 메인을 네비게이션으로 짜야하나,, 고민했다. 하지만 위에서 볼 수 있듯이 메인 뷰에 상단에 너무 많은 버튼과 라벨들이 있어서 그건 어렵다고 생각하였다. 그러다 CATransition을 구글링을 통해 알게 되었고, 해당 트랜지션 클래스를 통해 좀 더 편하게 원하는 것을 얻을 수 있었다.


<br>

----

<br>


### 4. 시간표 생성

#### 4-1. 시간표 리스트 띄우기


유링크 시간표 생성 - 시간표 리스트 띄우기 기능은 단순히 시간표를 리스트 업 해주는 것이 아니라, 시간표를 스와이프로 넘겨서 볼 수 있게 하고 현재 보고 있는 시간표에 과목을 추가할 수 있도록 하는 기능이다. 개발 과정은 다음과 같다.


**개발 과정**

1. 시간표 리스트는 collectionView로 제작하였으며, 속성 중 Paging Enabled를 true로 설정하고 cell의 inset과 width를 적절히 설정하여 시간표 하나하나가 마치 책 페이지 하나 처럼 넘어가도록 설정한다.

2. collectionViewCell은 시간표의 이름과 시간표 객체를 가지고 있다.

3. collectionView의 가장 마지막  cell은 시간표 시트를 추가할 수 있는 cell이며 didSelectRowAt 함수를 적절히 처리 해준다.

```swift
func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        if(indexPath.row < timeTableList.count){
            guard let createTimeTableCell : CreateTimeTableCell = timeTableCollectionView.dequeueReusableCell(withReuseIdentifier: "createTimeTableCell", for: indexPath) as? CreateTimeTableCell else {return CreateTimeTableCell()}
               
            let data = timeTableList[indexPath.row]
            
            createTimeTableCell.setCreateTimeTableCell(idx: data.scheduleIdx, name: data.name, subjectList:data.subjectList)
               
            return createTimeTableCell
        }else{
            guard let addSheetCell : CreateNewSheetCell = timeTableCollectionView.dequeueReusableCell(withReuseIdentifier: "createNewSheetCell", for: indexPath) as? CreateNewSheetCell else {return CreateNewSheetCell()}
                      
                    
            return addSheetCell
        }
    }

func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == timeTableList.count {
            
            addTimeTable()

        }
    }
```

4. 상단 버튼을 통해서도 시간표 시트를 추가할 수 있으므로 해당 버튼을 클릭해서 이름을 받아오면 collectionView의 dataList에 새로운 시간표 객체를 추가해주고 collectionView를 reload한다.

<br>

**어려웠던 점/새로 배운 점**

collectionView의 cell들은 한번에 N개씩 초기화가 및 생성이 되어서 데이터를 잘 가지고 있어도 reload를 제대로 해주지 않으면 N 단위로 같은 데이터를 가진 cell을 볼 수도 있다는 것을 알게 되었다. 따라서 새로 데이터가 업데이트될 때 마다 didSet을 이용해 계속 뷰를 업데이트 시켜 주었다.




<br>

#### 4-2. 과목 리스트 띄우기

과목 리스트는 1) 필터 및 검색,  2) 후보 두가지로 구성되어 있다. 리스트를 띄우는 뷰는 같은 tableView를 사용하며 통신을 통해 받아온 사용자 전공/학년 맞춤 결과, 필터 결과, 검색 결과, 후보 결과 데이터에 따라 다르게 뿌려준다. 



**개발 과정**

1. 과목 리스트는 tableView로 제작하였으며, 항상 같은 tableViewCell을 이용한다. tableViewCell의 높이는 클릭하면 늘어나야 하기 때문에, 과목을 클릭하면 cell안의 setState 함수를 통해 숨겨져 있던 버튼의 크기를 조절한다.
```swift
private func setSubjectInfoTableView(){
        subjectInfoTableView.bounces = false
       
        subjectInfoTableView.estimatedRowHeight = 86
        subjectInfoTableView.rowHeight = UITableView.automaticDimension
}
    
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) 
        tableView.beginUpdates()
        tableView.endUpdates()
}
```

2. 과목을 클릭했을 때 숨겨져 있던 강의평, 삭제, 후보에 담기, 시간표 등록 버튼이 나타나야 하고 해당 버튼이 클릭되었을 때는 이 tableView를 가지고 있는 ViewController에서 동작이 일어나야 하므로 tableViewCell에서 delegate패턴을 사용해서 액션을 처리한다.
```swift
protocol SubjectInfoCellDelegate {
    func showReview(idx: Int)
    func deleteSubject(idx: Int)
    func addCandidate(idx: Int)
    func enrollSubject(subjectIdx: Int, subjectItems: [SubjectModel])
}

```

<br>

**결과 화면**


![1번 ](https://user-images.githubusercontent.com/37260938/87796254-10201e00-c884-11ea-87a7-04814c019d73.gif)

![2번](https://user-images.githubusercontent.com/37260938/87796852-e3b8d180-c884-11ea-83a4-cb7ccf493d85.gif)



<br>

**어려웠던 점/새로 배운 점**

원래는 버튼이 있는 cell과 없는 cell을 아예 다른 Class의 cell로 만들어 주었다. 하지만 그렇게 하니, 여러 자잘한 오류가 발생되었다. 그래서 동적으로 높이를 조절해주고 버튼을 보였다가 안보였다가 해줄 수 있게 estimatedRowHeight 를 이용하였다. 해당 속성을 이용하려면 기기가 자동으로 cell의 높이를 계산해줄 수 있게 autoLayout을 잘 잡아주어야 한다.

<br>

----

<br>

### 5. 개인 일정 추가하기

개인 일정 추가는 1) 드래그로 추가, 2) 직접 입력해서 추가 두가지 형태가 있다.

#### 5-1. 드래그로 추가


**개발 과정**

1. ViewController에 TimeTable 객체를 미리 추가하고, 사용자가 개인 일정을 추가하고 싶어하는 시간표를 불러온다.

2. UILongPressGestureRecognizer를 timeTable CollectionView에 추가해서 0.5초 이상 클릭을 했을 때 드래그를 생성할 수 있도록 한다. 

```swift
public func setDrag(){	         collectionView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(longPress)))
    }
    
@objc func longPress(_ sender: UILongPressGestureRecognizer){
    
        let view = collectionView
        let touchLocation = sender.location(in: view)
               
        let posiX = touchLocation.x
        let posiY = touchLocation.y
        
        if(sender.state == .began){
            self.timeTable.makeStartPointFromDrag(input_x: posiX, input_y: posiY)
        }
        
        self.timeTable.makeHintTimeTableForDrag(input_x : posiX, input_y : posiY)
       
    }
```
드래그 시작점을 찍는 함수는 아래와 같다.
```swift
func makeStartPointFromDrag(input_x : CGFloat, input_y : CGFloat){
        
        var tempUserSchedule = TimeInfoModel.init()
        
        for weekdayIndex in 0 ... 6 {
            let base_x = collectionView.bounds.minX + widthOfTimeAxis + averageWidth * CGFloat(weekdayIndex) + rectEdgeInsets.left
            
            self.baseXList.append(base_x)
        }
        
        for i in 0 ... 6 {
            if i != 6 && self.baseXList[i] <= input_x && self.baseXList[i + 1] >= input_x {
                
                startPositionX = self.baseXList[i]
                tempUserSchedule.weekDay = i
                break
            }
        }
        
        let averageHeight = subjectItemHeight
        
        for hour in 9 ... 21 {
            for min in 0 ... 3 {
                let base_y = collectionView.frame.minY + heightOfDaySection + averageHeight * CGFloat(hour - 9) +
                    CGFloat((CGFloat(min * 15) / 60) * averageHeight)
                    
                let baseTime = String(hour) + ":" + String(min * 15)
                baseTimeList.append(baseTime)
    
                baseYList.append(base_y)
            }
        }
        
        for i in 0 ... baseYList.count - 1 {
                   
            if i != baseYList.count - 1 && baseYList[i] <= input_y && baseYList[i + 1] >= input_y {
                startPositionY = baseYList[i]
                
                tempUserSchedule.startTime = baseTimeList[i]
                break
            }
        }
        
        tempUserScheduleList.append(tempUserSchedule)
        delegate?.timeTableHintCount(hintCount: tempUserScheduleList.count)
    }
```



3. 시작점을 찍고 드래그한 제스쳐를 추적해서 x, y의 postition, width, height를 계산하고 계속 블록을 그려주고 업데이트 해준다. 과정은 아래 코드와 같다.

```swift
func makeHintTimeTableForDrag(input_x : CGFloat, input_y : CGFloat){
        
        let count = tempUserScheduleList.count
        for subview in collectionView.subviews{
        if (subview.tag == count){
                subview.removeFromSuperview()
            }
        }
        
        let width = averageWidth - ( rectEdgeInsets.left + rectEdgeInsets.right )
        
        var position_y : CGFloat = 0
        
        for i in 0 ... baseYList.count - 1 {
            if i != baseYList.count - 1 && baseYList[i] <= input_y && baseYList[i + 1] >= input_y {
                position_y = baseYList[i]
                tempUserScheduleList[count - 1].endTime = baseTimeList[i]
                break
            }
        }
        
        tempUserScheduleList[count - 1].timeIdx = count
        
        let height = position_y - startPositionY

        let view = UIView(frame: CGRect(x: startPositionX, y: startPositionY, width: width, height: height))
        view.backgroundColor = UIColor.black
        view.alpha = 0.3
        view.tag = count
        view.layer.cornerRadius = 8
        
        collectionView.addSubview(view)
    
    }
```

<br>

<hr>


#### 5-2. 직접 추가
시간표 생성 뷰에서 직접 추가하기 버튼을 누르거나, 드래그가 끝나고 상세 정보를 설정하고 싶을 때 넘어오는 뷰이다.

**개발 과정**

1. 해당 뷰에서 가장 중요한 시간 정보는 드래그로 블록을 생성하는 View에서 값을 전달 받거나, 직접 추가 시 PickerView로 시간을 설정해준다. 해당 정보들은 tableView를 통해 개발한다.

2.  개인 일정의 제목을 버튼을 통해 간편하게 설정하거나 textField에 입력을 받아서 설정한다. 단, 버튼을 클릭하면 textField의 값이 버튼의 값으로 바뀌고 textField의 값이 바뀌면 버튼이 해제 되어야 한다.

```swift
@objc func textFieldDidChange(textField: UITextField){
        if textField.text != "" {
            subjectName = textField.text!
            
            resetButton()
        }
    }
```
3. 정보를 모두 입력하고 확인 버튼을 누르면 드래그하는 뷰에서 온 경우 드래그 뷰에 개인 일정 블록을 생성할 수 있는 정보를 전달하고, 시간표 생성 뷰에서 온 경우 바로 다시 통신으로 시간표 리스트를 받아올 수 있게 한다.

<br>

**결과 화면**

![3번](https://user-images.githubusercontent.com/37260938/87797206-5a55cf00-c885-11ea-92a4-ce8fd311ee62.gif)



<br>

**어려웠던 점/새로 배운 점**
한번에 요일, 시간 2개를 입력 받기 위해 pickerView를 사용해야 했다. 이를 위해 pickerView를 커스텀 했다. 

<br>
7/17 리드미

