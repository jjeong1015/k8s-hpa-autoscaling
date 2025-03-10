# k8s-hpa-autoscaling
Docker 이미지 생성부터 Kubernetes HPA(Horizontal Pod Autoscaler) 설정까지의 과정을 포함합니다.

## 기술 스택
<img src="https://img.shields.io/badge/SpringBoot-6DB33F?style=for-the-badge&logo=SpringBoot&logoColor=white"><img src="https://img.shields.io/badge/VirtualBox-183A61?style=for-the-badge&logo=VirtualBox&logoColor=black"><img src="https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black"><img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=Docker&logoColor=black"><img src="https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=Kubernetes&logoColor=white">

![HPA-01](https://github.com/user-attachments/assets/03728b1d-48ed-45b8-925c-64ed207f627b)
![HPA-02](https://github.com/user-attachments/assets/eef8d283-b27b-43a8-90a4-e846818922ae)
![HPA-03](https://github.com/user-attachments/assets/1a487923-4991-420e-acf6-a27b42fedc44)
![HPA-04](https://github.com/user-attachments/assets/36a54349-4c92-4c95-bcd1-9fd61f62ad33)
![HPA-05](https://github.com/user-attachments/assets/8ad55a77-df87-4f86-a6db-3b59798cfc71)
![HPA-06](https://github.com/user-attachments/assets/77a5a711-3d77-4aff-99c0-177535515752)
![HPA-07](https://github.com/user-attachments/assets/dcc00779-e57b-4632-bbff-2a9f593ccfe7)
![HPA-08](https://github.com/user-attachments/assets/8440cc1f-69a9-44df-b4ed-1ed3eb69b2b6)
![HPA-09](https://github.com/user-attachments/assets/f7f01077-7817-48d3-be43-0fb595396ab2)
![HPA-10](https://github.com/user-attachments/assets/4ae27692-a556-4b5a-9528-949edd388359)
![HPA-11](https://github.com/user-attachments/assets/58b48639-44b6-4a2f-969b-602207baf64f)
![HPA-12](https://github.com/user-attachments/assets/0f8ff96f-bda9-4291-8ae8-90f7aa12693e)
![HPA-13](https://github.com/user-attachments/assets/3a7cd917-d9ca-485a-a1cf-ce04c7c3687b)
![HPA-14](https://github.com/user-attachments/assets/2a29f20e-6aef-4d9d-a2ca-40a350cb81da)
![HPA-15](https://github.com/user-attachments/assets/5ed7c757-a705-4b8e-8bc9-79dc477dac55)
![HPA-16](https://github.com/user-attachments/assets/c3f88232-80dc-4151-8a46-e3e133d05af9)
![HPA-17](https://github.com/user-attachments/assets/9af69984-3614-4c8a-a147-a37dd249ca30)
![HPA-18](https://github.com/user-attachments/assets/aaead9b5-5a5c-4639-b592-899475eb4113)
![HPA-19](https://github.com/user-attachments/assets/5cb177d9-3176-48d1-9780-da66c1ba7576)
![HPA-20](https://github.com/user-attachments/assets/b18fb022-68ff-4d43-9d70-c200a8c17834)
![HPA-21](https://github.com/user-attachments/assets/9525235d-319a-450a-9505-98cf6c753538)
![HPA-22](https://github.com/user-attachments/assets/826b9a93-ef3e-4246-9287-c7f3fae67c30)
![HPA-23](https://github.com/user-attachments/assets/0a3c650a-56cd-4022-8da8-d3d1ce4d0f81)
![HPA-24](https://github.com/user-attachments/assets/58d1abbd-056e-47d3-846f-5e3d17098f31)
![HPA-25](https://github.com/user-attachments/assets/8f13deee-ff69-4e80-b46f-2ae713f33ff3)

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
