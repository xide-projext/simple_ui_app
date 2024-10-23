import pyautogui
import time
import webbrowser

# 예매 시작 시간 설정 (예: 10시 0분 0초)
예약_시간 = "10:00:00"

# 페이지 이동 및 로딩 대기
url = "https://tickets.interpark.com/special/sports/promotion?seq=43"
webbrowser.open(url)
time.sleep(5)  # 페이지 로딩 대기

# 예매 시작 시간까지 대기
while True:
    현재_시간 = time.strftime("%H:%M:%S")
    if 현재_시간 == 예약_시간:
        break
    time.sleep(0.1)

# 반복적인 예매 시도
반복_횟수 = 10  # 예매 시도 횟수 설정

for _ in range(반복_횟수):
    # 원하는 티켓의 버튼 클릭 (클릭할 좌표 입력 필요)
    pyautogui.click(x=좌표_x, y=좌표_y)
    time.sleep(0.5)

    # 좌석 선택 및 다음 단계로 넘어가기
    # 여기서 추가적인 클릭 및 대기 동작을 설정

    # 다시 시도하기 전에 대기 (예: 3초 대기)
    time.sleep(3)

    # 추가로 조건을 설정해 성공 시 루프를 종료할 수 있음
    # 예를 들어, 특정 메시지나 화면 변화가 있을 때 break를 사용해 종료
