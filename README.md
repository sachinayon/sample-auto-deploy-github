# Auto Deploy to cPanel

Automatic deployment to cPanel/Hostinger when code is pushed to main branch.

## Setup

1. **Add GitHub Secrets** (Repository Settings → Secrets → Actions):
   - `FTP_HOST` - Your FTP hostname
   - `FTP_USER` - Your FTP username  
   - `FTP_PASS` - Your FTP password

2. **Create dev branch**:
   ```bash
   git checkout -b dev
   git push -u origin dev
   ```

3. **Test deployment**:
   - Make changes in `dev` branch
   - Create PR from `dev` → `main`
   - Merge PR
   - Files automatically deploy to your website

## How it works

- Push to `main` branch → automatic deployment
- Merge PR from `dev` to `main` → automatic deployment
- Files upload to `/public_html/` via FTP