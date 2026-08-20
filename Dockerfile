# Minimal lightweight Python 3.12 base image
FROM python:3.12-slim

# Set container working directory
WORKDIR /app

# Copy and install dependencies first (cached layer)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code & local database index
COPY . .

# Expose FastAPI application port
EXPOSE 8000

# 7. Start FastAPI server with Uvicorn
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
# Lightweight Python 3.12 base image
FROM python:3.12-slim

# Set container working directory
WORKDIR /app

# Python runtime settings
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Upgrade pip
RUN pip install --upgrade pip

# Copy dependencies first for Docker layer caching
COPY requirements.txt .

# Install dependencies with extended timeout
RUN pip install --no-cache-dir --default-timeout=300 -r requirements.txt

# Copy application source code
COPY . .

# FastAPI port
EXPOSE 8000

# Start FastAPI
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]