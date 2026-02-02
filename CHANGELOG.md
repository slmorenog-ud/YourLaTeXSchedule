# Changelog

All notable changes to YourLaTeXSchedule project.

## [2.0.0] - 2026-02-01

### 🎉 Major Enhancements

#### Added
- **Dynamic docker-compose.yml**: Environment variable support for flexible compilation
  - `SCHEDULE` variable for single schedule compilation
  - `SCHEDULES` variable for batch compilation
  - Default behavior maintained (UScheduleSophie)
  - Beautiful progress indicators and error messages
  - Compilation summary statistics
  
- **Enhanced extract_pdf.py**: Complete rewrite with professional CLI
  - argparse-based CLI interface
  - Directory processing mode (`--directory`)
  - Schedule comparison mode (`--compare`)
  - Structured parsing mode (`--parse`)
  - Output to file support (`--output`)
  - Verbose logging (`--verbose`)
  - Pattern matching for file selection
  - Object-oriented architecture
  - Type hints and documentation
  
- **PowerShell helper script (compile.ps1)**: Windows-friendly compilation tool
  - List available schedules (`-List`)
  - Compile single schedule by name
  - Compile all schedules (`-All`)
  - Clean build artifacts (`-Clean`)
  - Colorful output with emojis
  - Automatic validation and error checking
  - Comprehensive help (`-Help`)
  
- **Bash helper script (compile.sh)**: Linux/macOS compilation tool
  - Same features as PowerShell version
  - Cross-platform compatibility
  - POSIX-compliant
  
- **Documentation**:
  - USAGE.md - Comprehensive usage guide
  - ENHANCEMENTS.md - Detailed change summary
  - QUICKREF.md - Quick reference card
  - requirements.txt - Python dependencies
  
#### Changed
- docker-compose.yml: Refactored with modular shell functions
- extract_pdf.py: Completely rewritten with enhanced features
- Better error messages throughout all tools
- Improved user experience with progress indicators

#### Improved
- Error handling in Docker compilation
- Log file management (automatic move to build/)
- Font installation process (with validation)
- Exit codes and error propagation

### 🔄 Backward Compatibility
- ✅ 100% backward compatible
- ✅ Existing .tex files work without modification
- ✅ Default behavior unchanged (compiles UScheduleSophie)
- ✅ No breaking changes to project structure

### 📝 Technical Details

#### docker-compose.yml
- Added environment variables: `SCHEDULE`, `SCHEDULES`
- Implemented bash functions for modular logic
- IFS-based array parsing for batch mode
- Comprehensive error handling
- Progress tracking with counters
- Detailed compilation summary

#### extract_pdf.py
- Class-based architecture (`PDFExtractor`)
- argparse for CLI parsing
- Type hints for better code quality
- Regex-based schedule parsing
- Multi-mode operation (extract, compare, parse)
- Graceful library fallback (pypdf → PyPDF2)

#### Helper Scripts
- Parameter-based CLI interface
- Colored output for better UX
- Docker availability checking
- File existence validation
- Cross-platform support

---

## [1.0.0] - 2025-XX-XX

### Initial Release
- Basic docker-compose.yml for LaTeX compilation
- Simple extract_pdf.py for text extraction
- Support for custom fonts
- Build directory for auxiliary files
- Example schedules (UScheduleSophie, UScheduleSergio)
- Configuration templates

---

## Version Numbering

This project follows [Semantic Versioning](https://semver.org/):
- MAJOR version for incompatible API changes
- MINOR version for new functionality in a backward-compatible manner
- PATCH version for backward-compatible bug fixes

---

## Future Enhancements (Roadmap)

### Planned for v2.1.0
- [ ] GitHub Actions workflow for automated compilation
- [ ] Web interface for schedule visualization
- [ ] Calendar export (iCal format)
- [ ] Schedule conflict detection
- [ ] Makefile for alternative build system

### Planned for v2.2.0
- [ ] REST API for schedule management
- [ ] Database integration for schedule storage
- [ ] Multi-language support (i18n)
- [ ] Template marketplace

### Under Consideration
- [ ] Visual schedule editor
- [ ] Mobile app
- [ ] Real-time collaboration
- [ ] Integration with university systems

---

**Maintainer Notes:**
- All changes maintain backward compatibility
- Tests should be added before v3.0.0
- Documentation must be updated with each release

*Last Updated: February 1, 2026*
