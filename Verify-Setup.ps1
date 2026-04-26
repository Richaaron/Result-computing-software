# Verify-Setup.ps1
# Result Software Setup Verification Script for PowerShell

Write-Host "================================" -ForegroundColor Cyan
Write-Host "Result Software Setup Verification" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""

# Check Node.js version
Write-Host "Checking Node.js version..." -ForegroundColor Yellow
$nodeVersion = node -v
Write-Host "✓ Node.js: $nodeVersion" -ForegroundColor Green
Write-Host ""

# Check npm version
Write-Host "Checking npm version..." -ForegroundColor Yellow
$npmVersion = npm -v
Write-Host "✓ npm: $npmVersion" -ForegroundColor Green
Write-Host ""

# Check backend dependencies
Write-Host "Checking backend dependencies..." -ForegroundColor Yellow
$backendNodeModules = Test-Path "backend/node_modules"
if ($backendNodeModules) {
    Write-Host "✓ Backend node_modules exists" -ForegroundColor Green
    cd backend
    $packages = @("express", "sequelize", "pg", "dotenv", "jsonwebtoken", "bcryptjs")
    foreach ($package in $packages) {
        $installed = npm list $package 2>&1 | Select-String "$package@"
        if ($installed) {
            Write-Host "  ✓ $installed" -ForegroundColor Green
        }
    }
    cd ..
} else {
    Write-Host "✗ Backend node_modules not found" -ForegroundColor Red
}
Write-Host ""

# Check frontend dependencies
Write-Host "Checking frontend dependencies..." -ForegroundColor Yellow
$frontendNodeModules = Test-Path "frontend-react/node_modules"
if ($frontendNodeModules) {
    Write-Host "✓ Frontend node_modules exists" -ForegroundColor Green
    cd frontend-react
    $packages = @("react", "vite", "axios", "react-router-dom", "tailwindcss")
    foreach ($package in $packages) {
        $installed = npm list $package 2>&1 | Select-String "$package@"
        if ($installed) {
            Write-Host "  ✓ $($installed)" -ForegroundColor Green
        }
    }
    cd ..
} else {
    Write-Host "✗ Frontend node_modules not found" -ForegroundColor Red
}
Write-Host ""

# Check environment files
Write-Host "Checking environment configuration..." -ForegroundColor Yellow
$backendEnv = Test-Path "backend/.env.local"
if ($backendEnv) {
    Write-Host "✓ Backend .env.local exists" -ForegroundColor Green
} else {
    Write-Host "⚠ Backend .env.local not found (create from .env.example)" -ForegroundColor Yellow
}

$frontendEnv = Test-Path "frontend-react/.env.local"
if ($frontendEnv) {
    Write-Host "✓ Frontend .env.local exists" -ForegroundColor Green
} else {
    Write-Host "⚠ Frontend .env.local not found (create from .env.example)" -ForegroundColor Yellow
}
Write-Host ""

# Check vercel.json
Write-Host "Checking Vercel configuration..." -ForegroundColor Yellow
$vercelJson = Test-Path "vercel.json"
if ($vercelJson) {
    Write-Host "✓ vercel.json exists" -ForegroundColor Green
} else {
    Write-Host "✗ vercel.json not found" -ForegroundColor Red
}
Write-Host ""

# Check frontend dist
Write-Host "Checking frontend build..." -ForegroundColor Yellow
$distDir = Test-Path "frontend-react/dist"
if ($distDir) {
    $distSize = (Get-ChildItem -Path "frontend-react/dist" -Recurse | Measure-Object -Property Length -Sum).Sum / 1MB
    Write-Host "✓ Frontend build exists (size: $([math]::Round($distSize, 2)) MB)" -ForegroundColor Green
    $indexHtml = Test-Path "frontend-react/dist/index.html"
    if ($indexHtml) {
        Write-Host "✓ dist/index.html found" -ForegroundColor Green
    }
} else {
    Write-Host "⚠ Frontend dist not found (run: npm run build)" -ForegroundColor Yellow
}
Write-Host ""

Write-Host "================================" -ForegroundColor Cyan
Write-Host "Setup Verification Complete!" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "1. Fill in backend\.env.local with your Supabase credentials"
Write-Host "2. Verify frontend-react\.env.local has VITE_API_URL set"
Write-Host "3. Start backend: cd backend && npm run dev"
Write-Host "4. Start frontend: cd frontend-react && npm run dev"
Write-Host "5. Access http://localhost:5173"
Write-Host ""
