# Result Software - Setup Guide

## Environment Setup

### Prerequisites
- Node.js 18.x
- npm or yarn
- Supabase account with PostgreSQL database
- Vercel account (for deployment)

### Local Development Setup

#### 1. Backend Configuration

```bash
cd backend
cp .env.example .env.local
```

Edit `.env.local` and fill in:
```
DATABASE_URL=postgresql://user:password@host:port/database  # From Supabase
JWT_SECRET=your_secure_random_string
PORT=5000
NODE_ENV=development
FRONTEND_URL=http://localhost:5173
```

#### 2. Frontend Configuration

```bash
cd frontend-react
cp .env.example .env.local
```

Edit `.env.local`:
```
VITE_API_URL=http://localhost:5000/api
```

#### 3. Install Dependencies & Start

```bash
# Backend
cd backend
npm install
npm run dev

# Frontend (new terminal)
cd frontend-react
npm install
npm run dev
```

### Deployment to Vercel

1. **Connect Repository**
   - Push code to GitHub
   - Import project in Vercel

2. **Set Environment Variables in Vercel**
   - Go to Settings → Environment Variables
   - Add from Supabase:
     - `DATABASE_URL` - PostgreSQL connection string
     - `JWT_SECRET` - Your JWT secret
     - `FRONTEND_URL` - Your Vercel frontend URL

3. **Deploy**
   - Auto-sync from GitHub or manual deploy via Vercel CLI

### Supabase Connection

Your DATABASE_URL format:
```
postgresql://postgres:[password]@[host]:5432/postgres
```

Find this in Supabase Dashboard:
- Home → Connect → Connection Pooler or Direct Connection

### Default Credentials (First Login)

After database sync, use:
- **Admin**
  - Username: `admin`
  - Password: `admin123`

- **Teacher**
  - Username: `teacher`
  - Password: `teacher123`

**⚠️ Change these in production!**

### Database Models

Auto-synced on startup:
- Users (Admin, Teacher, Parent roles)
- Students
- Subjects (Nigerian Curriculum)
- Results
- Attendance
- Settings
- StudentSubjects (many-to-many)

### API Endpoints

- `/api/auth` - Authentication
- `/api/students` - Student management
- `/api/results` - Result management
- `/api/attendance` - Attendance tracking
- `/api/teachers` - Teacher management
- `/api/settings` - System settings

All endpoints (except login) require JWT token in Authorization header.

### Troubleshooting

**CORS Error?**
- Check `FRONTEND_URL` environment variable matches your frontend

**Database Connection Failed?**
- Verify `DATABASE_URL` is correct
- Check Supabase IP whitelist if using direct connection

**Port Already in Use?**
- Change `PORT` in `.env.local` or kill process on port 5000

