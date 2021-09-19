FROM python:slim-buster
ENV PYTHONUNBUFFERED=1
WORKDIR /app
COPY . .
RUN apt-get update && \
    apt-get upgrade && \
    apt-get install libpq-dev gcc -y && \
    pip3 install --upgrade pip && \
    pip3 install -r requirements.txt --no-cache-dir && \
    apt-get clean
CMD python manage.py migrate && \
    python manage.py collectstatic --noinput && \
    gunicorn todoapp.wsgi --bind 0.0.0.0:8000