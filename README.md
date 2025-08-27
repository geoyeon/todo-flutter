# 🚀 Flutter Todo with Isar

Flutter와 Isar 데이터베이스를 활용하여 만든 간단한 Todo 관리 애플리케이션입니다.

**진행 중...**

## ✨ 주요 특징

* **빠른 성능**: Isar의 고성능 로컬 데이터베이스를 사용하여 데이터를 신속하게 저장하고 읽습니다.
* **반응형 UI**: Riverpod 상태 관리 솔루션을 사용하여 UI가 데이터 변경에 즉각적으로 반응합니다.
* **깔끔한 아키텍처**: 데이터 계층(Repository), 상태 관리(Notifier), UI(Widget)를 분리하여 유지보수성을 높였습니다.

---

## 🛠️ 기술 스택

* **프레임워크**: Flutter
* **로컬 DB**: Isar
* **상태 관리**: Riverpod
* **라우팅**: `go_router`

---

## 📖 주요 기능

* **Todo 생성**: 제목, 메모, 시작일, 종료일을 설정하여 새로운 Todo를 만듭니다.
* **Todo 목록**: 작성된 모든 Todo를 카드 형태로 한눈에 볼 수 있습니다.
* **Todo 수정 및 삭제**: (선택적) Todo를 수정하거나 삭제하는 기능을 추가할 수 있습니다.

---

## ⚙️ 설치 및 실행

### 1. 프로젝트 클론

```bash
git clone [프로젝트_레포지토리_주소]
cd [프로젝트_폴더_이름]
```

### 2. 의존성 설치
pubspec.yaml에 정의된 모든 패키지를 설치합니다.

```Bash
flutter pub get
```
### 3. 코드 생성
Isar 데이터베이스 스키마 파일을 생성하기 위해 아래 명령어를 실행합니다.

```Bash
flutter pub run build_runner build --delete-conflicting-outputs
```
### 4. 앱 실행
시뮬레이터나 실제 기기에서 앱을 실행합니다.

```Bash
flutter run
```