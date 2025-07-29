# N8N Self-Host on Render with Supabase PostgreSQL

This project deploys n8n workflow automation tool on Render.com with Supabase PostgreSQL as the database backend.

## Prerequisites

1. **Render.com Account**: Sign up at [render.com](https://render.com)
2. **Supabase Account**: Sign up at [supabase.com](https://supabase.com)

## Supabase Setup

1. Create a new project in Supabase
2. Go to Settings > Database
3. Note down the following connection details:
   - Host
   - Database name
   - User (usually `postgres`)
   - Password
   - Port (usually `5432`)

## Render.com Deployment

1. Fork this repository
2. Connect your GitHub account to Render
3. Create a new Web Service
4. Connect your forked repository
5. **Set the following environment variables in Render Dashboard** (do NOT put sensitive data in code):

### Required Environment Variables (Set in Render Dashboard)

Go to your Render service → Environment tab and add these variables:

```
DB_POSTGRESDB_HOST=db.muaukcuuqquscvfnvhtz.supabase.co
DB_POSTGRESDB_DATABASE=postgres
DB_POSTGRESDB_USER=postgres
DB_POSTGRESDB_PASSWORD=your-actual-supabase-password
```

**🔒 Security Note**: Never commit passwords or sensitive credentials to your repository. Always use Render's Environment Variables feature.

### Example Values
```
DB_POSTGRESDB_HOST=db.abcdefghijklmnop.supabase.co
DB_POSTGRESDB_DATABASE=postgres
DB_POSTGRESDB_USER=postgres
DB_POSTGRESDB_PASSWORD=your-secure-password
```

**⚠️ Important**: Set these in Render's Environment Variables, not in your code files!

## Configuration Details

### Database Configuration
- **Type**: PostgreSQL
- **SSL**: Enabled (required for Supabase)
- **Schema**: public
- **Port**: 5432

### N8N Configuration
- **Environment**: Production
- **Protocol**: HTTPS
- **Port**: 5678
- **Timezone**: Asia/Bangkok

## Deployment Steps

1. Set environment variables in Render dashboard
2. Deploy the service
3. Wait for the build and deployment to complete
4. Access your n8n instance at `https://your-app-name.onrender.com`

## First Time Setup

1. Open your n8n instance URL
2. Create your admin account
3. Start building your workflows!

## Database Tables

N8N will automatically create the required database tables on first startup:
- `credential_entity`
- `execution_entity` 
- `workflow_entity`
- `webhook_entity`
- And other system tables

## Troubleshooting

### Database Connection Issues
- Verify your Supabase connection details
- Check that SSL is enabled
- Ensure your Supabase project is active
- **Important**: Replace placeholder values in `render.yaml` with your actual Supabase credentials:
  ```yaml
  - key: DB_POSTGRESDB_HOST
    value: "db.xxxxxxxxx.supabase.co"  # Replace with your actual host
  - key: DB_POSTGRESDB_PASSWORD
    value: "your-supabase-password"     # Replace with your actual password
  ```

### Deployment Issues
- Check Render deployment logs
- Verify all environment variables are set correctly
- Make sure your Dockerfile builds successfully
- **Port Issues**: Render automatically assigns a PORT - don't set it manually

### Common Errors and Solutions

#### Error: `connect ECONNREFUSED ::1:5432`
**Cause**: N8N is trying to connect to localhost instead of Supabase
**Solution**: Update the `DB_POSTGRESDB_HOST` in your `render.yaml` with your actual Supabase host

#### Error: `chmod: /start.sh: Operation not permitted`
**Cause**: Permission issues in Docker build process
**Solution**: We've simplified the Dockerfile to use environment variables only (no custom scripts)

#### Error: `No open ports detected`
**Cause**: N8N is not binding to Render's assigned PORT
**Solution**: We use `N8N_PORT=$PORT` environment variable which Render will substitute automatically

#### Error: `Permissions 0644 for n8n settings file`
**Cause**: File permission warning on Render
**Solution**: We've added `N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false` to suppress this

### Quick Fix Steps for Database Connection

1. **Get your Supabase credentials**:
   - Go to your Supabase project dashboard
   - Navigate to Settings > Database
   - Copy the Host URL (looks like `db.xxxxxxxxx.supabase.co`)
   - Copy your password

2. **Set Environment Variables in Render**:
   - Go to your Render service dashboard
   - Click on "Environment" tab
   - Add these variables:
     ```
     DB_POSTGRESDB_HOST=db.xxxxxxxxx.supabase.co
     DB_POSTGRESDB_DATABASE=postgres
     DB_POSTGRESDB_USER=postgres
     DB_POSTGRESDB_PASSWORD=your-actual-password
     ```

3. **Deploy**:
   - Render will automatically redeploy when you save environment variables
   - No need to push code changes for environment variable updates

## Environment Variables Reference

| Variable | Description | Where to Set | Example |
|----------|-------------|--------------|---------|
| `DB_POSTGRESDB_HOST` | Supabase database host | Render Environment | `db.xxx.supabase.co` |
| `DB_POSTGRESDB_DATABASE` | Database name | Render Environment | `postgres` |
| `DB_POSTGRESDB_USER` | Database username | Render Environment | `postgres` |
| `DB_POSTGRESDB_PASSWORD` | Database password | Render Environment | `your-password` |

**🔐 Security Best Practice**: All sensitive data should be set in Render's Environment Variables, never in your code repository.

## Support

For issues related to:
- **N8N**: [n8n Community](https://community.n8n.io/)
- **Render**: [Render Docs](https://render.com/docs)
- **Supabase**: [Supabase Docs](https://supabase.com/docs)
