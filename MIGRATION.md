# 🔄 Migration Guide - v1.0 to v2.0

## Overview

This guide helps you transition from the old hardcoded system to the new dynamic compilation system.

---

## ✅ Good News: Zero Breaking Changes!

**You don't NEED to change anything!** The new system is 100% backward compatible.

Running `docker compose up` still works exactly as before - it compiles `UScheduleSophie.tex`.

---

## 🎯 What You GAIN (Without Changing Anything)

Even if you don't update your workflow, you automatically get:

1. ✅ Better error messages with emojis
2. ✅ Progress indicators during compilation
3. ✅ Automatic log file cleanup
4. ✅ More robust error handling
5. ✅ Font installation validation

---

## 🚀 Optional: Upgrade Your Workflow

If you want to take advantage of new features, here's how:

### Before (Old Way)

#### Problem 1: Compiling Different Schedules

**Old Workflow:**
```yaml
# Had to edit docker-compose.yml every time
command: >
  /bin/sh -c "... lualatex UScheduleSophie.tex ..."

# Change to:
command: >
  /bin/sh -c "... lualatex UScheduleSergio.tex ..."
```

**New Workflow:**
```bash
# Just set an environment variable
SCHEDULE=UScheduleSergio docker compose up

# Or use helper script
.\compile.ps1 UScheduleSergio
```

---

#### Problem 2: Compiling Multiple Schedules

**Old Workflow:**
```bash
# Had to run multiple times
docker compose up  # Wait...
# Edit docker-compose.yml to change schedule name
docker compose up  # Wait again...
# Edit again...
docker compose up  # Wait more...
```

**New Workflow:**
```bash
# Compile all at once
SCHEDULES="UScheduleSophie,UScheduleSergio,MySchedule" docker compose up

# Or even simpler
.\compile.ps1 -All
```

---

#### Problem 3: PDF Text Extraction

**Old Workflow:**
```python
# Had to edit extract_pdf.py every time
if __name__ == "__main__":
    pdf_path = sys.argv[1]  # Manual argument
    content = extract_text(pdf_path)
    print(content)  # Basic output
```

**New Workflow:**
```bash
# Rich CLI with multiple modes
python extract_pdf.py --parse Schedules/UScheduleSophie.pdf
python extract_pdf.py --compare Schedules/*.pdf
python extract_pdf.py --directory Schedules/ --output report.txt
```

---

## 📋 Migration Checklist

### Step 1: Install Python Dependencies (Optional)

Only needed if you want to use PDF extraction:

```bash
pip install -r requirements.txt
```

### Step 2: Try New Helper Scripts

**Windows:**
```powershell
# Make script executable (one-time setup)
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned

# Test it
.\compile.ps1 -List
.\compile.ps1 UScheduleSophie
```

**Linux/macOS:**
```bash
# Make script executable (one-time setup)
chmod +x compile.sh

# Test it
./compile.sh --list
./compile.sh UScheduleSophie
```

### Step 3: Update Your Habits

Replace your old commands:

| Old Command | New Command | Benefit |
|-------------|-------------|---------|
| `docker compose up` | `.\compile.ps1 ScheduleName` | Easier to switch schedules |
| Edit docker-compose.yml | Set `SCHEDULE` variable | No file editing needed |
| Run multiple times | `.\compile.ps1 -All` | Faster batch processing |
| Manual cleanup | `.\compile.ps1 -Clean` | One command cleanup |

### Step 4: Explore New Features

Try the new PDF extraction modes:

```bash
# Compare schedules to find common classes
python extract_pdf.py --compare Schedules/*.pdf

# Parse schedule structure
python extract_pdf.py --parse Schedules/UScheduleSophie.pdf

# Process entire directory
python extract_pdf.py --directory Schedules/ --output all_schedules.txt
```

---

## 🔧 For CI/CD Users

If you're using docker-compose in CI/CD pipelines:

