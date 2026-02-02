# 🚀 Enhanced YourLaTeXSchedule - Usage Guide

## Overview

This enhanced version provides **dynamic compilation**, **improved PDF extraction**, and **convenient helper scripts** for managing your LaTeX schedules.

---

## ✨ New Features

### 1. **Dynamic Docker Compose**
- Compile any schedule without editing `docker-compose.yml`
- Environment variable support
- Batch compilation of multiple schedules
- Better error messages and progress indicators

### 2. **Enhanced PDF Extractor**
- CLI interface with multiple modes
- Directory processing
- Schedule comparison
- Structured information parsing
- Output to file support

### 3. **PowerShell Helper Script**
- Simple compilation commands
- List available schedules
- Clean build artifacts
- Cross-platform (works on Windows, Linux, macOS)

---

## 📖 How to Use

### Method 1: Docker Compose (Direct)

#### Compile Default Schedule (UScheduleSophie)
```bash
docker compose up
```

#### Compile Specific Schedule
```bash
# Windows PowerShell
$env:SCHEDULE="UScheduleSergio"
docker compose up

# Linux/macOS
SCHEDULE=UScheduleSergio docker compose up
```

#### Compile Multiple Schedules at Once
```bash
# Windows PowerShell
$env:SCHEDULES="UScheduleSophie,UScheduleSergio"
docker compose up

# Linux/macOS
SCHEDULES="UScheduleSophie,UScheduleSergio" docker compose up
```

---

### Method 2: PowerShell Helper Script (Recommended)

The `compile.ps1` script provides a user-friendly interface:

#### List Available Schedules
```powershell
.\compile.ps1 -List
```
Output:
```
📚 Available Schedules:
  ✅ UScheduleSophie
  ⚪ UScheduleSergio
```

#### Compile a Single Schedule
```powershell
.\compile.ps1 UScheduleSophie
```

#### Compile All Schedules
```powershell
.\compile.ps1 -All
```

#### Clean Build Artifacts
```powershell
.\compile.ps1 -Clean
```

#### Get Help
```powershell
.\compile.ps1 -Help
```

---

### Method 3: Enhanced PDF Extraction

The new `extract_pdf.py` supports multiple modes:

#### Extract Text from a PDF
```bash
python extract_pdf.py Schedules/UScheduleSophie.pdf
```

#### Process All PDFs in a Directory
```bash
python extract_pdf.py --directory Schedules/
```

#### Compare Multiple Schedules
```bash
python extract_pdf.py --compare Schedules/UScheduleSophie.pdf Schedules/UScheduleSergio.pdf
```

#### Parse Schedule Information
```bash
python extract_pdf.py --parse Schedules/UScheduleSophie.pdf
```

#### Save Output to File
```bash
python extract_pdf.py Schedules/UScheduleSophie.pdf --output schedule_text.txt
```

#### Verbose Mode
```bash
python extract_pdf.py --verbose --directory Schedules/
```

---

## 🔧 Workflow Examples

### Creating a New Schedule

1. **Create the .tex file:**
```bash
cp Schedules/UScheduleSophie.tex Schedules/MySchedule.tex
```

2. **Edit the new file** with your schedule data

3. **Compile it:**
```powershell
.\compile.ps1 MySchedule
```

4. **Your PDF is ready:**
```
Schedules/MySchedule.pdf
```

---

### Batch Processing All Schedules

Perfect for semester updates when multiple students need schedules:

```powershell
# Compile all at once
.\compile.ps1 -All

# Or using docker compose directly
$env:SCHEDULES="UScheduleSophie,UScheduleSergio,MySchedule"
docker compose up
```

---

### Comparing Student Schedules

Extract and compare schedules to find common classes:

```bash
python extract_pdf.py --compare Schedules/UScheduleSophie.pdf Schedules/UScheduleSergio.pdf
```

Output:
```
📊 SCHEDULE COMPARISON
================================================================================

1. UScheduleSophie.pdf
   Period: 2026-1
   Courses found: 8
   Sample courses:
     • CÁLCULO MULTIVARIADO
     • ÉTICA Y BIOÉTICA
     • FÍSICA II
     ...

2. UScheduleSergio.pdf
   Period: 2026-1
   Courses found: 7
   Sample courses:
     • ECUACIONES DIFERENCIALES
     • CIENCIAS DE LA COMPUTACIÓN I
     ...
```

---

## 🎯 Quick Reference

### Compilation Commands

| Task | Command |
|------|---------|
| List schedules | `.\compile.ps1 -List` |
| Compile one | `.\compile.ps1 ScheduleName` |
| Compile all | `.\compile.ps1 -All` |
| Clean build | `.\compile.ps1 -Clean` |
| Default (Sophie) | `docker compose up` |
| Specific schedule | `SCHEDULE=Name docker compose up` |
| Multiple schedules | `SCHEDULES="Name1,Name2" docker compose up` |

### PDF Extraction Commands

| Task | Command |
|------|---------|
| Extract text | `python extract_pdf.py file.pdf` |
| Process directory | `python extract_pdf.py -d Schedules/` |
| Compare PDFs | `python extract_pdf.py --compare file1.pdf file2.pdf` |
| Parse schedule | `python extract_pdf.py --parse file.pdf` |
| Save to file | `python extract_pdf.py file.pdf -o output.txt` |

---

## 💡 Tips & Best Practices

1. **First Compilation**: The first time you run Docker, it will download ~4GB of TeXLive image. This is one-time only.

2. **Naming Convention**: Use descriptive names for schedules:
   - `USchedule{StudentName}.tex` for student schedules
   - `TSchedule{TeacherName}.tex` for teacher schedules
   - `RSchedule{RoomName}.tex` for room schedules

3. **Build Artifacts**: Auxiliary files (`.aux`, `.log`) are automatically moved to `build/` directory to keep `Schedules/` clean.

4. **Error Debugging**: If compilation fails:
   - Check `build/ScheduleName.log` for detailed errors
   - Ensure your .tex file syntax is correct
   - Verify font files are in `Fonts/` directory

5. **Performance**: Compiling multiple schedules in one go is faster than individual compilations because Docker only starts once.

6. **PDF Extraction Dependencies**: Install PDF library once:
   ```bash
   pip install pypdf
   ```

---

## 🔄 Migration from Old Version

If you were using the hardcoded version:

### Before (Old Way)
```yaml
# Had to edit docker-compose.yml for each schedule
command: >
  /bin/sh -c "... lualatex UScheduleSophie.tex ..."
```

### After (New Way)
```bash
# Just use environment variables
.\compile.ps1 UScheduleSergio
```

**No changes required** to your existing `.tex` files! They work as-is.

---

## 🐛 Troubleshooting

### Problem: "Docker not found"
**Solution**: Install Docker Desktop from https://docker.com

### Problem: "Schedule not found"
**Solution**: Run `.\compile.ps1 -List` to see available schedules

### Problem: Compilation fails with font errors
**Solution**: Ensure `.ttf` files are in `Fonts/` directory

### Problem: PDF extraction fails
**Solution**: Install dependencies:
```bash
pip install pypdf
```

### Problem: PowerShell script won't run
**Solution**: Enable script execution:
```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

---

## 📞 Support

For issues or questions:
1. Check the logs in `build/` directory
2. Review this usage guide
3. Consult the main [README.md](README.md)

---

**Happy Scheduling! 🎓📅**
