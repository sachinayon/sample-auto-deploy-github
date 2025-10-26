# 🚀 Complete Setup Guide: Auto Deploy to cPanel/Hostinger

This guide will walk you through setting up automatic deployment to cPanel/Hostinger when a PR is merged from dev to main.

## 📋 Prerequisites

- GitHub account
- cPanel/Hostinger hosting account
- FTP/SFTP access credentials
- Basic knowledge of Git and GitHub

## 🛠️ Step-by-Step Setup

### Step 1: GitHub Repository Setup

1. **Create a new repository on GitHub**
   - Go to GitHub.com
   - Click "New repository"
   - Name it (e.g., "sample-auto-deploy-github")
   - Make it public or private (your choice)
   - Don't initialize with README (we already have files)

2. **Push this code to your repository**
   ```bash
   git init
   git add .
   git commit -m "Initial commit: Auto deploy setup"
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
   git push -u origin main
   ```

3. **Create dev branch**
   ```bash
   git checkout -b dev
   git push -u origin dev
   ```

### Step 2: Configure GitHub Secrets

1. **Go to your repository on GitHub**
2. **Click on "Settings" tab**
3. **Click on "Secrets and variables" → "Actions"**
4. **Click "New repository secret" and add these secrets:**

   | Secret Name | Description | Example |
   |-------------|-------------|---------|
   | `FTP_HOST` | Your FTP hostname | `ftp.yourdomain.com` |
   | `FTP_USER` | Your FTP username | `your_username` |
   | `FTP_PASS` | Your FTP password | `your_password` |
   | `FTP_PORT` | FTP port (optional) | `21` |
   | `FTP_PATH` | Remote directory (optional) | `/public_html/` |

### Step 3: Get Your FTP Credentials

#### For Hostinger:
1. Log into your Hostinger control panel
2. Go to "File Manager" or "FTP Accounts"
3. Note down:
   - **Host**: Usually `ftp.yourdomain.com` or your server IP
   - **Username**: Your FTP username
   - **Password**: Your FTP password
   - **Port**: Usually `21` for FTP, `22` for SFTP
   - **Path**: Usually `/public_html/` for main domain

#### For cPanel:
1. Log into your cPanel
2. Go to "File Manager" or "FTP Accounts"
3. Note down the same information as above

### Step 4: Test the Setup

1. **Make a test change in dev branch:**
   ```bash
   git checkout dev
   # Edit index.html or create a new file
   echo "<!-- Test deployment -->" >> index.html
   git add .
   git commit -m "Test: Add deployment test comment"
   git push origin dev
   ```

2. **Create a Pull Request:**
   - Go to your GitHub repository
   - Click "Compare & pull request" (should appear after pushing to dev)
   - Set base branch to `main` and compare branch to `dev`
   - Add a description: "Test deployment workflow"
   - Click "Create pull request"

3. **Merge the PR:**
   - Review the PR
   - Click "Merge pull request"
   - Confirm the merge

4. **Check deployment:**
   - Go to "Actions" tab in your GitHub repository
   - You should see the deployment workflow running
   - Wait for it to complete (usually 2-5 minutes)
   - Check your website to see if changes are deployed

### Step 5: Verify Deployment

1. **Check GitHub Actions:**
   - Go to Actions tab
   - Look for "Auto Deploy to cPanel/Hostinger" workflow
   - Check if it shows ✅ (success) or ❌ (failed)

2. **Check your website:**
   - Visit your domain
   - Look for the changes you made
   - Check the browser's developer tools for any errors

## 🔧 Troubleshooting

### Common Issues:

1. **"FTP connection failed"**
   - Check your FTP credentials
   - Verify FTP host and port
   - Ensure FTP account is active

2. **"Permission denied"**
   - Check if FTP path is correct
   - Verify FTP user has write permissions
   - Try using `/public_html/` as the path

3. **"Workflow not triggering"**
   - Ensure you're merging from dev to main
   - Check if the workflow file is in `.github/workflows/`
   - Verify the branch names match

4. **"Files not updating on website"**
   - Check if files are uploaded to correct directory
   - Clear browser cache
   - Check for any caching on your hosting

### Debug Steps:

1. **Check GitHub Actions logs:**
   - Go to Actions tab
   - Click on the failed workflow
   - Expand each step to see detailed logs

2. **Test FTP connection manually:**
   - Use an FTP client to test your credentials
   - Verify you can upload files to the target directory

3. **Check file permissions:**
   - Ensure uploaded files have correct permissions (644 for files, 755 for directories)

## 📁 Project Structure Explained

```
├── .github/
│   └── workflows/
│       └── deploy.yml          # GitHub Actions workflow
├── deploy/
│   └── deploy.sh              # Manual deployment script
├── index.html                 # Main project file
├── package.json               # Node.js configuration
├── README.md                  # Project documentation
├── env.example               # Environment variables template
└── .gitignore                # Git ignore rules
```

## 🎯 How It Works

1. **Trigger**: When a PR is merged from dev to main
2. **Preparation**: GitHub Actions checks out code and prepares files
3. **Deployment**: Files are uploaded to cPanel via FTP
4. **Verification**: Success/failure status is reported

## 🔄 Workflow Details

The GitHub Actions workflow:
- Runs on Ubuntu latest
- Triggers on PR merge or direct push to main
- Prepares files (excludes unnecessary files)
- Uploads to cPanel via FTP
- Reports success/failure

## 📞 Support

If you encounter issues:
1. Check the GitHub Actions logs
2. Verify your FTP credentials
3. Test FTP connection manually
4. Check file permissions on server

## 🎉 Success!

Once everything is working:
- Make changes in the `dev` branch
- Create PRs from dev to main
- Merge PRs to trigger automatic deployment
- Your website will update automatically!

---

**Next Steps:**
- Customize the deployment for your specific needs
- Add build processes if needed
- Set up notifications for deployment status
- Consider adding staging environment
