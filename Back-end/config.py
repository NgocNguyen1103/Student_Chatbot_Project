from pydantic_settings import BaseSettings
from dotenv import load_dotenv
from pathlib import Path

dotenv_path = Path(__file__).resolve().parents[0] / ".env"
load_dotenv(dotenv_path, override=True)
class Settings(BaseSettings):
    DATABASE_URL: str
    JWT_SECRET_KEY: str
    JWT_ALGORITHM: str

    class Config:
        env_file = dotenv_path
        env_file_encoding = "utf-8"
        case_sensitive = True

settings = Settings()
# if __name__ == "__main__":
#     settings = Settings()                   # Khởi tạo Settings, Pydantic tự động load .env
#     print("DATABASE_URL =", settings.DATABASE_URL)
#     print("JWT_SECRET_KEY =", settings.JWT_SECRET_KEY)
#     print("JWT_ALGORITHM =", settings.JWT_ALGORITHM)

