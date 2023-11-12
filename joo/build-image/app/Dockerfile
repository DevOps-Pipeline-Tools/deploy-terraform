FROM python:3.9.18-bullseye
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
COPY ./django-app /django-app
RUN useradd appuser
WORKDIR /django-app
RUN pip3 install -r requirements.txt
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
# USER appuser
EXPOSE 8000