#!/usr/bin/env python3
"""
Простой скрипт для тестирования health check endpoint.
Используйте для проверки работы бота локально или на Railway.
"""

import asyncio
import aiohttp
import sys


async def test_health_endpoint(url: str = "http://localhost:8000"):
    """Тестирует health check endpoint."""
    print(f"Тестируем health check: {url}")
    
    try:
        async with aiohttp.ClientSession() as session:
            # Тестируем корневой путь
            async with session.get(f"{url}/") as response:
                print(f"GET / - Status: {response.status}")
                if response.status == 200:
                    data = await response.json()
                    print(f"Response: {data}")
                else:
                    text = await response.text()
                    print(f"Error response: {text}")
            
            print()
            
            # Тестируем health путь
            async with session.get(f"{url}/health") as response:
                print(f"GET /health - Status: {response.status}")
                if response.status == 200:
                    data = await response.json()
                    print(f"Response: {data}")
                else:
                    text = await response.text()
                    print(f"Error response: {text}")
                    
    except aiohttp.ClientConnectorError:
        print(f"❌ Не удалось подключиться к {url}")
        print("Убедитесь, что бот запущен и health check сервер работает")
    except Exception as e:
        print(f"❌ Ошибка: {e}")


async def main():
    """Основная функция."""
    if len(sys.argv) > 1:
        url = sys.argv[1]
    else:
        url = "http://localhost:8000"
    
    await test_health_endpoint(url)


if __name__ == "__main__":
    print("🔍 Тестирование Health Check Endpoint")
    print("Использование: python test_health.py [URL]")
    print("По умолчанию: http://localhost:8000")
    print("-" * 50)
    
    asyncio.run(main())