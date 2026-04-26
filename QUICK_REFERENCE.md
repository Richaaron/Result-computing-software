# Quick Reference - Useful Commands

## 🚀 Getting Started

```bash
# Clone and setup
git clone <repo-url>
cd Result\ Software

# Install all dependencies
cd backend && npm install && cd ../frontend-react && npm install && cd ..

# Copy environment files
cp backend/.env.example backend/.env.local
cp frontend-react/.env.example frontend-react/.env.local
```

## 🐳 Docker Commands (Local Development)

```bash
# Start PostgreSQL & pgAdmin
docker-compose up -d

# Stop containers
docker-compose down

# View logs
docker-compose logs postgres

# Access pgAdmin
# URL: http://localhost:5050
# Email: admin@example.com
# Password: admin
```

## 💻 Backend Commands

```bash
# Navigate to backend
cd backend

# Install dependencies
npm install

# Start development server (with auto-reload)
npm run dev

# Build for production
npm run build

# Start production server
npm start

# Update packages
npm update

# Security audit
npm audit
npm audit fix
```

## ⚛️ Frontend Commands

```bash
# Navigate to frontend
cd frontend-react

# Install dependencies
npm install

# Start development server
npm run dev

# Build for production
npm run build

# Preview production build locally
npm run preview

# Linting
npm run lint

# Update packages
npm update
```

## 🔐 Environment Variables

### Generate JWT Secret
```bash
# macOS/Linux
openssl rand -base64 32

# Windows PowerShell
$random = New-Object System.Security.Cryptography.RNGCryptoServiceProvider
$bytes = New-Object 'System.Byte[]' 32
$random.GetBytes($bytes)
[Convert]::ToBase64String($bytes)
```

### Test Database Connection
```bash
# macOS/Linux
psql -U postgres -h localhost -d result_software

# Windows (using psql if installed)
psql -U postgres -h localhost -d result_software
```

## 🧪 Verification & Testing

```bash
# Run setup verification
# macOS/Linux
bash verify-setup.sh

# Windows PowerShell
.\Verify-Setup.ps1

# Check npm packages
npm list (in backend or frontend-react)

# Build frontend
cd frontend-react && npm run build

# View frontend bundle size
npm run build -- --analyze
```

## 🌐 Common URLs

| Service | URL | Default Credentials |
|---------|-----|-------------------|
| Frontend | http://localhost:5173 | admin/admin123 |
| Backend API | http://localhost:5000/api | - |
| pgAdmin | http://localhost:5050 | admin@example.com/admin |
| Database | localhost:5432 | postgres/postgres |

## 📊 Database Management

```bash
# Connect to PostgreSQL database
psql -U postgres -h localhost -d result_software

# Useful psql commands
\dt               # List all tables
\d+ users         # Describe users table
SELECT * FROM users;  # Query users
\q               # Quit psql
```

## 📈 Deployment

```bash
# Deploy to Vercel (requires Vercel CLI)
npm install -g vercel
vercel --prod

# Check deployment status
vercel ls

# View deployment logs
vercel logs
```

## 🔍 Debugging

```bash
# View backend logs
# Add to backend/.env.local
# DEBUG=*

# View frontend network requests
# Browser DevTools → Network tab

# Check Node process
# macOS/Linux
ps aux | grep node

# Windows PowerShell
Get-Process node

# Kill node process on port 5000
# macOS/Linux
lsof -ti:5000 | xargs kill -9

# Windows
netstat -ano | findstr :5000
taskkill /PID <PID> /F
```

## 📦 Package Management

```bash
# Add new package
npm install package-name

# Add dev dependency
npm install --save-dev package-name

# Remove package
npm uninstall package-name

# Check for outdated packages
npm outdated

# Update all packages
npm update

# Check package size
npm ls <package-name>

# NPM cache
npm cache clean --force
```

## 🎯 Git Commands

```bash
# Initialize git (if not done)
git init

# Add files
git add .

# Commit changes
git commit -m "Your message"

# Push to GitHub
git push origin main

# Pull latest changes
git pull origin main

# Create new branch
git checkout -b feature-name

# Switch branch
git checkout branch-name

# Merge branch
git merge branch-name
```

## 📋 Common Issues & Fixes

```bash
# Port already in use (port 5000)
# Kill process or change PORT in .env.local

# npm WARN deprecated
# Usually safe to ignore, but can fix with: npm audit fix

# Module not found error
rm -rf node_modules package-lock.json
npm install

# Database connection error
# Check DATABASE_URL and network connectivity

# Build fails
# Clear build cache: rm -rf dist, npm cache clean --force
```

## 🔗 Useful Resources

- [Node.js Documentation](https://nodejs.org/docs/)
- [Express.js Guide](http://expressjs.com/)
- [React Documentation](https://react.dev)
- [Vite Documentation](https://vitejs.dev)
- [Sequelize Documentation](https://sequelize.org)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Vercel Documentation](https://vercel.com/docs)
- [Supabase Documentation](https://supabase.com/docs)

## 💡 Pro Tips

- Use `.env.local` for local development (not committed to git)
- Create `.env.example` with placeholder values for documentation
- Always run `npm install` after pulling code with package.json changes
- Use `npm audit` regularly to check for security vulnerabilities
- Keep Node.js packages updated: `npm update`
- Test locally before pushing to production
- Monitor logs in production: Vercel Logs, Database Logs

---

Last Updated: April 2026

