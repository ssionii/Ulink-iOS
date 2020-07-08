
# Ulink - iOS : 송지훈 개발일지
#### 🧑🏻‍💻왕초보 iOS 개발자의 무대뽀 & 무한긍정 아요 개발 일지🧑🏻‍💻

[개인 레포 이동하기](https://github.com/i-colours-u)


맡은 역할 : 
앱 - Firebase 연동
채팅방
공지사항


### INDEX



구현 내용       |    상세 내용
-----------  |  -------------------------
[파이어베이스 연동 ](#1.Firebase-Setting)  | Firebase를 연동해 유저 회원가입 및 로그인을 합니다.
[회원가입 및 로그인 ](#1.Signup-Login)  | Firebase를 연동해 유저 회원가입 및 로그인을 합니다.
[채팅방 생성 및 메세지 보내기](#2.Chatting)  | 각 과목별로 채팅방을 생성하고 채팅방에 입장, 메세지를 보냅니다.
[공지사항 뷰 만들기](#3.Notice)  | tableView를 활용해 공지사항을 보여줍니다.



해당 내용을 클릭하면, 하단에 있는 목록으로 이동합니다!

(파트장님 이걸 보고 있다면 당근(🥕)을 보내주세요 ^^)



_________________
### 0.Firebase-Setting

#### Firebase을 앱과 연동합니다

<img width="1000" alt="스크린샷 2020-07-08 오전 4 14 39" src="https://user-images.githubusercontent.com/60260284/86831199-9349b300-c0d1-11ea-89db-c5a7d004367d.png">
<br>
GoogleService-Info.plist 파일 등록 후

```Swfit
pod Firebase
pod install
```
Firebase 설치 이후,
```Swift
var ref: DatabaseReference!

ref = Database.database().reference()
```
로 변수를 선언 한뒤, firebase에 접근 할 수 있게 됩니다.


_________________





### 1.Signup-Login


#### Firebase를 연동해 유저 회원가입 및 로그인을 합니다.



<br>




📱해당 뷰
<div>
<img width="360" alt="스크린샷 2020-07-08 오전 2 26 27" src="https://user-images.githubusercontent.com/60260284/86819879-38a95a80-c0c3-11ea-956e-a2f05592f928.png">
<img width="360" alt="스크린샷 2020-07-08 오전 2 39 51" src="https://user-images.githubusercontent.com/60260284/86820837-8f636400-c0c4-11ea-8c6c-1a6a998bf32b.png">
</div>
<br>
(놀랍게도 위 버튼이 로그인 버튼이고 아래 버튼이 회원가입 버튼입니다)<br>
(로그인 회원가입 뷰가 나오지 않아서 틀만 구성 했습니다~~~~)
<br>
(앱잼기간동안의 제 마음가짐을 잘 담아보았습니다...^^*)<br>

<br>

##### 회원가입 후, 파이어베이스에 유저 등록
```Swift
   
import Firebase

let remoteConfig = RemoteConfig.remoteConfig() 


    @IBAction func signupButtonClicked(_ sender: Any) {
        
        
        Auth.auth().createUser(withEmail: signupIdTextField.text!, password: signupPwTextField.text!) { (user,err) in
            // 이메일 비밀번호 형태로 유저 생성 후,
            
            let uid = user?.user.uid
            
            let values = ["userName":self.signupNameTextField.text!, "uid":Auth.auth().currentUser?.uid]
            
            Database.database().reference().child("users").child(uid!).setValue(values, withCompletionBlock: { (err,ref) in
                
                //firebase 실시간 데이터베이스에 userdata를 등록한다.
                if(err != nil){
                    print("error")
                }
                else
                {
                    self.dismiss(animated: true, completion: nil)
                } // 에러가 뜨지 않고 성공적으로 가입이 된다면, 회원가입 창을 종료한다.
                
            })
            print(uid as Any)
        }
    }
            
            

```
<br>

 ##### 로그인 후 메인뷰로 넘어가기


```Swift
        Auth.auth().addStateDidChangeListener{ (auth, user) in  //이벤트를 감지한 뒤에,
            if(user != nil){ // 유저가 존재한다면,
                print(" login Success ")
                let homeview = self.storyboard?.instantiateViewController(withIdentifier: "homeTabBarController")
                homeview?.modalPresentationStyle = .fullScreen
                self.present(homeview!, animated: true, completion: nil)
            } // 홈 탭바로 이동한다
        }
        

    }
    
    
    
    @IBAction func loginButtonClicked(_ sender: Any) { // 로그인 버튼을 누르면
        
        Auth.auth().signIn(withEmail: nameTextField.text!, password: pwTextField.text!) {( user, err) in
//텍스트 필드에 올라와 있는 텍스트를 넣고 로그인을 한다.
            if(err != nil) {

                let alert = UIAlertController(title: "에러", message: err.debugDescription, preferredStyle: UIAlertController.Style.alert)

                alert.addAction(UIAlertAction(title: "확인",style: UIAlertAction.Style.default, handler: nil))

                self.present(alert, animated: true, completion: nil)

            }// 에러가 발생하면 AlertController를 이용해서 오류를 띄운다.

        }
    }
    
```




________________


#### 2.Chatting
##### 각 과목별로 채팅방을 생성하고 채팅방에 입장, 메세지를 보냅니다.

📱해당 뷰
<img width="400" alt="스크린샷 2020-07-08 오전 4 19 45" src="https://user-images.githubusercontent.com/60260284/86831787-4adec500-c0d2-11ea-819a-33c20dee539a.png">
(모든 뷰는 이후 수정될 예정입니다.. to be continued....)
(성장하는 모습이 멋진거죠 암...)


<img width="935" alt="스크린샷 2020-07-08 오전 4 28 37" src="https://user-images.githubusercontent.com/60260284/86832702-7f9f4c00-c0d3-11ea-9a01-d299a879d1b9.png">

firebase 내에서 chatrooms 구조도는 다음과 같습니다
comments - message 내에 사용자의 전달 메세지가 담기고, uid에 보내는 사람의 uid가 저장이 됩니다.
이후에 보낸 시간 정보까지 확장 할 예정입니다.



```Swift 
    
    func setChattingData(){
        
        
            self.ref = Database.database().reference().child("chatrooms")
            
            
            
            
            ref.observeSingleEvent(of: .value) { (snapshot) in

                let values = snapshot.value

                let dic = values as! [String: [String:Any]]

                for index in dic{



                    if (index.value["title"] as? String != nil){

                        
                        let data = ClassModel(name: index.value["title"] as! String, key: index.key , image:.one)
                        
                        self.array_class.append(data)
                        
                        DispatchQueue.main.async{
                            self.chattingListTable.reloadData()
                            
                        }           // chattingListtable을 다시 reload 해줘서 메인에서 채팅방 목록이 뜨게 해야 한다!!!

                        
                        
                        

                    }
                    
                }
        }
        
        

    }
```
<code> observeSingleEvent </code> 를 활용해 데이터를 읽어와 title이 비어있지 않은 부분에 대해서 classModel를 만들어 채팅방 목록을 형성합니다.

```Swift
DispatchQueue.main.async{
                            self.chattingListTable.reloadData()

 }  
```
를 활용해서 특정 함수 내에서 완료 되었을 때 테이블 데이터를 갱신합니다.









________________


#### 3.Notice
##### tableView를 활용해 공지사항을 보여줍니다.
<br>

📱해당 뷰
<br>
<div>
<img width="360" alt="스크린샷 2020-07-08 오전 4 35 52" src="https://user-images.githubusercontent.com/60260284/86833511-92fee700-c0d4-11ea-8e46-33556fa84314.png">
<img width="360" alt="스크린샷 2020-07-08 오전 4 35 57" src="https://user-images.githubusercontent.com/60260284/86833515-94301400-c0d4-11ea-87b2-70e80315d5d1.png">
</div>

카카오톡 파일 및 사진 보기 형태처럼 우측에서 뷰가 나타나는 형식입니다.
수업 공지를 누르면 해당 공지뷰로 이동하게 됩니다.


#### 우측 햄버거 메뉴 생성

```Swift
import SideMenu

    @IBAction func sideMenuClicked(_ sender : Any) {
        
        let vc = storyboard!.instantiateViewController(withIdentifier: "chattingSideViewController") as! rightSideMenuViewController                    // UIViewController 지정해주고
        let menu = SideMenuNavigationController(rootViewController: vc)     // rootViewController에 넣어준다
        
        menu.presentationStyle = .menuSlideIn  // 보여주는 스타일 지정
        menu.statusBarEndAlpha = .zero          // 상태창 보여주고 싶을 때 설정
        
        
        menu.menuWidth = self.view.frame.width * 0.8 // 80퍼센트 만큼 보여주기
        
        menu.presentDuration = 0.8 //  나타내는거 보여주는데 걸리는 시간
        menu.dismissDuration = 0.8 //  사라지는ep 보여주는데 걸리는 시간
        menu.completionCurve = .easeInOut
        
  
```

sideMenu 라이브러리를 활용해서 우측에서 나타나는 뷰를 구현했습니다.


#### popup modal 구현

```Swift
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // 해당 테이블 누르면 
        
        
        let storyBoard = UIStoryboard.init(name: "Chatting", bundle: nil)
        let popupVC = storyBoard.instantiateViewController(withIdentifier: "PopupViewController")
        popupVC.modalPresentationStyle = .overCurrentContext
		        popupVC.modalTransitionStyle = .crossDissolve// 자연스러운 popup을 구현하기 위해 .crossDissolve 활용
        present(popupVC, animated: true, completion: nil)
    }
    
   
``` 
    

________________


#### 기타 활용한 코드 정리

테이블 뷰 사이에 separator 없애기

```Swift
여기에만든테이블뷰아울렛.separatorStyle = .none
```

<br>
"duplicate symbols for x86_64" 오류 —- (Pod 라이브러리 꼬임 문제)

```Swift
sudo gem install cocoapods-deintegrate cocoapods-clean

pod deintegrate
pod clean

pod install
```
여러 라이브러리를 설치할때 중복 파일 설치 문제로 꼬이는 문제 발생했을 때에는 

팟을 전부 지워버리고 다시 재설치하면 문제가 해결됨



