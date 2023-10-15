# syntax=docker/dockerfile:1

# Comments are provided throughout this file to help you get started.
# If you need more help, visit the Dockerfile reference guide at
# https://docs.docker.com/engine/reference/builder/

ARG PYTHON_VERSION=3.10.9
FROM python:${PYTHON_VERSION} as base

# Prevents Python from writing pyc files.
ENV PYTHONDONTWRITEBYTECODE=1

# Keeps Python from buffering stdout and stderr to avoid situations where
# the application crashes without emitting any logs due to buffering.
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Create a user that the app will run under.
# See https://docs.docker.com/develop/develop-images/dockerfile_best-practices/#user
ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/app" \
    --uid "${UID}" \
    appuser

# Download dependencies as a separate step to take advantage of Docker's caching.
# Leverage a cache mount to /root/.cache/pip to speed up subsequent builds.
# Leverage a bind mount to requirements.txt to avoid having to copy them into
# into this layer.
RUN --mount=type=cache,target=/root/.cache/pip \
    --mount=type=bind,source=requirements.txt,target=requirements.txt \
    python -m pip install -r requirements.txt

# Set permissions to working directory for the user
RUN chown appuser:appuser /app
RUN mkdir -p /app/db /app/jupyter && \
    chown -R appuser:appuser /app/db /app/jupyter

# Copy the source code into the container.
COPY python/init.py /app/python/init.py
RUN chmod +x /app/python/init.py
COPY shell/start.sh /app/shell/start.sh
RUN chmod +x /app/shell/start.sh
COPY jupyter/crossfit-games-data-analysis-predictions_V7.ipynb /app/jupyter/


# Expose the port that the application listens on.
EXPOSE 8000

# Run the notebook.
CMD ["/app/shell/start.sh"]