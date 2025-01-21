# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set environment variables
ENV POETRY_VERSION=1.6.1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Install Poetry
RUN pip install --no-cache-dir poetry

# Create and set the working directory
WORKDIR /app

# Copy project files
COPY pyproject.toml poetry.lock ./
RUN poetry install --no-root

# Copy application files
COPY . .

# Expose the port
EXPOSE 9000

# Command to run the server
CMD ["poetry", "run", "gunicorn", "--bind", "0.0.0.0:9000", "app:app"]
