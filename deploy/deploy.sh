#!/bin/bash

# Deployment Script for cPanel/Hostinger
# This script can be used as an alternative to GitHub Actions
# or for manual deployments

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Load environment variables
if [ -f .env ]; then
    source .env
    print_status "Loaded environment variables from .env"
else
    print_warning "No .env file found. Using system environment variables."
fi

# Check required environment variables
required_vars=("FTP_HOST" "FTP_USER" "FTP_PASS")
for var in "${required_vars[@]}"; do
    if [ -z "${!var}" ]; then
        print_error "Required environment variable $var is not set"
        exit 1
    fi
done

# Set defaults
FTP_PORT=${FTP_PORT:-21}
FTP_PATH=${FTP_PATH:-/public_html/}
DEPLOY_TIMEOUT=${DEPLOY_TIMEOUT:-300}

print_status "Starting deployment process..."
print_status "Target: $FTP_HOST:$FTP_PORT$FTP_PATH"
print_status "User: $FTP_USER"

# Create deployment directory
DEPLOY_DIR="deploy-files"
if [ -d "$DEPLOY_DIR" ]; then
    rm -rf "$DEPLOY_DIR"
fi

mkdir -p "$DEPLOY_DIR"

# Copy files to deploy directory
print_status "Preparing files for deployment..."

# Check if there's a build directory
if [ -d "dist" ]; then
    print_status "Using dist directory for deployment"
    cp -r dist/* "$DEPLOY_DIR/"
elif [ -d "build" ]; then
    print_status "Using build directory for deployment"
    cp -r build/* "$DEPLOY_DIR/"
else
    print_status "Copying project files (excluding unnecessary files)"
    rsync -av --exclude='.git' \
              --exclude='.github' \
              --exclude='node_modules' \
              --exclude='.env' \
              --exclude='*.log' \
              --exclude='.DS_Store' \
              --exclude='Thumbs.db' \
              --exclude='deploy/' \
              ./ "$DEPLOY_DIR/"
fi

print_status "Files prepared in $DEPLOY_DIR directory"

# Deploy using lftp (if available)
if command -v lftp &> /dev/null; then
    print_status "Using lftp for deployment..."
    
    lftp -c "
    set ftp:ssl-allow no
    set net:timeout $DEPLOY_TIMEOUT
    set net:max-retries 3
    open -u $FTP_USER,$FTP_PASS $FTP_HOST
    cd $FTP_PATH
    mirror -R $DEPLOY_DIR/ . --delete --verbose
    quit
    "
    
    if [ $? -eq 0 ]; then
        print_success "Deployment completed successfully!"
    else
        print_error "Deployment failed!"
        exit 1
    fi
else
    print_warning "lftp not found. Please install lftp or use GitHub Actions for deployment."
    print_status "Files are ready in $DEPLOY_DIR directory"
    print_status "You can manually upload these files to your cPanel file manager"
fi

# Cleanup
rm -rf "$DEPLOY_DIR"
print_status "Cleanup completed"

print_success "Deployment process finished!"
print_status "Deployed at: $(date)"
print_status "Commit: $(git rev-parse HEAD 2>/dev/null || echo 'N/A')"