### Old CI/CD (Still Works!)

```yaml
# .github/workflows/compile.yml
- name: Compile Schedule
  run: docker compose up
```

### New CI/CD (More Flexible)

```yaml
# .github/workflows/compile.yml
- name: Compile All Schedules
  run: |
    export SCHEDULES="UScheduleSophie,UScheduleSergio"
    docker compose up

# Or compile specific schedule from matrix
- name: Compile Schedule
  run: |
    export SCHEDULE=${{ matrix.schedule }}
    docker compose up
  strategy:
    matrix:
      schedule: [UScheduleSophie, UScheduleSergio]
```

---

## 📝 For Documentation

If you have documentation referencing the old system:

### Update These Sections

**Old:**
> Edit `docker-compose.yml` and change the `lualatex` command to compile your schedule.

**New:**
> Set the `SCHEDULE` environment variable or use the helper script:
> ```bash
> SCHEDULE=YourSchedule docker compose up
> ```

**Old:**
> To extract PDF text, edit `extract_pdf.py` and set the file path.

**New:**
> Use the CLI tool:
> ```bash
> python extract_pdf.py --parse YourSchedule.pdf
> ```

---

## 🐛 Troubleshooting Migration

### Issue: Helper Scripts Won't Run

**Windows PowerShell:**
```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

**Linux/macOS:**
```bash
chmod +x compile.sh
```

### Issue: Environment Variables Don't Work

**Windows CMD (doesn't support inline env vars):**
```cmd
# Use PowerShell instead
powershell -Command "$env:SCHEDULE='UScheduleSergio'; docker compose up"
```

**Windows PowerShell:**
```powershell
$env:SCHEDULE="UScheduleSergio"
docker compose up
```

**Linux/macOS:**
```bash
SCHEDULE=UScheduleSergio docker compose up
```

### Issue: Want to Keep Old Behavior

That's fine! Nothing changed for the default behavior:

```bash
docker compose up
```

Still compiles `UScheduleSophie.tex` exactly as before.

---

## 📊 Migration Benefits Summary

| Feature | Old System | New System | Time Saved |
|---------|-----------|------------|------------|
| Switch schedules | Edit file | Set variable | ~30 seconds |
| Compile 5 schedules | Run 5 times | Run once | ~5 minutes |
| PDF extraction | Edit code | CLI command | ~1 minute |
| List schedules | Manual `ls` | `.\compile.ps1 -List` | ~10 seconds |
| Clean build | Manual `rm` | `.\compile.ps1 -Clean` | ~20 seconds |

**Total time saved per day:** ~15-30 minutes for active users

---

## 🎓 Learn More

- **QUICKREF.md** - Quick command reference
- **USAGE.md** - Detailed usage examples
- **ENHANCEMENTS.md** - Technical details of changes

---

## 💡 Pro Tips

1. **Create Aliases** (Optional):
   ```powershell
   # Add to PowerShell profile
   function Compile-Schedule { .\compile.ps1 $args }
   Set-Alias -Name cs -Value Compile-Schedule
   
   # Now use: cs UScheduleSophie
   ```

2. **Batch Compile on Schedule Updates**:
   ```bash
   # After updating all .tex files for new semester
   .\compile.ps1 -All
   ```

3. **Automate PDF Analysis**:
   ```bash
   # Weekly schedule comparison
   python extract_pdf.py --compare Schedules/*.pdf > weekly_report.txt
   ```

---

## 🤝 Need Help?

If you have questions during migration:

1. Check [USAGE.md](USAGE.md) for detailed examples
2. See [QUICKREF.md](QUICKREF.md) for quick commands
3. Review [ENHANCEMENTS.md](ENHANCEMENTS.md) for technical details
4. Remember: Your old workflow still works!

---

**Happy Migrating! 🚀**

*Migration is optional but recommended for improved productivity*

*Last Updated: February 1, 2026*
