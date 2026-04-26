# Vercel & Supabase Deployment Guide

## Prerequisites
- GitHub repository with your code pushed
- Vercel account (free tier available)
- Supabase account with PostgreSQL database
- Supabase connection string (DATABASE_URL)

## Step 1: Get Your Supabase Connection String

1. Go to [Supabase Dashboard](https://supabase.com/dashboard)
2. Select your project
3. Click **Settings** → **Database**
4. Copy the connection string under "Connection Pooler" or "Direct Connection"
   - Format: `postgresql://postgres:[password]@[host]:5432/[database]`
5. Note this down (you'll need it in Step 4)

## Step 2: Import Project to Vercel

1. Visit [Vercel Dashboard](https://vercel.com/dashboard)
2. Click **Add New** → **Project**
3. Select **Import Git Repository**
4. Connect your GitHub account and select the repository
5. Configure project settings:
   - **Framework Preset**: Choose "Other"
   - **Root Directory**: Leave blank (monorepo setup)
   - Click **Deploy** (we'll add env vars next)

## Step 3: Set Environment Variables in Vercel

1. Go to **Settings** → **Environment Variables**
2. Add these variables:

   | Variable | Value | Example |
   |----------|-------|---------|
   | `DATABASE_URL` | Your Supabase connection string | `postgresql://postgres:abc123@db.supabase.co:5432/postgres` |
   | `JWT_SECRET` | A secure random string (minimum 32 chars) | Generate: `openssl rand -base64 32` |
   | `FRONTEND_URL` | Your Vercel frontend URL | `https://yourapp.vercel.app` |
   | `NODE_ENV` | Set to `production` | `production` |

3. Select which environments these apply to:
   - ✓ Production
   - ✓ Preview
   - ✓ Development

4. Click **Save**

## Step 4: Configure Auto-Sync (Vercel + Supabase)

### Option A: Vercel Integration (Recommended)

1. In Vercel Project Settings → **Integrations**
2. Search for "Supabase"
3. Click **Add Integration**
4. Select your Supabase project
5. Select which variables to sync:
   - ✓ DATABASE_URL
   - Any other Supabase connection variables
6. Click **Connect**

This will automatically keep your DATABASE_URL updated in Vercel if you make changes in Supabase.

### Option B: Manual Approach

Skip the integration and manually paste the DATABASE_URL into Vercel when needed.

## Step 5: Deploy & Monitor

1. Your first deploy should start automatically
2. Monitor progress in **Deployments** tab
3. Check logs for any errors:
   - Backend logs: Shows database sync
   - Frontend logs: Shows build output
4. Once deployed (green checkmark), visit your URL

## Troubleshooting

### Build Fails with "Database connection error"
- ✓ Check DATABASE_URL is correct in Environment Variables
- ✓ Verify Supabase project is running (not paused)
- ✓ Check IP whitelist in Supabase (if using Direct Connection, whitelist Vercel IPs)

### CORS Errors in Frontend
- ✓ Check FRONTEND_URL environment variable is set correctly
- ✓ Update `FRONTEND_URL` to your actual Vercel deployment URL
- ✓ Redeploy after updating

### First Login Doesn't Work
- ✓ Database sync should create default users (admin/admin123)
- ✓ Check backend logs for seed data errors
- ✓ If no users found, login will show as failed

### "Cannot find module" errors
- ✓ Check `npm install` ran successfully in build logs
- ✓ Verify package.json has all dependencies listed
- ✓ Check node_modules is not in .gitignore

## Monitoring in Production

### Vercel Analytics
- Project Settings → **Analytics** to track page performance

### Application Monitoring
- Add Application Insights or similar for backend monitoring

### Database Monitoring
- Supabase Dashboard → **SQL Editor** to monitor queries
- Check logs for slow queries

## Manual Redeployment

To redeploy without code changes:
```bash
# Using Vercel CLI
vercel --prod

# Or redeploy from Vercel dashboard
# Settings → Deployments → Click three dots on a deployment → "Redeploy"
```

## Environment Variable Cheat Sheet

```bash
# Backend (Vercel)
DATABASE_URL=postgresql://...          # From Supabase
JWT_SECRET=your_secure_32_char_string  # Use: openssl rand -base64 32
FRONTEND_URL=https://yourapp.vercel.app
NODE_ENV=production
PORT=3000  # Vercel assigns automatically

# Frontend (Vercel)
VITE_API_URL=https://yourapp.vercel.app/api
```

## Cost Estimate

- **Vercel**: Free tier includes enough for this app
  - 100GB bandwidth/month
  - Unlimited deployments
  - 12 concurrent builds

- **Supabase**: Free tier includes:
  - 500MB database storage
  - 2GB bandwidth
  - Up to 50,000 monthly active users

For small school deployments, free tier is sufficient.

## Support

- [Vercel Documentation](https://vercel.com/docs)
- [Supabase Documentation](https://supabase.com/docs)
- [Vercel Community](https://github.com/vercel/community)

