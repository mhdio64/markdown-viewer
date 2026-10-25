---
name: vibe-review
description: "Review one ticket independently and produce a commit-bound security and quality verdict without editing source."
---
# بازبینی مستقل

۱. در نشست جدید اجرا شو؛ فایل منبع را اصلاح نکن.
۲. از تیکت و Base SHA، محدوده تغییرات را تعیین کن و تمام Commitهای مربوط را بازبینی کن؛ `HEAD~1` کافی نیست.
۳. پوشش Acceptance Criteria، خطاهای امنیتی، تست‌های رفتاری، Dependencyها، شکست‌های CI و شواهد دستی را بررسی کن.
۴. اگر UI تغییر کرده Playwright را برای E2E و Visual QA به‌کار ببر؛ خروجی خام تست‌ها را در صورت لزوم ببین.
۵. یافته‌ها را با مسیر فایل، خط، شدت و راه بازتولید ثبت کن. اگر ابهام مهم وجود دارد APPROVED صادر نکن.
۶. فقط برای SHA بررسی‌شده، گزارش `docs/reviews/<ticket>.md` با `Verdict: APPROVED` یا `Verdict: CHANGES_REQUESTED` و `Reviewed-Commit: <sha>` بساز.
۷. از کاربر تأیید انسانی بخواه؛ اسکریپت بستن تیکت فقط پس از آن اجرا شود.
