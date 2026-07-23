FROM python:3.9-slim

#set working directory
WORKDIR /app

#copy the jar file to the working directory
COPY . .

#Install the required dependencies
RUN pip install -r requirements.txt

RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*

#Expose the port on which the application will run
EXPOSE 8000

#Run the application
ENTRYPOINT  ["python", "manage.py", "runserver", "0.0.0.0:8000"]