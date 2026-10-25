---
name: vibe-release
description: "Prepare an explicitly approved release with CI, rollback, migration, and security readiness checks."
---
# آمادگی انتشار

۱. نسخه، Scope انتشار، محیط هدف، وابستگی‌ها و ریسک را مشخص کن.
۲. وضعیت تمام Gateهای لازم، Migrationها، Backup، سازگاری API و روش Rollback را بررسی کن.
۳. اگر انتشار شامل زیرساخت یا Production است، تغییرات را فقط در حالت Plan/Preview نشان بده.
۴. بدون تأیید صریح کاربر Deploy نکن؛ نتیجه و گام بازیابی را در Release Note ثبت کن.
