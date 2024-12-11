# 주식 시뮬레이터
## 세돌스탁
<img src = "https://github.com/user-attachments/assets/8a8fbb0f-8ebd-432c-bf9b-44a294c380e4" width="350" height="350">

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
- 사용기술 : Flutter, Dart, JavaScript, Node.js, AWS EC2, FireBase Authentication, FireBase Cloud Firestore
- 사용 IDE : Android Studio(프론트앤드), Visual Studio Code(백엔드)
- 사용 디바이스 : iPhone 16 pro max, Galaxy S23+, Galaxy Tap S9+, Galaxy Tap A7 Lite

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
### 디렉토리 구조
```sh
assets
├── fonts      # 프로젝트 폰트 폴더
└── image      # 프로젝트 이미지 폴더
    ├── fan    # 팬덤 이미지 폴더
    └── ui     # ui 구성 이미지 폴더
```

```sh
lib
├── data                                        # 앱 구성 데이터 폴더
│   ├── my_data.dart                            # 사용자 데이터 파일
│   ├── public_data.dart                        # 전역 변수 데이터 파일
│   ├── start_data.dart                         # 앱을 실행할 때 호출되는 파일
│   └── youtube_data.dart                       # 유튜브 데이터 파일
├── login
│   ├── find_account                            # 계정 찾기 파일 
│   │   ├── find_account_screen.dart
│   │   ├── find_account_system.dart
│   │   └── find_account_widget.dart
│   ├── login                                   # 로그인 파일
│   │   ├── login_screen.dart  
│   │   ├── login_system.dart
│   │   └── login_widget.dart
│   └── signup                                  # 회원가입 파일
│       ├── 1_choice                            # 회원가입중 이메일, 게스트 로그인 선택 단계 파일
│       │   ├── signup_choice_screen.dart
│       │   ├── signup_choice_system.dart
│       │   └── signup_choice_widget.dart
│       ├── 2_main                              # 회원가입중 사용자 로그인 데이터를 입력하는 단계 파일
│       │   ├── signup_screen.dart
│       │   ├── signup_system.dart
│       │   └── signup_widget.dart
│       ├── 3_checkemail                        # 회원가입중 이메일 로그인일때 이메일 인증 단계 파일  
│       │   ├── signup_checkemail_screen.dart
│       │   ├── signup_checkemail_system.dart
│       │   └── signup_checkemail_widget.dart
│       └── 4_setdata                           # 회원가입중 사용자 구성 데이터를 입력하는 단계 파일
│           ├── signup_setdata_screen.dart
│           ├── signup_setdata_system.dart
│           └── signup_setdata_widget.dart
├── main                                        # 메인 화면 파일
│   ├── home                                    # 홈 탭 화면 파일
│   │   ├── home_screen.dart
│   │   ├── home_system.dart
│   │   └── home_widget.dart
│   ├── information                             # 정보 탭 화면 파일
│   │   ├── information_screen.dart
│   │   ├── information_system.dart
│   │   ├── information_widget.dart
│   │   ├── setting                             # 상세 설정 화면 파일
│   │   │   ├── setting_screen.dart
│   │   │   ├── setting_system.dart
│   │   │   └── setting_widget.dart
│   │   └── withdrawal                          # 회원 탈퇴 화면 파일
│   │       ├── withdrawal_screen.dart
│   │       └── withdrawal_system.dart
│   ├── main_screen.dart
│   ├── main_system.dart
│   ├── ranking                                 # 랭킹 탭 화면 파일
│   │   ├── ranking_screen.dart
│   │   ├── ranking_system.dart
│   │   └── ranking_widget.dart
│   ├── trade                                   # 거래 탭 화면 파일
│   │   ├── detail                              # 아이템 상세 화면 파일
│   │   │   ├── trade_detail_screen.dart
│   │   │   ├── trade_detail_system.dart
│   │   │   └── trade_detail_widget.dart
│   │   ├── trade_screen.dart
│   │   ├── trade_system.dart
│   │   ├── trade_widget.dart
│   │   └── transaction                         # 아이템 매매 화면 파일
│   │       ├── transaction_screen.dart
│   │       ├── transaction_system.dart
│   │       └── transaction_widget.dart
│   └── wallet                                  # 사용자 자산 화면 파일
│       ├── stockhistory                        # 사용자 아이템 매매 내역 화면 파일
│       │   ├── stockhistory_screen.dart
│       │   ├── stockhistory_system.dart
│       │   └── stockhistory_widget.dart
│       ├── stocklist                           # 사용자 보유 아이템 내역 화면 파일
│       │   ├── stocklist_screen.dart
│       │   ├── stocklist_system.dart
│       │   └── stocklist_widget.dart
│       ├── wallet_screen.dart
│       ├── wallet_system.dart
│       └── wallet_widget.dart
├── main.dart
├── splash                                      # 앱 로딩화면 파일 
│   ├── splash_screen.dart
│   ├── splash_system.dart
│   └── splash_widget.dart
└── utils                                       # 다양한 기능 관련 파일
    ├── check_list.dart                         # 기기의 플랫폼, 앱 버전, 서버 구동 상태를 확인하는 기능
    ├── color.dart                              # 색 설정 파일
    ├── custom_scroll.dart                      # 웹에서도 스크롤이 동작하게 하는 기능
    ├── data_storage.dart                       # 기기에 데이터를 저장하게 하는 기능
    ├── date_time.dart                          # 날짜 형식을 변경하는 기능
    ├── format.dart                             # 데이터 형식을 변경하는 기능
    ├── get_env.dart                            # 환경변수 파일에서 데이터를 가져오는 기능
    ├── screen_size.dart                        # 화면 사이즈를 가져와 ui의 크기를 설정하는 기능
    ├── search_name.dart                        # 중복 닉네임 확인 기능
    ├── simple_widget.dart                      # 자주 사용되는 간단한 위젯
    └── timer.dart                              # 타이머 기능
```
### 화면 구성
<details><summary>로그인 부분</summary>
    
