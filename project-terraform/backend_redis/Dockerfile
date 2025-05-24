FROM python:3.9-slim 

# Встановлюємо необхідні пакети
RUN apt-get update && apt-get install -y \
    gcc && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Копіюємо `requirements.txt` та встановлюємо залежності
COPY requirements.txt . 
RUN pip install --no-cache-dir -r requirements.txt gunicorn

# Копіюємо весь код додатку
COPY . .  

# Відкриваємо порт
EXPOSE 8001

# Запускаємо додаток через Gunicorn
CMD ["python", "manage.py", "runserver", "0.0.0.0:8001", "--noreload"]