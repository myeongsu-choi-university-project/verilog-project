# Vending Machine System (Verilog)

## 프로젝트 개요
이 프로젝트는 Verilog를 사용하여 간단한 자판기 시스템을 설계하는 것입니다. 천원과 오천원을 받아 만원짜리 음료수를 뽑을 수 있는 자판기를 설계(잔돈 반환 기능이 있는)하는 것을 목표로 한다.

## 기능 요약
```
1. 여러 입력이 들어오는 경우 아무런 동작을 수행하지 않는다.
잔돈 반환과 동전 입력이 동시에 입력으로 들어온 경우, 음료 호출과 잔돈 반환이 동시에 입력으로 들어온 경우, 음료 호출과 동전 입력이 동시에 입력으로 들어온 경우, 음료 호출과 잔돈 반환과 동전 입력이 모두 동시에 입력으로 들어온 경우 입력을 무시한다.
```
```
2. 자판기에 20,000원을 초과해서 넣을 수 없다. 만약 자판기에 20,000원을 초과하여 돈이 들어온다면 20,000원을 초과하여 오르지 않고 초과된 돈의 양만큼 잔돈으로 반환된다.
```
```
3. 자판기의 돈이 음료의 가격(10,000원)보다 적을 경우 뽑을 수 없다.
```
```
4. 잔돈을 반환할 때 5,000원이 반환이 가능하면 5,000원을 반환하고, 불가능하다면 1,000원을 반환한다.
```
```
5. 모든 출력은 1 cycle 지연되어 출력된다.
```
```
6. 모든 출력은 상태에 맞게 한 주기만 출력되어야 한다. (돈이 충분한 상황에서 잔돈 반환을 한 번만 수행했는데 계속 잔돈 반환 출력이 올라가 있는 경우는 틀린 경우)
```

## 파일 실행 방법
### 1. 컴파일
먼저, iverilog 명령어를 사용하여 vm.v와 vm_tb.v 파일을 컴파일합니다. 테스트 벤치 파일(vm_tb.v)에서 자판기 시스템 모듈(vm.v)을 호출하므로, 두 파일을 함께 컴파일해야 합니다.
```bash
iverilog -o vm_test_out vm.v vm_tb.v
```
여기서 -o vm_test_out은 컴파일된 결과를 vm_test_out이라는 실행 파일로 저장하는 옵션입니다.

### 2. 시뮬레이션 실행
컴파일이 완료되면, 생성된 vm_test_out이라는 파일을 실행하여 시뮬레이션을 시작합니다.
```bash
vvp vm_test_out
```

### 3. 파형 확인
vm.vcd 파일을 이용하여 파형을 볼 수 있지만, 추가할 수 있는 신호의 수에 제한이 있어 GTKWave를 사용하여 파형을 확인할 수 있습니다.
```bash
gtkwave vm.vcd
```

## 참고
자세한 상태표와 기능 설명은 프로젝트 보고서를 참조하십시오.
