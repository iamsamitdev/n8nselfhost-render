# N8N Self-Host on Render with Supabase PostgreSQL

This project deploys n8n workflow automation tool on Render.com with Supabase PostgreSQL as the database backend.

## ✨ Key Features

- 🚀 **One-click deployment** on Render.com
- 🐘 **PostgreSQL support** with Supabase integration
- 🔒 **Secure configuration** with environment variables
- 🌐 **HTTPS enabled** with proper webhook support
- 📊 **Task runners enabled** for better performance
- 🔧 **IPv6 compatibility fixes** for stable connections
- 🛡️ **Production-ready** with proper SSL configuration

## 🔄 Recent Updates

- ✅ Fixed IPv6 connection issues with Supabase
- ✅ Simplified Dockerfile for better compatibility
- ✅ Enabled task runners for improved performance
- ✅ Added SSL rejection unauthorized fix
- ✅ Configured dynamic port binding for Render
- ✅ Removed health check path issues

## 📁 Project Structure

```
n8nselfhost-render/
├── Dockerfile              # Simplified N8N container configuration
├── render.yaml             # Render.com deployment configuration
├── README.md              # This documentation
├── .env.example           # Environment variables template
└── .gitignore            # Git ignore rules for security
```

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

**Option 1: Direct Connection (แนะนำสำหรับ N8N)**
```
DB_POSTGRESDB_HOST=db.muaukcuuqquscvfnvhtz.supabase.co
DB_POSTGRESDB_DATABASE=postgres
DB_POSTGRESDB_USER=postgres.muaukcuuqquscvfnvhtz
DB_POSTGRESDB_PASSWORD=your-actual-supabase-password
```

**Option 2: Transaction Pooler (ถ้า Direct connection ไม่ทำงาน)**
```
DB_POSTGRESDB_HOST=aws-0-ap-southeast-1.pooler.supabase.com
DB_POSTGRESDB_DATABASE=postgres
DB_POSTGRESDB_USER=postgres.muaukcuuqquscvfnvhtz
DB_POSTGRESDB_PASSWORD=your-actual-supabase-password
```

**🔒 Security Note**: Never commit passwords or sensitive credentials to your repository. Always use Render's Environment Variables feature.

### Example Values
**Direct Connection:**
```
DB_POSTGRESDB_HOST=db.abcdefghijklmnop.supabase.co
DB_POSTGRESDB_DATABASE=postgres
DB_POSTGRESDB_USER=postgres.abcdefghijklmnop
DB_POSTGRESDB_PASSWORD=your-secure-password
```

**Transaction Pooler:**
```
DB_POSTGRESDB_HOST=aws-0-ap-southeast-1.pooler.supabase.com
DB_POSTGRESDB_DATABASE=postgres
DB_POSTGRESDB_USER=postgres.abcdefghijklmnop
DB_POSTGRESDB_PASSWORD=your-secure-password
```

**⚠️ Important**: Set these in Render's Environment Variables, not in your code files!

## Configuration Details

### Dockerfile Features
- **Base Image**: n8nio/n8n:latest
- **Protocol**: HTTPS with proper webhook URLs
- **Database**: PostgreSQL with SSL support
- **Security**: File permissions enforcement disabled for Render compatibility
- **Task Runners**: Enabled by default
- **IPv6 Issues**: Fixed with SSL rejection unauthorized disabled

### Database Configuration
- **Type**: PostgreSQL
- **SSL**: Enabled (required for Supabase)
- **SSL Reject Unauthorized**: Disabled (for compatibility)
- **Schema**: public
- **Port**: 5432

### N8N Configuration
- **Environment**: Production
- **Host**: 0.0.0.0 (binds to all interfaces)
- **Protocol**: HTTPS
- **Port**: Dynamic (assigned by Render via $PORT)
- **Timezone**: Asia/Bangkok
- **Task Runners**: Enabled
- **SSL Reject Unauthorized**: Disabled (for Supabase compatibility)

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

#### Error: `connect ENETUNREACH` IPv6 Connection Issues
**Cause**: N8N is trying to connect via IPv6 which may not be supported
**Solution**: 
1. Use Direct connection instead of Transaction pooler
2. Make sure your username includes the project reference: `postgres.your-project-ref`
3. We've added `DB_POSTGRESDB_SSL_REJECT_UNAUTHORIZED=false` to handle SSL issues

#### Error: `There was an error initializing DB`
**Cause**: Database connection configuration is incorrect
**Solution**: 
1. Verify your Supabase credentials are correct
2. Try switching between Direct connection and Transaction pooler
3. Check that your Supabase project is active and not paused

