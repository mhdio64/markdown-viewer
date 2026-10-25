---
name: vibe-debug
description: "Debug a nontrivial failing test, service, database migration, or CI job using reproducible evidence."
---
# اشکال‌زدایی ساختاریافته

۱. علائم، ورژن، محیط، ورودی بازتولید و آخرین تغییر موفق را ثبت کن.
۲. فرضیه‌ها را بر اساس شواهد اولویت‌بندی کن؛ در هر آزمایش فقط یک متغیر را تغییر بده.
۳. از `diagnosing-bugs` در صورت نصب استفاده کن؛ لاگ کامل حساس را به MCPهای خارجی ارسال نکن.
۴. اصلاح را با تست Regression و اجرای Gate اثبات کن و موارد حل‌نشده را صریح گزارش بده.
