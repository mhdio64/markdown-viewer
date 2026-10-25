---
name: vibe-ticket
description: "Implement one approved ticket with isolated scope, TDD, verifiable evidence, and review handoff."
---
# چرخه اجرای یک تیکت

۱. شاخه کاری، SHA مبنا، وضعیت Git و تیکت فعال را تعیین و ثبت کن. اگر مخزن کثیف است متوقف شو.
۲. Acceptance Criteria، وابستگی‌ها و مرز تغییرات را استخراج کن؛ خارج از تیکت کد ننویس.
۳. تست RED مرتبط را بنویس و علت شکست آن را تأیید کن؛ سپس GREEN و ساده‌سازی حداقلی.
۴. خطاهای غیرمنتظره را با ریشه‌یابی حل کن و خروجی تست‌های واقعی را نگه دار.
۵. Quality Gate تعریف‌شده در `.vibe/verify.json` را اجرا کن؛ Semgrep/Trivy فقط مطابق نوع پروژه.
۶. برای بازبینی مستقل، گزارش دامنه تغییرات، فرمان‌ها، خروجی‌ها، موارد تست‌نشده و Git SHA بده.
۷. قبل از Review یا تأیید صریح کاربر، تیکت را Done نکن و آن را Merge یا Deploy نکن.
