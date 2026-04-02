# 🐳 Docker Registry — Complete Guide

---

## 📌 What is a Docker Registry?

A **Docker Registry** is a service that stores and distributes Docker images.

Think of it like:

* **GitHub → for code**
* **Docker Registry → for container images**

---

## 📦 How Docker Images Are Stored

Docker images are stored in a **layered format**.

### 🔹 Image Structure

Each image consists of:

* Multiple **read-only layers**
* A final **writable container layer** (only at runtime)

Example:

```
Ubuntu base layer
+ Python layer
+ App dependencies
+ Your application code
```

### 🔹 Why Layers?

* Efficient storage (shared layers)
* Faster pulls (only missing layers downloaded)

---

## 🏷️ Image Naming Convention

```
[registry]/[username]/[repository]:[tag]
```

### Example:

```
docker.io/library/nginx:latest
```

### 🔹 Breakdown:

* `docker.io` → Registry (default)
* `library` → Default namespace (official images)
* `nginx` → Repository name
* `latest` → Tag

---

## ⚙️ Default Values (Assumptions Docker Makes)

If you run:

```
docker pull nginx
```

Docker assumes:

* Registry → `docker.io`
* Namespace → `library`
* Tag → `latest`

So it becomes:

```
docker.io/library/nginx:latest
```

---

## 🌍 Popular Docker Registries

| Registry                  | URL             | Notes                   |
| ------------------------- | --------------- | ----------------------- |
| Docker Hub                | docker.io       | Default public registry |
| Google Container Registry | gcr.io          | Google Cloud            |
| Amazon ECR                | *.amazonaws.com | AWS private registry    |
| GitHub Container Registry | ghcr.io         | GitHub integrated       |
| Azure Container Registry  | azurecr.io      | Azure                   |

---

## 🔐 Public vs Private Registries

### Public Registry

* Anyone can pull
* Example: Docker Hub public repos

### Private Registry

* Requires authentication
* Used in companies for internal images

---

## 👤 How Usernames Work

* Username = **namespace** in registry
* Example:

```
docker.io/sumanthgma4/my-app:1.0
```

* `sumanthgma4` owns the repository
* Others need permission to push/pull (if private)

---

## 🔑 Login to a Registry

```
docker login
```

For custom registry:

```
docker login my-registry.com
```

---

## 📥 Pulling Images

```
docker pull nginx
```

From custom registry:

```
docker pull my-registry.com/my-app:1.0
```

---

## 📤 Pushing Images

### Step 1: Tag the image

```
docker tag my-app my-registry.com/my-app:1.0
```

### Step 2: Push

```
docker push my-registry.com/my-app:1.0
```

---

## 🏠 Running a Private Registry Locally

### 🧠 What is `registry:2` image?

```
registry:2
```

This is an **official Docker image** that runs a full Docker Registry server.

👉 Meaning:

* It is NOT just a container
* It is a **complete HTTP service**
* Implements Docker Registry API (v2)

Think of it like:

* `nginx` → runs a web server
* `postgres` → runs a database
* `registry:2` → runs a **Docker image server**

Once started, it:

* Accepts `push` requests
* Serves `pull` requests
* Stores images on disk (`/var/lib/registry`)

---

### 🚀 Run registry container:

```
docker run -d \
  -p 5000:5000 \
  --name registry \
  registry:2
```

👉 What happens here:

* Registry server starts on port `5000`
* Accessible via:

```
http://localhost:5000
```

---

## 📦 Push Image to Local Registry

### 🔹 Tag image:

```
docker tag my-app localhost:5000/my-app
```

### 🔹 Push:

```
docker push localhost:5000/my-app
```

---

## 🏷️ Working with Versions (Tags)

Docker uses **tags as versions**.

### Example:

```
docker tag my-app localhost:5000/my-app:v1
docker tag my-app localhost:5000/my-app:v2
```

Push both versions:

```
docker push localhost:5000/my-app:v1
docker push localhost:5000/my-app:v2
```

👉 Now registry stores:

* `my-app:v1`
* `my-app:v2`

Pull specific version:

```
docker pull localhost:5000/my-app:v1
```

If no tag:

```
docker pull localhost:5000/my-app
```

→ defaults to `latest`

---

## 🌐 Accessing Local Registry from Other Machines

### 🧠 Important Concept

Your registry is NOT just local — it’s a **network service**.

Other machines can access it using:

```
http://<your-ip>:5000
```

---

### 🔹 Step 1: Find your machine IP

```
ip a
```

Example:

```
192.168.1.10
```

---

### 🔹 Step 2: Push image using IP

```
docker tag my-app 192.168.1.10:5000/my-app

docker push 192.168.1.10:5000/my-app
```

---

### 🔹 Step 3: Pull from another machine

On another machine:

```
docker pull 192.168.1.10:5000/my-app
```

---

### ⚠️ Important Notes

* Both machines must be on same network
* Port `5000` must be open
* If HTTP → may need insecure registry config

---

## 📥 Pull from Local Registry (Same Machine)

```
docker pull localhost:5000/my-app
```

---

## 📂 Persistent Storage for Registry

Without volume → images are lost when container stops.

### Use volume:

```
docker run -d \
  -p 5000:5000 \
  -v /my-registry-data:/var/lib/registry \
  registry:2
```

---

## 🧠 What Happens If Registry Stops?

### Case 1: No volume

* ❌ All images LOST

### Case 2: With volume

* ✅ Images persist
* Registry can restart and continue

---

## 🔄 Running Containers from Private Registry

```
docker run localhost:5000/my-app:v1
```

---

## 🚀 Summary

* Docker Registry stores images in layers
* Default registry is Docker Hub
* Image format includes registry, namespace, repo, tag
* Private registries require login
* You can host your own registry using a container
* Use volumes to persist data

---

## 💡 Pro Tips

* Always tag images properly
* Avoid relying on `latest`
* Use private registries for production
* Use cloud registries for scalability

---

🔥 You now got the full mental model of Docker registries.
