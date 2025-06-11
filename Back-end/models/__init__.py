# models/__init__.py

# Dùng để import tất cả class vào metadata tập trung.
# Hai cách:
#
# Cách A: Import từng model
from models.users import Users
from models.chat_sessions import ChatSessions
from models.chat_messages import ChatMessages
# (Khi import models, Python sẽ đọc __init__.py, nhờ đó Base.metadata gom đủ)
#
# Cách B: Nếu bạn không muốn import tại đây, có thể load trong env.py trực tiếp:
#   import models.user
#   import models.post