|로딩|로그인|
|:---:|:---:|
|<img src = "https://github.com/user-attachments/assets/0ea46979-759c-4d6f-8ca1-9f23888a2928" width="350" height="750">|<img src = "https://github.com/user-attachments/assets/1d5d29b5-4c8e-42dd-85a9-3141d5b0a1f7" width="350" height="750">|
|회원가입 1단계|회원가입 2단계|
|<img src = "https://github.com/user-attachments/assets/931ab878-e75c-4782-a9f6-fcc87e5dd8fc" width="350" height="750">|<img src = "https://github.com/user-attachments/assets/a71e3b36-67d4-4b4c-8685-e6d5cb542aa0" width="350" height="750">|
|회원가입 3단계|회원가입 4단계|
|<img src = "https://github.com/user-attachments/assets/308d267e-c079-4856-85b9-f89511a85fde" width="350" height="750">|<img src = "https://github.com/user-attachments/assets/fc703f4d-3c6e-4140-a506-bc6c57bf714b" width="350" height="750">|
|비밀번호 찾기||
|<img src = "https://github.com/user-attachments/assets/5a545793-37c1-4c86-a7e5-32a5fbff40e1" width="350" height="750">||
</details>

<details><summary>메인 화면 부분</summary>
    
|홈 탭|랭킹 탭|
|:---:|:---:|
|<img src = "https://github.com/user-attachments/assets/f902e00b-c17d-42fd-9406-1188aae330e7" width="350" height="750">|<img src = "https://github.com/user-attachments/assets/de211c84-1a37-4a05-821f-c3c7ec193237" width="350" height="750">|
|지갑 탭 주식잔고|지갑 탭 거래내역|
|<img src = "https://github.com/user-attachments/assets/76fbd07d-a2dd-4dbb-90c2-6fd93e40aac1" width="350" height="750">|<img src = "" width="350" height="750">|
</details>

<details><summary>거래 화면 부분</summary>
    
|거래 탭|종목 상세 정보|
|:---:|:---:|
|<img src = "https://github.com/user-attachments/assets/d9c6640a-8880-45e6-ac53-79358bc01fcc" width="350" height="750">|<img src = "https://github.com/user-attachments/assets/1ce1dd61-3f72-4ea3-9049-8c13f6466869" width="350" height="750">|
|종목 판매|종목 구매|
|<img src = "https://github.com/user-attachments/assets/4594f88e-0647-40d2-b75c-ef35c7747260" width="350" height="750">|<img src = "https://github.com/user-attachments/assets/d37fbb26-593d-43b1-8090-8d960957481b" width="350" height="750">|
|종목 판매 확인|종목 구매 확인|
|<img src = "https://github.com/user-attachments/assets/1fe5e4a0-5625-4eeb-b467-0e3d8676ec4b" width="350" height="750">|<img src = "https://github.com/user-attachments/assets/7a168253-83cd-4773-9d28-e57ad794fade" width="350" height="750">|
</details>

<details><summary>정보 화면 부분</summary>
    
|정보 탭|상세 관리|
|:---:|:---:|
|<img src = "https://github.com/user-attachments/assets/c9456f50-68e4-45da-aa8f-a843038c94c1" width="350" height="1500">|<img src = "https://github.com/user-attachments/assets/59412a18-f5c8-4783-a1c6-781c969f9afb" width="350" height="750">|
|이름 변경|팬덤 변경|
|<img src = "https://github.com/user-attachments/assets/af86de07-2fc1-489e-a54f-3ab97cdb6d3a" width="350" height="750">|<img src = "https://github.com/user-attachments/assets/d2bd9c73-3c59-46cf-bebc-1d953aa6d449" width="350" height="750">|
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
```
