FROM python:3.9-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  wget \
  && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workspace

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Create output directory
RUN mkdir -p /outputs

COPY src  /src/
COPY model ./model/

ENV HF_HOME=/model \
TRANSFORMERS_OFFLINE=1

# Set entrypoint
ENTRYPOINT ["python", "/src/run_inference.py"]
