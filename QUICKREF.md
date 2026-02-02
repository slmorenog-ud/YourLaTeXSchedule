# 🎯 Quick Reference Card - YourLaTeXSchedule

## 🚀 Quick Commands

### Windows (PowerShell)

```powershell
# List schedules
.\compile.ps1 -List

# Compile one
.\compile.ps1 UScheduleSophie

# Compile all
.\compile.ps1 -All

# Clean build
.\compile.ps1 -Clean
```

### Linux/macOS (Bash)

```bash
# List schedules
./compile.sh --list

# Compile one
./compile.sh UScheduleSophie

# Compile all
./compile.sh --all

# Clean build
./compile.sh --clean
```

### Docker Compose (All Platforms)

```bash
# Default (UScheduleSophie)
docker compose up

# Specific schedule
SCHEDULE=UScheduleSergio docker compose up

# Multiple schedules
SCHEDULES="UScheduleSophie,UScheduleSergio" docker compose up
```

---

## 📄 PDF Extraction

```bash
# Extract text
python extract_pdf.py Schedules/UScheduleSophie.pdf

# Process directory
python extract_pdf.py --directory Schedules/

# Compare schedules
python extract_pdf.py --compare Schedules/*.pdf

# Parse schedule info
python extract_pdf.py --parse Schedules/UScheduleSophie.pdf

# Save to file
python extract_pdf.py file.pdf --output output.txt
```

---

## 📂 Project Structure

```
YourLaTeXSchedule/
├── compile.ps1          # Windows helper (NEW)
├── compile.sh           # Linux/macOS helper (NEW)
├── docker-compose.yml   # Dynamic compilation (ENHANCED)
├── extract_pdf.py       # PDF extractor (ENHANCED)
├── requirements.txt     # Python dependencies (NEW)
├── USAGE.md            # Detailed guide (NEW)
├── ENHANCEMENTS.md     # Changes summary (NEW)
├── README.md           # Main documentation
│
├── Schedules/
│   ├── UScheduleSophie.tex
│   ├── UScheduleSergio.tex
│   └── *.pdf           # Generated PDFs
│
├── Configurations/
│   ├── ConfigurationTLOTR.tex
│   └── UConfigurationSE.tex
│
├── Fonts/
│   └── *.ttf           # Custom fonts
│
└── build/              # Auxiliary files
    └── *.aux, *.log
```

---

## 🆕 What's New?

✨ **Dynamic Compilation** - No editing docker-compose.yml  
✨ **Batch Processing** - Compile multiple schedules  
✨ **Helper Scripts** - Easy compilation commands  
✨ **Enhanced PDF Tools** - Extract, compare, parse  
✨ **Better UX** - Progress indicators, colors  
✨ **100% Backward Compatible** - Existing files work as-is

---

## 🐛 Quick Troubleshooting

| Problem | Solution |
|---------|----------|
| PowerShell won't run script | `Set-ExecutionPolicy -Scope CurrentUser RemoteSigned` |
| PDF extraction fails | `pip install pypdf` |
| Docker not found | Install Docker Desktop |
| Compilation fails | Check `build/ScheduleName.log` |
| Schedule not found | Run `.\compile.ps1 -List` |

---

## 📚 Documentation Files

- **README.md** - Original project documentation
- **USAGE.md** - Detailed usage examples and workflows
- **ENHANCEMENTS.md** - Summary of all changes
- **QUICKREF.md** - This quick reference (you are here)

---

## 💡 Common Workflows

### Create New Schedule
```bash
cp Schedules/UScheduleSophie.tex Schedules/MySchedule.tex
# Edit MySchedule.tex
.\compile.ps1 MySchedule
```

### Update All Schedules
```powershell
.\compile.ps1 -All
```

### Find Common Classes
```bash
python extract_pdf.py --compare Schedules/Student1.pdf Schedules/Student2.pdf
```

---

**For detailed information, see USAGE.md**

*Last Updated: February 1, 2026*
