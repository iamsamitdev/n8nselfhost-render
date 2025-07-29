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
5. Set the following environment variables in Render:

### Required Environment Variables

```
SUPABASE_DB_HOST=your-supabase-host
SUPABASE_DB_NAME=postgres
SUPABASE_DB_USER=postgres
SUPABASE_DB_PASSWORD=your-supabase-password
```

### Example Values
```
SUPABASE_DB_HOST=db.abcdefghijklmnop.supabase.co
SUPABASE_DB_NAME=postgres
SUPABASE_DB_USER=postgres
SUPABASE_DB_PASSWORD=your-secure-password
```

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

#### Error: `No open ports detected`
**Cause**: N8N is not binding to Render's assigned PORT
**Solution**: This is fixed with our startup script that uses `$PORT` environment variable

#### Error: `Permissions 0644 for n8n settings file`
**Cause**: File permission warning on Render
**Solution**: We've added `N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false` to suppress this

### Quick Fix Steps for Database Connection

1. **Get your Supabase credentials**:
   - Go to your Supabase project dashboard
   - Navigate to Settings > Database
   - Copy the Host URL (looks like `db.xxxxxxxxx.supabase.co`)

2. **Update render.yaml**:
   - Replace `db.xxxxxxxxx.supabase.co` with your actual host
   - Replace `your-supabase-password` with your actual password

3. **Redeploy**:
   - Push changes to your repository
   - Render will automatically redeploy

## Environment Variables Reference

| Variable | Description | Example |
|----------|-------------|---------|
| `SUPABASE_DB_HOST` | Supabase database host | `db.xxx.supabase.co` |
| `SUPABASE_DB_NAME` | Database name | `postgres` |
| `SUPABASE_DB_USER` | Database username | `postgres` |
| `SUPABASE_DB_PASSWORD` | Database password | `your-password` |

## Support

For issues related to:
- **N8N**: [n8n Community](https://community.n8n.io/)
- **Render**: [Render Docs](https://render.com/docs)
- **Supabase**: [Supabase Docs](https://supabase.com/docs)
