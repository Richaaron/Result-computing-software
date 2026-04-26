#!/bin/bash

echo "================================"
echo "Result Software Setup Verification"
echo "================================"
echo ""

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check Node.js version
echo "Checking Node.js version..."
NODE_VERSION=$(node -v)
echo -e "${GREEN}✓ Node.js: $NODE_VERSION${NC}"
echo ""

# Check npm version
echo "Checking npm version..."
NPM_VERSION=$(npm -v)
echo -e "${GREEN}✓ npm: $NPM_VERSION${NC}"
echo ""

# Check backend dependencies
echo "Checking backend dependencies..."
cd backend
if [ -d "node_modules" ]; then
  echo -e "${GREEN}✓ Backend node_modules exists${NC}"
  echo "  - $(npm list | grep express)"
  echo "  - $(npm list | grep sequelize)"
  echo "  - $(npm list | grep pg)"
else
  echo -e "${RED}✗ Backend node_modules not found${NC}"
fi
cd ..
echo ""

# Check frontend dependencies
echo "Checking frontend dependencies..."
cd frontend-react
if [ -d "node_modules" ]; then
  echo -e "${GREEN}✓ Frontend node_modules exists${NC}"
  echo "  - $(npm list | grep react@)"
  echo "  - $(npm list | grep vite)"
  echo "  - $(npm list | grep axios)"
else
  echo -e "${RED}✗ Frontend node_modules not found${NC}"
fi
cd ..
echo ""

# Check environment files
echo "Checking environment configuration..."
if [ -f "backend/.env.local" ]; then
  echo -e "${GREEN}✓ Backend .env.local exists${NC}"
else
  echo -e "${YELLOW}⚠ Backend .env.local not found (create from .env.example)${NC}"
fi

if [ -f "frontend-react/.env.local" ]; then
  echo -e "${GREEN}✓ Frontend .env.local exists${NC}"
else
  echo -e "${YELLOW}⚠ Frontend .env.local not found (create from .env.example)${NC}"
fi
echo ""

# Check vercel.json
echo "Checking Vercel configuration..."
if [ -f "vercel.json" ]; then
  echo -e "${GREEN}✓ vercel.json exists${NC}"
else
  echo -e "${RED}✗ vercel.json not found${NC}"
fi
echo ""

# Check frontend dist
echo "Checking frontend build..."
cd frontend-react
if [ -d "dist" ]; then
  SIZE=$(du -sh dist | cut -f1)
  echo -e "${GREEN}✓ Frontend build exists (size: $SIZE)${NC}"
  if [ -f "dist/index.html" ]; then
    echo -e "${GREEN}✓ dist/index.html found${NC}"
  fi
else
  echo -e "${YELLOW}⚠ Frontend dist not found (run: npm run build)${NC}"
fi
cd ..
echo ""

echo "================================"
echo "Setup Verification Complete!"
echo "================================"
echo ""
echo "Next steps:"
echo "1. Fill in backend/.env.local with your Supabase credentials"
echo "2. Verify frontend-react/.env.local has VITE_API_URL set"
echo "3. Start backend: cd backend && npm run dev"
echo "4. Start frontend: cd frontend-react && npm run dev"
echo "5. Access http://localhost:5173"
echo ""
