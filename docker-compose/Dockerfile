# Use a base Python image
FROM python:3.9

# Set the working directory inside the container
WORKDIR /app

# Copy the main.py file from the host to the container
COPY main.py .

# Install any required dependencies
# If your main.py requires any Python packages, you can install them here
# For example:
# RUN pip install package1 package2

# Set the entrypoint command to run the main.py file
CMD ["python", "main.py"]