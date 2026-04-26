# How to Find Your Supabase Connection String

## Step-by-Step Guide

### 1. Go to Supabase Dashboard
- Visit: https://supabase.com/dashboard
- Log in with your account

### 2. Select Your Project
- Click on your **Result Software** project (or whichever project you created)

### 3. Navigate to Database Settings
- On the left sidebar, click **Settings** (gear icon at bottom)
- Then click **Database** in the Settings menu

### 4. Find Connection String Section
You should see a section called **"Connection string"**

There are typically two options:
- **Connection Pooler** (recommended for serverless like Vercel)
- **Direct Connection** (for local development)

### 5. Copy the Connection String

#### For Vercel (Use Connection Pooler):
1. Click on the **Connection Pooler** tab
2. Make sure **Session mode** is selected
3. Copy the connection string that looks like:
   ```
   postgresql://postgres.[project-id]:[password]@db.[region].supabase.co:6543/postgres
   ```

#### For Local Development (Use Direct Connection):
1. Click on the **Direct Connection** tab
2. Copy the connection string that looks like:
   ```
   postgresql://postgres:[password]@db.[region].supabase.co:5432/postgres
   ```

### 6. Replace the Password Placeholder

The connection string will have `[YOUR-PASSWORD]` or similar placeholder.
Replace it with your actual Supabase password (the one you set when creating the project).

**Example:**
```
# Before:
postgresql://postgres:[YOUR-PASSWORD]@db.xxxxxxxxxxxx.supabase.co:5432/postgres

# After (with your actual password):
postgresql://postgres:MySecurePassword123@db.xxxxxxxxxxxx.supabase.co:5432/postgres
```

### 7. Add to Vercel Environment Variables

1. Go to [Vercel Dashboard](https://vercel.com/dashboard)
2. Click on your **Result Software** project
3. Go to **Settings** → **Environment Variables**
4. Click **Add New**
5. Create three environment variables:

| Name | Value | Environment |
|------|-------|-------------|
| `DATABASE_URL` | Your connection string (from step 5) | ✅ Production, Preview, Development |
| `JWT_SECRET` | A random 32-character string | ✅ Production, Preview, Development |
| `FRONTEND_URL` | Your Vercel URL (e.g., `https://resultsoftware.vercel.app`) | ✅ Production, Preview, Development |

6. Click **Save**

### 8. Redeploy on Vercel

1. Go to **Deployments** tab
2. Find your latest deployment
3. Click the **...** (three dots)
4. Select **Redeploy**
5. Wait for the build to complete

---

## 🎯 If You Still Can't Find It

### Check Your Email
Supabase sends you a welcome email with connection details. Look for:
- Project URL
- Database password
- Connection string

### Try This Alternative Path in Supabase:
1. Dashboard → Your Project
2. Look for **"Connect"** button (blue button, usually top-right)
3. Select **Python** or **Node.js** to see connection examples
4. Copy the connection string from there

### Still Stuck?
1. Your Supabase project URL is: `https://supabase.com/dashboard/project/[PROJECT-ID]`
2. Look for a **"Database"** or **"Settings"** section
3. The connection string usually starts with `postgresql://`

---

## 📝 Example Connection String

```
postgresql://postgres:your_secure_password123@db.abcdefghijk.supabase.co:5432/postgres
```

Breaking it down:
- `postgresql://` - Protocol
- `postgres` - Username (always postgres)
- `:your_secure_password123` - Your password
- `@db.abcdefghijk.supabase.co` - Supabase host (your region)
- `:5432` - Port (for direct connection) or `:6543` for pooler
- `/postgres` - Database name

---

## ✅ Verification

Once you've added all variables to Vercel and redeployed:
1. Visit your Vercel URL
2. Try logging in with:
   - **Username:** `admin`
   - **Password:** `admin123`

If you see the dashboard, it worked! ✨

