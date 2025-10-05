FROM python:3.9-slim
WORKDIR /app
COPY . /app

RUN apt-get update && apt-get install -y \
    build-essential libsndfile1 \
    && rm -rf /var/lib/apt/lists/*

RUN pip install -e .
RUN pip install --upgrade botocore boto3
RUN python -m unidic download
RUN python melo/init_downloads.py

ENV GRADIO_SERVER_NAME="0.0.0.0"
ENV GRADIO_SERVER_PORT="8888"

CMD ["python", "./melo/app.py", "--host", "0.0.0.0", "--port", "8888"]