param(
    [Parameter(Position = 0)]
    [string]$Schedule,
    [switch]$All,
    [switch]$List,
    [switch]$Clean
)

function Get-AvailableSchedules {
    $schedules = Get-ChildItem -Path "Schedules\*.tex" -ErrorAction SilentlyContinue
    return $schedules | ForEach-Object { $_.BaseName }
}

if ($List) {
    Write-Host ""
    Write-Host "Available Schedules:" -ForegroundColor Yellow
    $schedules = Get-AvailableSchedules
    
    if ($schedules) {
        foreach ($sched in $schedules) {
            $pdfExists = Test-Path "Schedules\$sched.pdf"
            if ($pdfExists) {
                Write-Host "  [OK] $sched" -ForegroundColor Green
            } else {
                Write-Host "  [  ] $sched" -ForegroundColor Gray
            }
        }
    } else {
        Write-Host "No .tex files found in Schedules/" -ForegroundColor Red
    }
    exit 0
}

if ($Clean) {
    Write-Host "Cleaning build artifacts..." -ForegroundColor Yellow
    if (Test-Path "build") {
        Remove-Item "build\*" -Force
        Write-Host "Build directory cleaned" -ForegroundColor Green
    }
    exit 0
}

if ($All) {
    $schedules = Get-AvailableSchedules
    $schedulesList = $schedules -join ","
    Write-Host "Compiling all schedules: $schedulesList" -ForegroundColor Cyan
    $env:SCHEDULES = $schedulesList
    docker compose up
    exit $LASTEXITCODE
}

if ($Schedule) {
    Write-Host "Compiling: $Schedule" -ForegroundColor Cyan
    $env:SCHEDULE = $Schedule
    docker compose up
    exit $LASTEXITCODE
}

# No parameters - show help
Write-Host ""
Write-Host "YourLaTeXSchedule Compiler" -ForegroundColor Yellow
Write-Host ""
Write-Host "Usage:"
Write-Host "  .\compile.ps1 ScheduleName    Compile specific schedule"
Write-Host "  .\compile.ps1 -All            Compile all schedules"
Write-Host "  .\compile.ps1 -List           List available schedules"
Write-Host "  .\compile.ps1 -Clean          Clean build artifacts"
Write-Host ""
Write-Host "Examples:"
Write-Host "  .\compile.ps1 UScheduleSophie"
Write-Host "  .\compile.ps1 -All"
Write-Host ""
