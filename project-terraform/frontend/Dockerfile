# Використовуємо легковаговий образ Python
FROM python:3.9-slim

# Встановлюємо змінні середовища для Django
ENV PYTHONUNBUFFERED=1 \
    DJANGO_SETTINGS_MODULE=frontend.settings \
    PORT=3000 


# Встановлюємо системні пакети (додаємо curl!)
RUN apt-get update && apt-get install -y \
    curl libpq-dev gcc && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Визначаємо робочу директорію
WORKDIR /app

# Копіюємо файли requirements.txt та встановлюємо залежності
COPY requirements.txt .  
RUN pip install --no-cache-dir -r requirements.txt \
    && pip install --no-cache-dir gunicorn  

# Копіюємо весь код проєкту
COPY . .  

# Окремо копіюємо шаблони
COPY templates/ /app/templates/

# Відкриваємо порт
EXPOSE 3000 

# Запускаємо Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:3000", "frontend.wsgi:application"]
