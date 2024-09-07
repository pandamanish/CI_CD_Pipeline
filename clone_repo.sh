#!/bin/bash

REPO_URL="https://github.com/pandamanish/CI_CD_Pipeline.git"  # GitHub repository URL
DEPLOY_DIR="/var/www/html/CI_CD_Pipeline"  # Temporary deployment directory for cloning
TARGET_DIR="/var/www/html"  # copying to final directory
BRANCH="main"  # Branch 
NGINX_SERVICE="nginx"  # Name of the Nginx service
STATUS_FILE="/mnt/c/Users/17282/OneDrive/Documents/Python_Scripts/C_CD_Pipeline/status_file"

# Decalring a func to get the log messages with a timestamp for more details
log() {
    echo "$(date +"%Y-%m-%d %T") : $1"
}
# Check if the status file exists
if [ -f "$STATUS_FILE" ]; then
    log "Status file detected. Proceeding with deployment..."
    
    # Checking if the deployment directory exists, and create it if it doesn't
    if [ ! -d "$DEPLOY_DIR" ]; then
        log "Directory $DEPLOY_DIR does not exist. Creating it..."
        
        if sudo mkdir -p "$DEPLOY_DIR"; then #temp directory created for cloning
            log "Directory created successfully."
        else
            log "Failed to create directory $DEPLOY_DIR."
            exit 1
        fi

        log "Cloning repository..."
        if sudo git clone "$REPO_URL" "$DEPLOY_DIR"; then #cloning the repo 
            log "Repository cloned successfully."
        else
            log "Failed to clone repository."
            exit 1
        fi
    else # already exist then will just pull the changes 
        log "Directory exists. Pulling latest changes..."
        cd "$DEPLOY_DIR"
        if sudo git pull origin "$BRANCH"; then
            log "Latest changes pulled successfully."
        else
            log "Failed to pull changes from repository."
            exit 1
        fi
    fi

    # Copying the contents from the temp directory to the target directory (/var/www/html) 
    log "Copying files to $TARGET_DIR..."
    if sudo cp -r "$DEPLOY_DIR"/* "$TARGET_DIR"; then #just copying content from temp directory to target directory
        log "Files copied successfully."
    else
        log "Failed to copy files."
        exit 1
    fi

    # Removing the temp directory after copying
    log "Removing the $DEPLOY_DIR directory..."
    if sudo rm -rf "$DEPLOY_DIR"; then
        log "Directory $DEPLOY_DIR removed successfully."
    else
        log "Failed to remove the directory $DEPLOY_DIR."
        exit 1
    fi

    # Restarting Nginx service
    log "Restarting Nginx..."
    if sudo service "$NGINX_SERVICE" restart; then
        log "Nginx restarted successfully."
    else
        log "Failed to restart Nginx. Please check the logs."
        exit 1
    fi

    log "Deployment completed successfully."
    
    # Remove the status file after deployment
    rm -f "$STATUS_FILE"
else
    log "No status file detected. Skipping deployment."
fi
