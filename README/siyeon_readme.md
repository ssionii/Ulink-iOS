시연이의 개발 일지 
===================

[26th SOPT APP-JAM]
팀 **유링크**의 iOS 개발자 🍎

## 개요

역할: 시간표 기능 구현

기간: 2020/06/28 ~
 
## 개발 내용

### 메인 시간표
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


-- 7/8까지의 내용 --
