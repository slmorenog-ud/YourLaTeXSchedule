#!/bin/bash
# LaTeX Schedule Compilation Helper for Linux/macOS
# Usage: ./compile.sh [schedule_name | --all | --list | --clean]

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;36m'
NC='\033[0m' # No Color

# Helper functions
success() { echo -e "${GREEN}✅ $1${NC}"; }
error() { echo -e "${RED}❌ $1${NC}"; }
info() { echo -e "${BLUE}ℹ️  $1${NC}"; }
header() { echo -e "\n${YELLOW}$1${NC}"; }

# Check if Docker is available
check_docker() {
    if ! command -v docker &> /dev/null; then
        error "Docker is not installed or not in PATH"
        info "Install Docker from https://docker.com"
        exit 1
    fi
}

# Get list of available schedules
get_schedules() {
    if [ -d "Schedules" ]; then
        find Schedules -name "*.tex" -type f -exec basename {} .tex \; | sort
    fi
}

# List schedules
list_schedules() {
    header "📚 Available Schedules:"
    
    schedules=$(get_schedules)
    
    if [ -z "$schedules" ]; then
        error "No .tex files found in Schedules/"
        exit 1
    fi
    
    while IFS= read -r schedule; do
        if [ -f "Schedules/$schedule.pdf" ]; then
            echo -e "  ${GREEN}✅${NC} $schedule"
        else
            echo -e "  ⚪ $schedule"
        fi
    done <<< "$schedules"
    
    info "\n✅ = PDF exists | ⚪ = Not compiled yet"
}

# Clean build artifacts
clean_build() {
    header "🧹 Cleaning build artifacts..."
    
    if [ -d "build" ]; then
        rm -rf build/*
        success "Cleaned build/ directory"
    fi
    
    # Remove log files from Schedules/
    if [ -d "Schedules" ]; then
        log_count=$(find Schedules -name "*.log" -type f | wc -l)
        if [ "$log_count" -gt 0 ]; then
            find Schedules -name "*.log" -type f -delete
            success "Removed $log_count log file(s) from Schedules/"
        fi
    fi
    
    success "Clean complete!"
}

# Compile single schedule
compile_single() {
    local schedule=$1
    
    # Remove .tex extension if provided
    schedule=${schedule%.tex}
    
    # Check if file exists
    if [ ! -f "Schedules/$schedule.tex" ]; then
        error "Schedule not found: $schedule.tex"
        info "\nAvailable schedules:"
        get_schedules | while read -r s; do
            echo "  • $s"
        done
        exit 1
    fi
    
    header "📝 Compiling $schedule.tex..."
    
    export SCHEDULE="$schedule"
    docker compose up
    
    if [ $? -eq 0 ]; then
        success "\nCompilation successful!"
        if [ -f "Schedules/$schedule.pdf" ]; then
            info "PDF: Schedules/$schedule.pdf"
        fi
    else
        error "Compilation failed. Check logs above."
        exit 1
    fi
}

# Compile all schedules
compile_all() {
    header "📚 Compiling all schedules..."
    
    schedules=$(get_schedules | tr '\n' ',' | sed 's/,$//')
    
    if [ -z "$schedules" ]; then
        error "No .tex files found in Schedules/"
        exit 1
    fi
    
    info "Schedules to compile: $schedules"
    
    export SCHEDULES="$schedules"
    docker compose up
    
    if [ $? -eq 0 ]; then
        success "\nAll schedules compiled successfully!"
        info "PDFs are in Schedules/ directory"
    else
        error "Compilation failed. Check logs above."
        exit 1
    fi
}

# Show help
show_help() {
    header "🎓 YourLaTeXSchedule - Compilation Helper"
    cat << EOF

Usage:
  ./compile.sh <ScheduleName>    Compile a specific schedule
  ./compile.sh --all             Compile all schedules
  ./compile.sh --list            List available schedules
  ./compile.sh --clean           Clean build artifacts
  ./compile.sh --help            Show this help message

Examples:
  ./compile.sh UScheduleSophie
  ./compile.sh --all
  ./compile.sh --list

EOF
    info "Run './compile.sh --list' to see available schedules"
}

# Main script
check_docker

case "${1:-}" in
    --list|-l)
        list_schedules
        ;;
    --all|-a)
        compile_all
        ;;
    --clean|-c)
        clean_build
        ;;
    --help|-h|"")
        show_help
        ;;
    *)
        compile_single "$1"
        ;;
esac
