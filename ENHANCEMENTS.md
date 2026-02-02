# 🎓 YourLaTeXSchedule - Enhancement Summary

## ✨ What Changed

Your project has been enhanced with **dynamic compilation**, **improved PDF extraction**, and **convenient helper tools** for a better developer experience.

---

## 📦 New & Modified Files

### 1. **docker-compose.yml** (ENHANCED)
**Before:** Hardcoded to compile only `UScheduleSophie.tex`  
**After:** Dynamic compilation with environment variable support

**Key Improvements:**
- ✅ Compile ANY .tex file without editing docker-compose.yml
- ✅ Environment variables: `SCHEDULE` and `SCHEDULES`
- ✅ Batch compilation support (multiple files at once)
- ✅ Beautiful progress indicators and error messages
- ✅ Automatic error handling and log management
- ✅ Summary statistics after batch compilation

**Usage Examples:**
```bash
# Default (UScheduleSophie)
docker compose up

# Specific schedule
SCHEDULE=UScheduleSergio docker compose up

# Multiple schedules
SCHEDULES="UScheduleSophie,UScheduleSergio" docker compose up
```

**Windows PowerShell:**
```powershell
$env:SCHEDULE="UScheduleSergio"
docker compose up
```

---

### 2. **extract_pdf.py** (COMPLETELY REWRITTEN)
**Before:** Basic text extraction with hardcoded filename  
**After:** Full-featured CLI tool with multiple modes

**New Features:**
- ✅ CLI argument parsing (no hardcoded filenames!)
- ✅ Process single PDF or entire directories
- ✅ Compare multiple schedules side-by-side
- ✅ Parse and extract structured schedule information
- ✅ Save output to files
- ✅ Verbose mode for debugging
- ✅ Proper error handling and user-friendly messages
- ✅ Pattern matching for directory processing

**Usage Examples:**
```bash
# Extract text from one PDF
python extract_pdf.py Schedules/UScheduleSophie.pdf

# Process all PDFs in directory
python extract_pdf.py --directory Schedules/

# Compare schedules
python extract_pdf.py --compare Schedules/*.pdf

# Parse schedule information
python extract_pdf.py --parse Schedules/UScheduleSophie.pdf

# Save to file
python extract_pdf.py file.pdf --output output.txt

# Verbose mode
python extract_pdf.py --verbose --directory Schedules/
```

---

### 3. **compile.ps1** (NEW)
**Purpose:** PowerShell helper script for easier compilation

**Features:**
- ✅ Simple compilation commands
- ✅ List available schedules
- ✅ Compile all schedules at once
- ✅ Clean build artifacts
- ✅ Colorful output and progress indicators
- ✅ Automatic validation and error checking
- ✅ Cross-platform (Windows, Linux, macOS)

**Usage:**
```powershell
# List available schedules
.\compile.ps1 -List

# Compile one schedule
.\compile.ps1 UScheduleSophie

# Compile all schedules
.\compile.ps1 -All

# Clean build artifacts
.\compile.ps1 -Clean

# Get help
.\compile.ps1 -Help
```

---

### 4. **USAGE.md** (NEW)
**Purpose:** Comprehensive usage guide for all new features

**Includes:**
- Quick reference tables
- Workflow examples
- Troubleshooting guide
- Migration guide from old version
- Best practices and tips

---

## 🎯 Quick Start Guide

### First Time Setup

1. **No changes needed!** Your existing `.tex` files work as-is
2. Optional: Install Python dependencies for PDF extraction:
   ```bash
   pip install pypdf
   ```

### Compile Your First Schedule (New Way)

**Option 1: PowerShell Script (Easiest)**
```powershell
.\compile.ps1 UScheduleSophie
```

**Option 2: Docker Compose with Environment Variable**
```bash
SCHEDULE=UScheduleSophie docker compose up
```

**Option 3: Default Compilation**
```bash
docker compose up  # Compiles UScheduleSophie by default
```

---

## 🔄 Backward Compatibility

**100% backward compatible!**

- Running `docker compose up` still compiles `UScheduleSophie.tex` by default
- All existing `.tex` files work without modification
- No breaking changes to project structure

---

## 💡 Common Workflows

### Workflow 1: Create New Student Schedule

```bash
# 1. Copy template
cp Schedules/UScheduleSophie.tex Schedules/MySchedule.tex

# 2. Edit MySchedule.tex with your data

# 3. Compile
.\compile.ps1 MySchedule

# 4. PDF ready at Schedules/MySchedule.pdf
```

