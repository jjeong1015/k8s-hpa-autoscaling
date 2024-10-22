# k8s-hpa-autoscaling
Docker 이미지 생성부터 Kubernetes HPA(Horizontal Pod Autoscaler) 설정까지의 과정을 포함합니다.

![367c43cf_1](https://github.com/user-attachments/assets/6facf26b-4794-47eb-9a6a-6e110785d972)
![367c43cf_2](https://github.com/user-attachments/assets/be349f0b-5b9a-4cfc-b8a4-47da04ee8e04)
![367c43cf_3](https://github.com/user-attachments/assets/be9ca95b-8487-42c2-bbef-c3fed06890e7)
![367c43cf_4](https://github.com/user-attachments/assets/dd5e0371-11ad-4cfb-a002-0f33cdb27761)
![367c43cf_5](https://github.com/user-attachments/assets/93330cd6-40a5-4c9a-a641-6afd34d3cb11)
![367c43cf_6](https://github.com/user-attachments/assets/e77766a1-6989-417b-969f-1f63cc340925)
![367c43cf_7](https://github.com/user-attachments/assets/b9ff06c0-d709-4861-a032-634ebe62dcef)
![367c43cf_8](https://github.com/user-attachments/assets/080d23f8-6283-45f1-97e2-753a63a8c503)
![367c43cf_9](https://github.com/user-attachments/assets/fc87c905-667b-4516-8c66-36efb3ba0581)
![367c43cf_10](https://github.com/user-attachments/assets/daaa7be1-3327-4d70-ab52-b3c416dcb801)
![367c43cf_11](https://github.com/user-attachments/assets/abe26066-9def-4706-a56e-0fb0914dec85)
![367c43cf_12](https://github.com/user-attachments/assets/0e438561-dc1f-4e51-9900-0eb9b0849239)
![367c43cf_13](https://github.com/user-attachments/assets/dffbea5a-d40a-421a-8fb7-d9de5954fd77)
![367c43cf_14](https://github.com/user-attachments/assets/586883d0-a9f8-4310-a4bd-4b88c1b530ba)
![367c43cf_15](https://github.com/user-attachments/assets/68c7d7df-0dae-4e78-b74e-f334de75fe5e)
![367c43cf_16](https://github.com/user-attachments/assets/c74f5e11-402d-4756-9da8-861a91e1550d)
![367c43cf_17](https://github.com/user-attachments/assets/6a55d22c-df3f-4440-94ae-46d17e59b869)
![367c43cf_18](https://github.com/user-attachments/assets/847e914e-c3ef-476c-ae5d-ae28c4bcd2e4)
![367c43cf_19](https://github.com/user-attachments/assets/c01b3a24-6d35-4d5f-aacb-54d0ce9b0f47)
![367c43cf_20](https://github.com/user-attachments/assets/7a6d30f3-b17f-496a-b59b-88c7cc49b22a)
![367c43cf_21](https://github.com/user-attachments/assets/813faabc-08e1-4514-a643-7be24261018f)
![367c43cf_22](https://github.com/user-attachments/assets/b055976a-d5b2-4b41-b18d-ad0903cb77ca)
![367c43cf_23](https://github.com/user-attachments/assets/37e284ea-caa6-47df-895a-18d72ff98ad3)
![367c43cf_24](https://github.com/user-attachments/assets/b266429a-70d5-4f8c-a3f7-71b0d3d521a0)
![367c43cf_25](https://github.com/user-attachments/assets/f03f1752-8cf7-45a7-bcb0-608488ba0f65)

### 🚀 1. 시스템 준비 및 Docker 설치
```bash
# 1. 패키지 인덱스 업데이트
$ sudo apt-get update

# 2. Docker 설치
$ sudo apt install -y docker.io

# 3. 현재 접속해 있는 사용자 확인
$ who
$ groups

# 4. Docker 그룹에 현재 사용자 추가 후 반영
$ sudo usermod -a -G docker $USER
$ newgrp docker
$ groups
```

### 🐳 2. Docker 이미지 생성 및 푸시
```bash
# 1. Docker 로그인
$ docker login

# 2. Dockerfile 작성 (Java 17 JDK 이미지 사용)
$ vi Dockerfile

# 3. JAR 파일과 Dockerfile 확인
$ ls
# demo-0.0.1-SNAPSHOT.jar  Dockerfile

# 4. Docker 이미지 빌드 및 태깅
$ docker build -t springboot-demo .

# 5. Docker Hub에 이미지 푸시
$ docker tag springboot-demo jjeongjjeong/springboot-demo:latest
$ docker push jjeongjjeong/springboot-demo:latest
```

### ☸️ 3. Minikube 및 kubectl 설치 및 설정
```bash
# 1. Minikube 설치
$ curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
$ sudo install minikube-linux-amd64 /usr/local/bin/minikube && rm minikube-linux-amd64

# 2. kubectl 설치
$ sudo snap install kubectl --classic

# 3. kubectl 버전 확인
$ kubectl version --output=yaml

# 4. Minikube 시작
$ minikube start --cpus=2 --memory=6144

# 5. Minikube 상태 확인
$ minikube status

# 6. 전체 네임스페이스의 파드 목록 확인
$ kubectl get po -A

# 7. Minikube의 Docker 환경 설정
$ eval $(minikube docker-env)
```

### 📦 4. Kubernetes 배포 및 서비스 설정
```bash
# 1. 배포 설정 파일 작성
$ vi deployment.yaml

# 2. 서비스 설정 파일 작성
$ vi service.yaml

# 3. 배포 및 서비스 적용
$ kubectl apply -f deployment.yaml
$ kubectl apply -f service.yaml

# 4. 파드, 서비스, 노드 상태 확인
$ kubectl get pods
$ kubectl get svc
$ kubectl get nodes -o wide

# 5. Minikube 터널 실행 (외부에서 접근 가능하게 설정)
$ minikube tunnel

# 6. Minikube IP 확인
$ minikube ip

# 7. 서비스에 외부 접근 테스트
$ curl http://$MINIKUBE_IP:$NODE_PORT
# curl http://192.168.49.2:30007
```

### 📈 5. HPA 설정 및 모니터링
```bash
# 1. HPA 설정 파일 작성
$ vi hpa.yaml

# 2. HPA 적용
$ kubectl apply -f hpa.yaml

# 3. Metrics Server 설치
$ kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# 4. Metrics Server 파드 상태 확인
$ kubectl get pods -n kube-system

# 5. Metrics Server API 서비스 확인
$ kubectl get apiservices | grep metrics

# 6. Metrics Server 설정 수정 (--kubelet-insecure-tls 추가)
$ kubectl edit deployment metrics-server -n kube-system

# 7. Metrics Server 재시작
$ kubectl rollout restart deployment metrics-server -n kube-system

# 8. Metrics Server 로그 확인
$ kubectl logs -n kube-system -l k8s-app=metrics-server

# 9. Minikube 로그에서 Metrics 관련 로그 확인
$ minikube logs | grep metrics

# 10. Minikube 애드온 목록 확인 및 Metrics Server 애드온 활성화
$ minikube addons list
$ minikube addons enable metrics-server # components.yaml 생성됨

# 11. Metrics Server 파드 및 API 서비스 확인
$ kubectl get pods -n kube-system
$ kubectl get apiservice v1beta1.metrics.k8s.io -o yaml

# 12. HPA 상태 및 리소스 사용량 확인
$ kubectl get hpa
$ kubectl top nodes
$ kubectl top pods
```

### 🔧 6. 부하 테스트 및 HPA 리소스 사용량 확인
```bash
# 1. 부하 이전 상태 확인
$ echo "부하 이전"
$ kubectl get hpa
$ kubectl get pods
$ kubectl top pods
$ kubectl top nodes

# 2. wrk 설치 및 부하 테스트
$ sudo apt install wrk
$ echo "부하 시작"
$ wrk -t8 -c100 -d60s http://<minikube-ip>:<node-port>
# wrk -t8 -c100 -d60s http://192.168.49.2:30007

# 3. 부하 이후 상태 확인
$ echo "부하 이후"
$ kubectl get hpa
$ kubectl get pods
$ kubectl top pods
$ kubectl top nodes
```
