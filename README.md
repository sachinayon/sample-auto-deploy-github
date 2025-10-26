# Sample Auto Deploy Project

This project demonstrates automatic deployment to cPanel/Hostinger when a PR is merged from dev to main branch.

## Features

- 🚀 Automatic deployment on PR merge
- 🔄 GitHub Actions workflow
- 📁 FTP/SFTP deployment to cPanel
- 🔐 Secure environment variables
- 📝 Complete setup documentation

## Project Structure

```
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Actions workflow
├── deploy/
│   └── deploy.sh              # Deployment script
├── index.html                 # Main project file
├── README.md                  # This file
└── .env.example              # Environment variables template
```

## Setup Instructions

### 1. GitHub Repository Setup

1. Create a new repository on GitHub
2. Push this code to your repository
3. Create two branches: `main` and `dev`

### 2. Environment Variables

Add these secrets to your GitHub repository (Settings → Secrets and variables → Actions):

- `FTP_HOST`: Your cPanel FTP host
- `FTP_USER`: Your FTP username
- `FTP_PASS`: Your FTP password
- `FTP_PORT`: FTP port (usually 21)
- `FTP_PATH`: Remote directory path (e.g., /public_html/)

### 3. Workflow Configuration

The GitHub Actions workflow (`.github/workflows/deploy.yml`) will:
- Trigger on PR merge from dev to main
- Build and prepare files
- Deploy to cPanel via FTP/SFTP

### 4. Testing

1. Make changes in the `dev` branch
2. Create a PR from `dev` to `main`
3. Merge the PR
4. Check GitHub Actions tab for deployment status
5. Verify deployment on your website

## Deployment Process

1. **Trigger**: PR merged from dev → main
2. **Build**: Prepare files for deployment
3. **Deploy**: Upload files to cPanel via FTP
4. **Verify**: Check deployment status

## Troubleshooting

- Check GitHub Actions logs for errors
- Verify FTP credentials are correct
- Ensure FTP path is accessible
- Check file permissions on server

## Support

For issues or questions, please check the GitHub Actions logs and verify your environment variables are correctly set.
