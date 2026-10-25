# برد تیکت محلی (اختیاری)

**چرخه وضعیت:** `todo -> active -> review -> done`. برای هر نشست توسعه، فقط یک تیکت فعال نگه دارید.  
**الگوی نام:** `TICKET-001-short-slug.md`، با حداقل سه رقم و Slug انگلیسی کوچک.

اسکیل `/to-tickets` خروجی خود را در Issue Tracker تنظیم‌شده توسط `/setup-matt-pocock-skills` ثبت می‌کند؛ هیچ تضمینی نیست که فایل‌های این برد را مستقیماً ایجاد کند. یا Tracker محلی سازگار را پیکربندی و تأیید کنید، یا Tracker خارجی را مرجع اصلی نگه دارید و نسخه تأییدشده تیکت‌ها را آگاهانه در این پوشه ثبت کنید. دو مرجع متناقض نداشته باشید.

پیش از شروع تیکت، SHA مبنای Git را در `HANDOFF.md` ذخیره کنید. پیش از Review، تمام تغییرات پیاده‌سازی باید روی Feature Branch کامیت شده باشند؛ فایل تیکت به `review/` منتقل، `HANDOFF.md` با `Stage: review` هماهنگ و این تغییرات نیز کامیت شده باشند.

Review مستقل در چت تازه انجام می‌شود. بازبین باید تمام Diff از `Base Commit` تا HEAD را بررسی کند و تنها فایل گزارش `docs/reviews/TICKET-001-short-slug.md` را ایجاد کند. برای پردازش ماشینی اسکریپت، خطوط زیر **باید عیناً انگلیسی باشند**:

```text
Verdict: APPROVED
Reviewed-Commit: <full SHA of current HEAD>
Evidence: <what was actually verified>
```

گزارش باید تنها تغییر Untracked باشد. پس از تأیید انسانی، از ریشه پروژه:

```bash
./scripts/vibe-next.sh TICKET-001-short-slug --approve --next TICKET-002-short-slug
```

ابزار بسته‌شدن تیکت تطبیق SHA را کنترل می‌کند و تغییرات نامرتبط را Stage نمی‌کند. Review موفق، تضمین ریاضی نبودِ باگ نیست و این فرایند تأیید رمزنگاری‌شده ایجاد نمی‌کند.