### Workflow 2: Update All Schedules for New Semester

```powershell
# Update all .tex files with new data, then:
.\compile.ps1 -All

# Or with Docker Compose:
$env:SCHEDULES="UScheduleSophie,UScheduleSergio,MySchedule"
docker compose up
```

### Workflow 3: Compare Student Schedules

```bash
# Find common classes between students
python extract_pdf.py --compare Schedules/UScheduleSophie.pdf Schedules/UScheduleSergio.pdf
```

### Workflow 4: Extract Schedule for Analysis

```bash
# Extract structured information
python extract_pdf.py --parse Schedules/UScheduleSophie.pdf

# Save to file for further processing
python extract_pdf.py --parse Schedules/UScheduleSophie.pdf --output analysis.txt
```

---

## 📊 Feature Comparison

| Feature | Before | After |
|---------|--------|-------|
| Compile specific schedule | Edit docker-compose.yml | `SCHEDULE=Name docker compose up` |
| Compile multiple schedules | Run multiple times | `SCHEDULES="Name1,Name2" docker compose up` |
| List available schedules | Manual `ls` | `.\compile.ps1 -List` |
| PDF extraction | Hardcoded filename | CLI with multiple modes |
| Error messages | Generic | Detailed with emojis |
| Progress indicators | None | Beautiful progress bars |
| Schedule comparison | Manual | `--compare` flag |
| Clean build files | Manual `rm` | `.\compile.ps1 -Clean` |

---

## 🐛 Troubleshooting

### Issue: PowerShell script won't run
**Solution:**
```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

### Issue: PDF extraction fails
**Solution:**
```bash
pip install pypdf
```

### Issue: Compilation fails
**Check:**
1. Logs in `build/ScheduleName.log`
2. Ensure `.tex` syntax is correct
3. Verify fonts are in `Fonts/` directory
4. Run `.\compile.ps1 -List` to verify schedule exists

### Issue: Docker not found
**Solution:** Install Docker Desktop from https://docker.com

---

## 🎨 Technical Details

### docker-compose.yml Changes

**Architecture:**
- Environment variables with defaults: `${SCHEDULE:-UScheduleSophie}`
- Shell functions for modular compilation logic
- IFS-based array parsing for batch mode
- Comprehensive error handling with exit codes
- Progress tracking with counters

**Error Handling:**
- Non-existent files detected before compilation
- Logs saved even on failure for debugging
- Exit codes properly propagated
- Detailed error messages

### extract_pdf.py Enhancements

**Architecture:**
- Object-oriented design with `PDFExtractor` class
- argparse for robust CLI interface
- Type hints for better code clarity
- Regex-based schedule information parsing
- Modular function design

**Features:**
- Graceful degradation (pypdf → PyPDF2 → error)
- Path-based file handling
- Configurable output formats
- Verbose logging mode

### compile.ps1 Features

**Architecture:**
- Parameter-based CLI interface
- Colored output functions
- Docker availability checking
- File existence validation
- Environment variable management

---

## 📚 Additional Resources

- **USAGE.md** - Detailed usage examples and workflows
- **README.md** - Original project documentation
- Build logs in `build/` directory for debugging

---

## 🚀 Next Steps

1. **Try it out:**
   ```powershell
   .\compile.ps1 -List
   .\compile.ps1 UScheduleSophie
   ```

2. **Extract and analyze:**
   ```bash
   python extract_pdf.py --parse Schedules/UScheduleSophie.pdf
   ```

3. **Create your own schedule:**
   - Copy an existing .tex file
   - Edit with your data
   - Compile with `.\compile.ps1 YourScheduleName`

4. **Explore batch processing:**
   ```powershell
   .\compile.ps1 -All
   ```

---

## ✅ Summary

Your YourLaTeXSchedule project now has:

✨ **Dynamic compilation** - No more editing docker-compose.yml  
✨ **Batch processing** - Compile multiple schedules at once  
✨ **Enhanced PDF tools** - Extract, compare, and analyze schedules  
✨ **Helper scripts** - PowerShell convenience commands  
✨ **Better UX** - Beautiful messages, progress indicators, error handling  
✨ **Production-ready** - Robust error handling, logging, and validation  

**All while maintaining 100% backward compatibility!**

---

**Happy Scheduling! 🎓📅**

*Created: February 1, 2026*  
*Enhanced LaTeX Schedule Compilation System*
