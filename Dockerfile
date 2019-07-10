# Dockerfile - this is a comment. Delete me if you want.
EXPOSE 9090
FROM python:2.7
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
ENTRYPOINT ["python"]
CMD ["app.py"]