#!/usr/bin/env pwsh
<#
.SYNOPSIS
    PowerShell helper script for compiling LaTeX schedules with Docker

.DESCRIPTION
    Provides convenient shortcuts for common compilation tasks:
    - Compile single schedules
    - Compile all schedules at once
    - List available schedules
    - Clean build artifacts

.PARAMETER Schedule
    Name of the schedule to compile (without .tex extension)

.PARAMETER All
    Compile all .tex files in Schedules/ directory

.PARAMETER List
    List all available schedule files

.PARAMETER Clean
    Remove all build artifacts

.EXAMPLE
    .\compile.ps1 -Schedule UScheduleSophie
    Compiles UScheduleSophie.tex

.EXAMPLE
    .\compile.ps1 -All
    Compiles all schedules

.EXAMPLE
    .\compile.ps1 -List
    Lists all available schedules
#>

param(
    [Parameter(Position = 0)]
    [string]$Schedule,
    
    [switch]$All,
    [switch]$List,
    [switch]$Clean,
    [switch]$Help
)

# Color output functions
function Write-Success { param($msg) Write-Host "✅ $msg" -ForegroundColor Green }
function Write-Error { param($msg) Write-Host "❌ $msg" -ForegroundColor Red }
function Write-Info { param($msg) Write-Host "ℹ️  $msg" -ForegroundColor Cyan }
function Write-Header { param($msg) Write-Host "`n$msg" -ForegroundColor Yellow }

# Show help
if ($Help) {
    Get-Help $PSCommandPath -Detailed
    exit 0
}

# Check if Docker is available
try {
    docker --version | Out-Null
    if ($LASTEXITCODE -ne 0) { throw }
} catch {
    Write-Error "Docker is not installed or not in PATH"
    Write-Info "Install Docker Desktop from https://www.docker.com/products/docker-desktop"
    exit 1
}

# List available schedules
function Get-AvailableSchedules {
    $schedules = Get-ChildItem -Path "Schedules\*.tex" -ErrorAction SilentlyContinue
    return $schedules | ForEach-Object { $_.BaseName }
}

# List schedules
if ($List) {
    Write-Header "📚 Available Schedules:"
    $schedules = Get-AvailableSchedules
    
    if ($schedules) {
        foreach ($sched in $schedules) {
            $pdfExists = Test-Path "Schedules\$sched.pdf"
            $status = if ($pdfExists) { "✅" } else { "⚪" }
            Write-Host "  $status $sched"
        }
        Write-Info "`n✅ = PDF exists | ⚪ = Not compiled yet"
    } else {
        Write-Error "No .tex files found in Schedules/"
    }
    exit 0
}

# Clean build artifacts
if ($Clean) {
    Write-Header "🧹 Cleaning build artifacts..."
    
    if (Test-Path "build") {
        Remove-Item -Path "build\*" -Force -ErrorAction SilentlyContinue
        Write-Success "Cleaned build/ directory"
    }
    
    # Remove log files from Schedules/
    $logFiles = Get-ChildItem -Path "Schedules" -Filter "*.log" -ErrorAction SilentlyContinue
    if ($logFiles) {
        $logFiles | Remove-Item -Force
        Write-Success "Removed $($logFiles.Count) log file(s) from Schedules/"
    }
    
    Write-Success "Clean complete!"
    exit 0
}

# Compile all schedules
if ($All) {
    Write-Header "📚 Compiling all schedules..."
    
    $schedules = Get-AvailableSchedules
    
    if (-not $schedules) {
        Write-Error "No .tex files found in Schedules/"
        exit 1
    }
    
    $schedulesList = $schedules -join ","
    Write-Info "Schedules to compile: $schedulesList"
    
    $env:SCHEDULES = $schedulesList
    docker compose up
    
    if ($LASTEXITCODE -eq 0) {
        Write-Success "`nAll schedules compiled successfully!"
        Write-Info "PDFs are in Schedules/ directory"
    } else {
        Write-Error "Compilation failed. Check logs above."
        exit 1
    }
    
    exit 0
}

# Compile single schedule
if ($Schedule) {
    # Remove .tex extension if provided
    $Schedule = $Schedule -replace '\.tex$', ''
    
    # Check if file exists
    if (-not (Test-Path "Schedules\$Schedule.tex")) {
        Write-Error "Schedule not found: $Schedule.tex"
        Write-Info "`nAvailable schedules:"
        Get-AvailableSchedules | ForEach-Object { Write-Host "  • $_" }
        exit 1
    }
    
    Write-Header "📝 Compiling $Schedule.tex..."
    
    $env:SCHEDULE = $Schedule
    docker compose up
    
    if ($LASTEXITCODE -eq 0) {
        Write-Success "`nCompilation successful!"
        if (Test-Path "Schedules\$Schedule.pdf") {
            Write-Info "PDF: Schedules\$Schedule.pdf"
        }
    } else {
        Write-Error "Compilation failed. Check logs above."
        exit 1
    }
    
    exit 0
}

# No parameters - show help
Write-Header "🎓 YourLaTeXSchedule - Compilation Helper"
Write-Host @"

Usage:
  .\compile.ps1 <ScheduleName>    Compile a specific schedule
  .\compile.ps1 -All              Compile all schedules
  .\compile.ps1 -List             List available schedules
  .\compile.ps1 -Clean            Clean build artifacts
  .\compile.ps1 -Help             Show detailed help

Examples:
  .\compile.ps1 UScheduleSophie
  .\compile.ps1 -All
  .\compile.ps1 -List

"@

Write-Info "Run '.\compile.ps1 -List' to see available schedules"
