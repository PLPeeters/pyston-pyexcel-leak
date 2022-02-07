FROM --platform=linux/amd64 pyston/slim:2.3.2
# FROM --platform=linux/amd64 python:3.8
# ^ Replacing the image fixes the leak

RUN apt-get update && apt-get install --no-install-recommends -y bsdmainutils

COPY requirements.txt .
RUN JIT_MIN_RUNS=99999999999 pip install -r requirements.txt

COPY create-csv.sh .
RUN ./create-csv.sh

COPY mwe.py .

CMD python mwe.py
