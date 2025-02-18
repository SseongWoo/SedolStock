# 주식 시뮬레이터
## 세돌스탁
<img src = "https://github.com/user-attachments/assets/8a8fbb0f-8ebd-432c-bf9b-44a294c380e4" width="350" height="350">

## 설치 안내

### 🌐 Web 버전
- ⚠️ 해당 웹 버전은 **정식 버전이 아니며**, 모바일 UI 기반으로 이식되었습니다.  
  일부 기능이 정상적으로 작동하지 않을 수 있습니다.
- **업데이트 문제가 발생한다면, 쿠키 데이터를 삭제해 주세요.**

- 🔗 **[웹 바로가기](https://sedolstock.com/)**

### 🖥️ Windows 버전 
- 🔗 **[Windows 앱 다운로드](https://github.com/SseongWoo/SedolStock/releases)**

### 📱 Android 버전
- Google Play 스토어에서 다운로드하세요!  
<a href="https://play.google.com/store/apps/details?id=com.sedolstock.app" target="_blank">
  <img src="https://github.com/user-attachments/assets/cef364ec-5f9f-4756-a6c3-49d65bee3ad6" width="30%">
</a>

## 서버 프로젝트
[서버 프로젝트](https://github.com/SseongWoo/SedolStock_Server)


## 프로젝트 소개
- 이 프로젝트는 인터넷 방송인 우왁굳과 버츄얼 아이돌 그룹 이세계 아이돌의 유튜브 채널 활동을 기반으로 한 모의 투자 시뮬레이션 팬게임입니다.
유저는 각 유튜브 채널의 조회수와 좋아요 수 상승량을 바탕으로 가상의 주식을 매매하며 수익을 창출할 수 있습니다.
채널의 조회수 및 좋아요 수 변화 데이터를 활용해 주가가 실시간으로 변동되며, 5분마다 갱신되는 실제 유튜브 활동 데이터를 통해 더욱 생동감 있는 투자 경험을 제공합니다.
유저는 우왁굳과 이세계 아이돌 멤버 각각의 유튜브 채널을 투자 대상으로 선택할 수 있습니다. 또한, 게임 내 랭킹 시스템을 통해 다른 팬들과 겨루며 경쟁의 재미를 더합니다.

## 팀원 구성
| SSeongWoo | POUIUX |
|:------:|:------:|
| <img src="https://github.com/user-attachments/assets/8ab2e1e0-1263-43f3-a00b-76afed52a426" alt="SseongWoo" width="150"> | <img src="https://github.com/user-attachments/assets/2d407b5f-0e08-4359-9f77-95675754e703" alt="POUIUX" width="150"> |
| 개발 | 디자인 |
| [GitHub](https://github.com/SseongWoo) | [GitHub](https://github.com/POUIUX) |


## 개요
- 프로젝트 : 모의 투자 시뮬레이션 팬게임
- 분류 : 소규모 팀 프로젝트
- 제작기간 : 24.11~24.12
- 사용 IDE : Android Studio(프론트앤드), Visual Studio Code(백엔드)
- 사용 디바이스 : iPhone 16 pro max, Galaxy S23+, Galaxy Tap S9+, Galaxy Tap A7 Lite

## 기술스택
### 프론트엔드 (Frontend)
- 사용 기술:
    - Flutter (UI 프레임워크)
    - Dart (프로그래밍 언어)
    
- 사용 IDE:
    - Android Studio

### 백엔드 (Backend)
- 사용 기술:
    - Node.js (백엔드 런타임)
    - JavaScript (프로그래밍 언어)
    - Express (Node.js 기반 웹 프레임워크)
    - nginx (웹서버, 리버스 프록시)
    - RESTful API (API 설계 및 구현)
    - AWS S3 (파일 저장)
    - AWS CloudFront (콘텐츠 배포 네트워크)
    - AWS Route53 (도메인 관리)
    - AWS EC2 (서버 호스팅)
    - YouTube Data API v3 (유튜브 데이터 API)
    - Google Play Android Developer API (플레이스토어 데이터 API)
    - Firebase Authentication API (인증 서비스 API)
    - Firebase Cloud Firestore API (실시간 데이터베이스 API)
    - Firebase Realtime Database API (데이터 읽기/쓰기, 실시간 데이터 처리 API)
    
- 사용 IDE:
    - Visual Studio Code

## 개발환경
- Android Studio Koala Feature Drop 2024.1.2
- Visual Studio Code 1.95.1
- Flutter 3.24.4
- Dart 3.5.4
- Node.js 20.18.0
- Android 14.0, iOS 18

## 배포 환경
- 웹 애플리케이션 : AWS S3(파일 호스팅), AWS CloudFront(콘텐츠 전송)
- 모바일 애플리케이션 : Google Play(앱 배포)

## 주요 기능
- Firebase 인증을 통한 이메일 로그인 기능
- 유튜브 API를 통한 채널 및 동영상 데이터 수집
- Firebase Firestore를 활용한 데이터 관리
- 5분마다 갱신되는 실시간 데이터 기반 모의 투자
- 그래프를 활용한 데이터 시각화
- 웹 및 모바일 앱의 동시 배포
- Nginx, Express 및 AWS EC2를 통한 서버 배포
- HTTPS를 통한 백엔드와의 보안 통신

## 프로젝트 구성

### 프로젝트 구조
<img src = "https://github.com/user-attachments/assets/1ffee098-8365-4be3-b8e9-b76f6645d9c7" width="900" height="300">

- 프론트엔드 - 플러터를 사용하여 UI구현, 상태관리로 getX 사용, RESTful API 를 통해 백엔드와 데이터를 주고받음
- 백엔드 - AWS EC2에서 호스팅하고 Node.js를 사용해 프론트엔드에서 오는 요청을 처리, Firebase와 통신하여 데이터 저장 및 인증 처리.
- 데이터베이스 - Firestore 와 Realtime Database를 사용해 데이터를 저장 및 Authentication 으로 사용자 계정 관리

### 디렉토리 구조

#### 에셋 부분
```sh
assets
├── fonts      # 프로젝트 폰트 폴더
├── sound      # 사운드 폴더
└── image      # 프로젝트 이미지 폴더
    ├── fan    # 팬덤 이미지 폴더
    └── ui     # ui 구성 이미지 폴더
```

#### 뷰 부분
```sh
lib
├── view                                                      ## 뷰 폴더
│   ├── main                                            # 메인 폴더
│   │   ├── home                                  # 홈 탭 화면
│   │   │   ├── home_screen.dart
│   │   │   └── home_widget.dart
│   │   ├── information                           # 정보 탭 화면
│   │   │   ├── delete_account_screen.dart
│   │   │   ├── information_screen.dart
│   │   │   ├── information_widget.dart
│   │   │   ├── setting_app_screen.dart
│   │   │   └── setting_widget.dart
│   │   ├── main_screen.dart                      # 메인 화면
│   │   ├── notification                          # 알림 화면
│   │   │   ├── notification_screen.dart
│   │   │   └── notification_widget.dart
│   │   ├── property                                  # 내 지갑 탭 화면
│   │   │   ├── property_history_screen.dart
│   │   │   ├── property_history_widget.dart
│   │   │   ├── property_screen.dart
│   │   │   ├── property_stocklist_screen.dart
│   │   │   ├── property_stocklist_widget.dart
│   │   │   └── property_widget.dart
│   │   ├── ranking                                   # 랭킹 화면
│   │   │   ├── ranking_screen.dart
│   │   │   └── ranking_widget.dart
│   │   ├── event                                  # 이벤트 화면
│   │   │   ├── notice_screen.dart
│   │   │   └── notice_widget.dart
│   │   └── trade                                     # 거래 화면
│   │       ├── trade_dealing_screen.dart
│   │       ├── trade_dealing_widget.dart
│   │       ├── trade_detail_screen.dart
│   │       ├── trade_detail_widget.dart
│   │       ├── trade_screen.dart
│   │       └── trade_widget.dart
│   ├── sign                                                ## 계정 관련 폴더
│   │   ├── find                                      # 계정 찾기 화면
│   │   │   └── find_account_screen.dart
│   │   ├── signin                                    # 로그인 화면
│   │   │   ├── signin_screen.dart
│   │   │   └── signin_widget.dart
│   │   └── signup                                    # 회원가입 화면
│   │       ├── signup_checkemail_screen.dart
│   │       ├── signup_checkemail_widget.dart
│   │       ├── signup_choice_screen.dart
│   │       ├── signup_choice_widget.dart
│   │       ├── signup_screen.dart
│   │       └── signup_widget.dart
│   ├── splash_screen.dart                                  # 로딩 화면       
│   └── splash_widget.dart
```

#### 뷰모델 부분
```sh
lib                               # 로딩 화면
├── viewmodel                                                     ## 뷰모델 폴더
│   ├── main
│   │   ├── home_view_model.dart                      # 홈 탭 뷰모델
│   │   ├── information
│   │   │   ├── delete_account_view_model.dart  # 계정 삭제 뷰모델
│   │   │   ├── information_view_model.dart     # 정보 탭 뷰모델
│   │   │   └── setting_app_view_model.dart     # 상세 설정 뷰모델
│   │   ├── main_view_model.dart                      # 메인 뷰모델
│   │   ├── event_view_model.dart                      # 이벤트 뷰모델
│   │   ├── notification_view_model.dart              # 알림 뷰모델
│   │   ├── property
│   │   │   ├── property_history_view_model.dart    # 거래 내역 뷰모델
│   │   │   ├── property_stocklist_view_model.dart  # 보유 주식 뷰모델
│   │   │   └── property_view_model.dart            # 지갑 탭 뷰모델
│   │   ├── ranking_view_model.dart                       # 랭킹 탭 뷰모델
│   │   └── trade
│   │       ├── trade_dealing_view_model.dart             # 매매 뷰모델
│   │       ├── trade_detail_view_model.dart              # 종목 상세 뷰모델
│   │       └── trade_view_model.dart                     # 거래 탭 뷰모델
│   ├── sign
│   │   ├── find_account_view_model.dart                  # 계정 찾기 뷰모델
│   │   ├── signin_view_model.dart                        # 로그인 뷰모델
│   │   ├── signup_checkemail_view_model.dart             # 이메일 인증 뷰모델
│   │   ├── signup_choice_view_model.dart                 # 이메일,게스트 선택 뷰모델
│   │   └── signup_view_model.dart                        # 회원가입 뷰모델
│   └── splash_view_model.dart                                  # 로딩 뷰모델
```

#### 모델 부분
```sh
lib
├── model                                           ## 모델 파일 폴더
│   ├── data                                  ## 앱 구성 데이터 모델 폴더
│   │   ├── data_class.dart             # 앱 구성 데이터 클래스 파일
│   │   └── data_model.dart             # 앱 구성 데이터 모델
│   ├── main                                  ## 앱 메인 화면 모델 폴더
│   │   ├── information_model.dart      # 정보 탭 화면 모델
│   │   ├── notification_model.dart     # 알림 화면 모델
│   │   └── trade_model.dart            # 거래 탭 모델
│   ├── scarch_name_model.dart                # 이름 검색 모델
│   ├── sign                                  ## 계정 부분 폴더
│   │   ├── find_account_model.dart     # 계정 찾기 모델
│   │   ├── signin_model.dart           # 로그인 모델
│   │   └── signup_model.dart           # 회원가입 모델
│   └── splash_model.dart                     # 로딩 화면 모델
```

#### 그 외
```sh
lib
├── constants                                       ## 상수 데이터 폴더
│   ├── color_constants.dart                  # 색상
│   ├── data_constants.dart                   # 데이터
│   └── route_constants.dart                            # 화면 경로 설정 파일
├── data                                            ## 앱 구성 데이터 폴더
│   ├── my_data.dart                          # 사용자 데이터 파일
│   ├── public_data.dart                      # 공통 데이터 파일
│   ├── start_data.dart                       # 앱을 실행, 특정 실행으로 데이터를 호출하는 파일
│   └── youtube_data.dart                     # 유튜브 데이터 파일
├── main.dart
├── service                                         
│   ├── http_service.dart                     # 외부와 통신하는 파일
│   └── storage_service.dart                  # 로컬에 데이터를 저장하거나 불러오는 기능
├── utils                                           ## 다양한 기능 관련 폴더
│   ├── audio.dart                            # 소리 기능
│   ├── change_fandom.dart                    # 팬덤 변경 기능
│   ├── check_list.dart                       # 기기의 플랫폼, 앱 버전, 서버 구동 상태를 확인하는 기능
│   ├── color.dart                            # 색 설정 기능
│   ├── custom_scroll.dart                    # 웹에서도 스크롤이 동작하게 하는 기능
│   ├── date_time.dart                        # 날짜 형식을 변경하는 기능
│   ├── format.dart                           # 데이터 형식을 변경하는 기능
│   ├── get_env.dart                          # 환경변수 파일에서 데이터를 가져오는 기능
│   ├── screen_size.dart                      # 화면 사이즈를 가져와 ui의 크기를 설정하는 기능
│   ├── search_name.dart                      # 중복 닉네임 확인 기능
│   └── timer.dart                            # 타이머 기능
└── widget                                                            ## 재사용 위젯 폴더
    ├── button.dart                                                   # 버튼 위젯
    ├── divider.dart                                                  # 구분선 위젯
    ├── listview_item.dart                                            # 리스트뷰 아이템 위젯
    └── simple_widget.dart                                            # 간단한 다이얼로그, 스낵바 위젯
```
<details><summary>전체 구조</summary>

```sh
lib
├── constants                                       ## 상수 데이터 폴더
│   ├── color_constants.dart                  # 색상
│   ├── data_constants.dart                   # 데이터
│   └── route_constants.dart                  # 화면 경로
├── data                                            ## 앱 구성 데이터 폴더
│   ├── my_data.dart                          # 사용자 데이터 파일
│   ├── public_data.dart                      # 공통 데이터 파일
│   ├── start_data.dart                       # 앱을 실행, 특정 실행으로 데이터를 호출하는 파일
│   └── youtube_data.dart                     # 유튜브 데이터 파일
├── main.dart
├── view                                                      ## 뷰 폴더
│   ├── main                                            # 메인 폴더
│   │   ├── home                                  # 홈 탭 화면
│   │   │   ├── home_screen.dart
│   │   │   └── home_widget.dart
│   │   ├── information                           # 정보 탭 화면
│   │   │   ├── delete_account_screen.dart
│   │   │   ├── information_screen.dart
│   │   │   ├── information_widget.dart
│   │   │   ├── setting_app_screen.dart
│   │   │   └── setting_widget.dart
│   │   ├── main_screen.dart                      # 메인 화면
│   │   ├── notification                          # 알림 화면
│   │   │   ├── notification_screen.dart
│   │   │   └── notification_widget.dart
│   │   ├── property                                  # 내 지갑 탭 화면
│   │   │   ├── property_history_screen.dart
│   │   │   ├── property_history_widget.dart
│   │   │   ├── property_screen.dart
│   │   │   ├── property_stocklist_screen.dart
│   │   │   ├── property_stocklist_widget.dart
│   │   │   └── property_widget.dart
│   │   ├── ranking                                   # 랭킹 화면
│   │   │   ├── ranking_screen.dart
│   │   │   └── ranking_widget.dart
│   │   ├── event                                  # 이벤트 화면
│   │   │   ├── notice_screen.dart
│   │   │   └── notice_widget.dart
│   │   └── trade                                     # 거래 화면
│   │       ├── trade_dealing_screen.dart
│   │       ├── trade_dealing_widget.dart
│   │       ├── trade_detail_screen.dart
│   │       ├── trade_detail_widget.dart
│   │       ├── trade_screen.dart
│   │       └── trade_widget.dart
│   ├── sign                                                ## 계정 관련 폴더
│   │   ├── find                                      # 계정 찾기 화면
│   │   │   └── find_account_screen.dart
│   │   ├── signin                                    # 로그인 화면
│   │   │   ├── signin_screen.dart
│   │   │   └── signin_widget.dart
│   │   └── signup                                    # 회원가입 화면
│   │       ├── signup_checkemail_screen.dart
│   │       ├── signup_checkemail_widget.dart
│   │       ├── signup_choice_screen.dart
│   │       ├── signup_choice_widget.dart
│   │       ├── signup_screen.dart
│   │       └── signup_widget.dart
│   ├── splash_screen.dart                                  # 로딩 화면       
│   └── splash_widget.dart
├── model                                           ## 모델 파일 폴더
│   ├── data                                  ## 앱 구성 데이터 모델 폴더
│   │   ├── data_class.dart             # 앱 구성 데이터 클래스 파일
│   │   └── data_model.dart             # 앱 구성 데이터 모델
│   ├── main                                  ## 앱 메인 화면 모델 폴더
│   │   ├── information_model.dart      # 정보 탭 화면 모델
│   │   ├── notification_model.dart     # 알림 화면 모델
│   │   └── trade_model.dart            # 거래 탭 모델
│   ├── scarch_name_model.dart                # 이름 검색 모델
│   ├── sign                                  ## 계정 부분 폴더
│   │   ├── find_account_model.dart     # 계정 찾기 모델
│   │   ├── signin_model.dart           # 로그인 모델
│   │   └── signup_model.dart           # 회원가입 모델
│   └── splash_model.dart                     # 로딩 화면 모델
├── viewmodel                                                     ## 뷰모델 폴더
│   ├── main
│   │   ├── home_view_model.dart                      # 홈 탭 뷰모델
│   │   ├── information
│   │   │   ├── delete_account_view_model.dart  # 계정 삭제 뷰모델
│   │   │   ├── information_view_model.dart     # 정보 탭 뷰모델
│   │   │   └── setting_app_view_model.dart     # 상세 설정 뷰모델
│   │   ├── main_view_model.dart                      # 메인 뷰모델
│   │   ├── event_view_model.dart                      # 이벤트 뷰모델
│   │   ├── notification_view_model.dart              # 알림 뷰모델
│   │   ├── property
│   │   │   ├── property_history_view_model.dart    # 거래 내역 뷰모델
│   │   │   ├── property_stocklist_view_model.dart  # 보유 주식 뷰모델
│   │   │   └── property_view_model.dart            # 지갑 탭 뷰모델
│   │   ├── ranking_view_model.dart                       # 랭킹 탭 뷰모델
│   │   └── trade
│   │       ├── trade_dealing_view_model.dart             # 매매 뷰모델
│   │       ├── trade_detail_view_model.dart              # 종목 상세 뷰모델
│   │       └── trade_view_model.dart                     # 거래 탭 뷰모델
│   ├── sign
│   │   ├── find_account_view_model.dart                  # 계정 찾기 뷰모델
│   │   ├── signin_view_model.dart                        # 로그인 뷰모델
│   │   ├── signup_checkemail_view_model.dart             # 이메일 인증 뷰모델
│   │   ├── signup_choice_view_model.dart                 # 이메일,게스트 선택 뷰모델
│   │   └── signup_view_model.dart                        # 회원가입 뷰모델
│   └── splash_view_model.dart                                  # 로딩 뷰모델
├── service                                         
│   ├── http_service.dart                     # 외부와 통신하는 파일
│   └── storage_service.dart                  # 로컬에 데이터를 저장하거나 불러오는 기능
├── utils                                           ## 다양한 기능 관련 폴더
│   ├── audio.dart                            # 소리 기능
│   ├── change_fandom.dart                    # 팬덤 변경 기능
│   ├── check_list.dart                       # 기기의 플랫폼, 앱 버전, 서버 구동 상태를 확인하는 기능
│   ├── color.dart                            # 색 설정 기능
│   ├── custom_scroll.dart                    # 웹에서도 스크롤이 동작하게 하는 기능
│   ├── date_time.dart                        # 날짜 형식을 변경하는 기능
│   ├── format.dart                           # 데이터 형식을 변경하는 기능
│   ├── get_env.dart                          # 환경변수 파일에서 데이터를 가져오는 기능
│   ├── screen_size.dart                      # 화면 사이즈를 가져와 ui의 크기를 설정하는 기능
│   ├── search_name.dart                      # 중복 닉네임 확인 기능
│   └── timer.dart                            # 타이머 기능
└── widget                                      ## 재사용 위젯 폴더
    ├── button.dart                             # 버튼 위젯
    ├── divider.dart                            # 구분선 위젯
    ├── listview_item.dart                      # 리스트뷰 재사용 위젯
    └── simple_widget.dart                      # 간단한 다이얼로그, 스낵바 위젯
```

</details>



### 화면 구성
<details><summary>로그인 부분</summary>
    
|로딩|로그인|
|:---:|:---:|
|<img src = "https://github.com/user-attachments/assets/0ea46979-759c-4d6f-8ca1-9f23888a2928" width="350" height="750">|<img src = "https://github.com/user-attachments/assets/1d5d29b5-4c8e-42dd-85a9-3141d5b0a1f7" width="350" height="750">|
|회원가입 1단계|회원가입 2단계|
|<img src = "https://github.com/user-attachments/assets/931ab878-e75c-4782-a9f6-fcc87e5dd8fc" width="350" height="750">|<img src = "https://github.com/user-attachments/assets/fe522b0a-8393-42e0-b119-d58eafbc700c" width="350" height="750">|
|회원가입 3단계|비밀번호 찾기|
|<img src = "https://github.com/user-attachments/assets/1bc58f66-cf73-43a4-85d0-2db179d70c58" width="350" height="750">|<img src = "https://github.com/user-attachments/assets/17aae111-271f-4415-bffa-40c315b08d65" width="350" height="750">|
</details>

<details><summary>메인 화면 부분</summary>
    
|홈 탭|랭킹 탭|
|:---:|:---:|
|<img src = "https://github.com/user-attachments/assets/06b6e8cb-77d5-4a72-8615-ce90d3c48205" width="350" height="750">|<img src = "https://github.com/user-attachments/assets/5920e47f-5ee2-428f-ac1d-02539c0e43b1" width="350" height="750">|
|지갑 탭 주식잔고|지갑 탭 거래내역|
|<img src = "https://github.com/user-attachments/assets/8f25ad5e-be3d-48b5-a789-606b5ab7f0ca" width="350" height="750">|<img src = "https://github.com/user-attachments/assets/40b8f166-3443-4b4f-814c-160fc9793649" width="350" height="750">|
|알림 화면||
|<img src = "https://github.com/user-attachments/assets/d00a1aeb-b133-47c4-a619-efee416616e0" width="350" height="750">|<img src = "" width="350" height="750">|
</details>

<details><summary>거래 화면 부분</summary>
    
|거래 탭|종목 상세 정보|
|:---:|:---:|
|<img src = "https://github.com/user-attachments/assets/6098b688-04e4-43c6-81de-d00d3d4a0fc3" width="350" height="750">|<img src = "https://github.com/user-attachments/assets/98a12325-d0f9-4dcd-9cb4-802698e8e54c" width="350" height="750">|
|종목 판매|종목 구매|
|<img src = "https://github.com/user-attachments/assets/567f8c67-9067-4e82-9629-a29173f1c0fc" width="350" height="750">|<img src = "https://github.com/user-attachments/assets/f539ab57-9734-4f33-8c62-afbf8d0168cf" width="350" height="750">|
|종목 판매 확인|종목 구매 확인|
|<img src = "https://github.com/user-attachments/assets/ec9f39b6-a6e6-435f-9391-7226d2da1bfa" width="350" height="750">|<img src = "https://github.com/user-attachments/assets/e07bba20-8cb2-4a5f-9f6b-d2d484e42d58" width="350" height="750">|
</details>

<details><summary>정보 화면 부분</summary>
    
|정보 탭|관리 화면|
|:---:|:---:|
|<img src = "https://github.com/user-attachments/assets/acc470de-0a61-4f25-b0a5-e15245505991" width="350" height="750">|<img src = "https://github.com/user-attachments/assets/1dcf662a-c19d-437f-bc38-0f3836063918" width="350" height="750">|
|이름 변경|팬덤 변경|
|<img src = "https://github.com/user-attachments/assets/d41e25a2-7371-415e-801e-656a9ba49ed6" width="350" height="750">|<img src = "https://github.com/user-attachments/assets/331a0cd8-0f91-494c-8577-734c9995eb54" width="350" height="750">|
|회원 탈퇴||
|<img src = "https://github.com/user-attachments/assets/ea065213-09dc-419e-8017-3fb922ac8a23" width="350" height="750">|
</details>

### 사용한 라이브러리
```sh
cupertino_icons: ^1.0.8             # 더 다양한 아이콘 라이브러리
get:                                # 상태변환 관리 라이브러리
auto_size_text: ^3.0.0              # 텍스트 크기를 자동으로 조정하는 라이브러리
horizontal_data_table: ^4.3.1       # 가로로 스크롤 가능한 데이터 테이블 라이브러리
http:                               # HTTP 요청 라이브러리
flutter_secure_storage:             # 안전한 데이터 저장을 위한 라이브러리
flutter_easyloading: ^3.0.5         # 로딩 화면 표시를 위한 라이브러리
intl:                               # 날짜 및 숫자 형식화를 지원하는 라이브러리
korean_profanity_filter: ^1.0.0     # 한국어 비속어 필터링 라이브러리
profanity_filter: ^2.0.0            # 다국어 비속어 필터링 라이브러리
url_launcher:                       # URL을 열기 위한 라이브러리
get_storage: ^2.1.1                 # 경량화된 로컬 데이터 저장 라이브러리
flutter_dotenv: ^5.2.1              # 환경 변수 관리 라이브러리
font_awesome_flutter: ^10.8.0       # FontAwesome 아이콘 라이브러리
logger: ^2.5.0                      # 로그 기록 및 디버깅용 라이브러리
package_info_plus: ^8.1.1           # 앱의 패키지 정보 가져오는 라이브러리
fl_chart: ^0.69.2                   # 플러터용 차트 생성 라이브러리
badges: ^3.1.2                      # 배지 위젯 라이브러리
just_audio: ^0.9.42                 # 오디오 재생 라이브러리
store_redirect: ^2.0.3              # 앱 스토어에 바로 리다이렉트하는 기능의 라이브러리
```
