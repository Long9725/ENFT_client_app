# ENFT Client-app

## Structure

추후 업데이트 예정

## Usage

- .env 설정
  KLIP_SCA 값은 선규에게 문의
  나머지 값은 성호에게 문의

```sh
KLIP_SCA= # NFT smart contract address
NAVER_MAP_API_KEY_ID= # naver map private api key-id 
NAVER_MAP_API_KEY= # naver map private api key
```

## ToDo-List

### 이용권
- [ ] Model class 만들기
- [ ] QR 코드 활성화 (현재 빈 주소)
- [ ] 헬스장 로고 받기
- [ ] 공유 버튼 활성화 (필요한가?)

### Klip 지갑
- [x] klip Android랑 연결하기
- [ ] klip iOS랑 연결하기
- [ ] 지갑 UI 만들기
- [x] 지갑 잔액 가져오는 api 만들기
- [ ] 지갑 NFT 목록 가져오는 api 만들기
- [ ] 스마트 컨트랙트랑 연결하기

### 게시글
- [ ] 게시글 목록 lazy list로 바꾸기
- [ ] 게시글 반응형 UI로 만들기(특히 사진과 글)
- [ ] 게시글 '채팅으로 거래하기' 버튼 활성화

### 채팅  
- [ ] 검색 기능 활성화

### 내 정보
- [ ] 필요한 기능 간추리기
- [ ] 프로필 설정 기능 구현

### Issues

자세한 내용은 Issues 참고

- [ ] 재시작 시 위치 서비스 연결 안 됌
- [ ] 주변 동네 정보 받아오는 알고리즘의 효율성이 매우 안 좋음