#### Error: `Command "sh" not found`
**Cause**: Trying to use shell commands not available in n8n image
**Solution**: We've simplified the Dockerfile to use only environment variables, no custom commands

#### Error: Deploy stuck "In Progress"
**Cause**: Health check or port binding issues
**Solution**: 
1. Removed health check path from render.yaml
2. Set N8N_HOST to 0.0.0.0 for proper binding
3. Use dynamic PORT assignment from Render

#### Error: `N8N_RUNNERS_ENABLED` deprecation warning
**Cause**: N8N will require task runners in future versions
**Solution**: We've enabled task runners by default with `N8N_RUNNERS_ENABLED=true`

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
   - Add these variables (แนะนำ Direct connection ก่อน):
     ```
     DB_POSTGRESDB_HOST=db.muaukcuuqquscvfnvhtz.supabase.co
     DB_POSTGRESDB_DATABASE=postgres
     DB_POSTGRESDB_USER=postgres.muaukcuuqquscvfnvhtz
     DB_POSTGRESDB_PASSWORD=your-actual-password
     ```

3. **หากมีปัญหา IPv6 หรือ Connection timeout**:
   - ลองเปลี่ยนเป็น Transaction pooler:
     ```
     DB_POSTGRESDB_HOST=aws-0-ap-southeast-1.pooler.supabase.com
     ```

3. **Deploy**:
   - Render will automatically redeploy when you save environment variables
   - No need to push code changes for environment variable updates

## Environment Variables Reference

### Built-in Variables (Configured in render.yaml)
| Variable | Value | Description |
|----------|-------|-------------|
| `N8N_ENVIRONMENT` | production | N8N environment mode |
| `N8N_HOST` | 0.0.0.0 | Bind to all interfaces |
| `N8N_PORT` | $PORT | Dynamic port from Render |
| `N8N_PROTOCOL` | https | Protocol for webhooks |
| `WEBHOOK_TUNNEL_URL` | https://n8nselfhost-render.onrender.com | Webhook base URL |
| `WEBHOOK_URL` | https://n8nselfhost-render.onrender.com | Webhook URL |
| `N8N_EDITOR_BASE_URL` | https://n8nselfhost-render.onrender.com | Editor access URL |
| `GENERIC_TIMEZONE` | Asia/Bangkok | Timezone setting |
| `DB_TYPE` | postgresdb | Database type |
| `DB_POSTGRESDB_PORT` | 5432 | PostgreSQL port |
| `DB_POSTGRESDB_SCHEMA` | public | Database schema |
| `DB_POSTGRESDB_SSL` | true | SSL enabled |
| `DB_POSTGRESDB_SSL_REJECT_UNAUTHORIZED` | false | SSL compatibility |
| `N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS` | false | Disable file permission checks |
| `N8N_RUNNERS_ENABLED` | true | Enable task runners |

### Required Variables (Set in Render Dashboard)
| Variable | Description | Where to Set | Example |
|----------|-------------|--------------|---------|
| `DB_POSTGRESDB_HOST` | Supabase database host | Render Environment | `db.xxx.supabase.co` |
| `DB_POSTGRESDB_DATABASE` | Database name | Render Environment | `postgres` |
| `DB_POSTGRESDB_USER` | Database username | Render Environment | `postgres.xxx` |
| `DB_POSTGRESDB_PASSWORD` | Database password | Render Environment | `your-password` |

**🔐 Security Best Practice**: All sensitive data should be set in Render's Environment Variables, never in your code repository.

## 🔧 Technical Notes

### Render.yaml Configuration
- Uses `sync: false` for database credentials (set via Render Dashboard)
- Dynamic port assignment with `$PORT` variable
- No custom startup commands for better compatibility
- Simplified configuration for stable deployments

### Dockerfile Optimizations
- Minimal changes to n8n base image
- Environment variables only (no custom scripts)
- IPv6 compatibility fixes
- SSL configuration for Supabase
- Task runners enabled for performance

### Database Connection Strategy
1. **Primary**: Direct connection to Supabase (recommended)
2. **Fallback**: Transaction pooler if direct connection fails
3. **SSL**: Enabled with unauthorized rejection disabled
4. **Schema**: Uses public schema by default

## Support

For issues related to:
- **N8N**: [n8n Community](https://community.n8n.io/)
- **Render**: [Render Docs](https://render.com/docs)
- **Supabase**: [Supabase Docs](https://supabase.com/docs)
