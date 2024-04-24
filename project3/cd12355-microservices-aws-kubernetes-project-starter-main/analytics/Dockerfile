FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt requirements.txt

RUN pip install --upgrade pip \
    && apt-get update \
    && apt-get install -y libpq-dev \
    && pip install -r requirements.txt

COPY . .

CMD ["python", "app.py"]
