FROM mcr.microsoft.com/azure-functions/python:2.0

ENV AzureWebJobsScriptRoot=/home/site/wwwroot \
    AzureFunctionsJobHost__Logging__Console__IsEnabled=true

COPY . /home/site/wwwroot


RUN apt-get update && apt-get -y install sudo && apt-get install -y apt-utils
RUN apt-get install -y  poppler-utils
RUN sudo apt-get -y install curl
RUN sudo apt-get -y install --reinstall build-essential
RUN sudo curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN sudo curl https://packages.microsoft.com/config/debian/9/prod.list > /etc/apt/sources.list.d/mssql-release.list

RUN apt-get update


RUN sudo ACCEPT_EULA=Y apt-get install msodbcsql17


RUN sudo ACCEPT_EULA=Y apt-get install mssql-tools
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
RUN . ~/.bashrc


RUN sudo apt-get install -y unixodbc-dev


RUN cd /home/site/wwwroot && \
    pip install -r requirements.txt
