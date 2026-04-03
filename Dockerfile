FROM python:3.12-slim

# RUN apt update && apt install -y python3 python3-pip

WORKDIR /app

COPY . .

ENTRYPOINT ["python", "sample_file.py"]