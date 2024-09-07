#Introduction
This project demonstrates a simple CI/CD pipeline using GitHub, a Python script for monitoring new commits, and a Bash script to deploy the latest changes to a web server. The pipeline automates the process of checking for new commits in the repository, pulling the latest changes, and deploying them using Nginx on an EC2 instance or a local Linux environment.

#Features
Monitor GitHub Commits: A Python script that checks for new commits in the repository within the past 30 minutes.
Automated Deployment: A Bash script that clones or pulls the latest changes and deploys them to the server.
Nginx Integration: Nginx is restarted after deployment to serve the latest content.
File Management: Temporary deployment directories are automatically cleaned up after deployment.

#Prerequisites
Git: Ensure Git is installed on the system.
Nginx: A web server like Nginx is required to serve the deployed content.
Python: Python 3.x installed along with the requests library.
AWS EC2/Linux Instance: If you're using an AWS EC2 or local Linux instance, ensure it's properly configured.

#Installation
1. For Cloning the repository:
$git clone https://github.com/pandamanish/CI_CD_Pipeline.git
2. Install Python Dependencies:
pip install requests
3. Set Up Nginx:
sudo apt-get install nginx
sudo service nginx start- to start the nginx service
sudo service nginx status- for checking the nginx service working or not.
Install and configure Nginx as per your requirement. By default, Nginx serves content from /var/www/html.

#Configuration
Python Script Configuration:
The Python script uses a CONFIG dictionary containing the repository owner, name, branch, and GitHub access token. Ensure these details are updated in the Python script.
Bash Script Configuration:
Updated the repository URL and temp_directory ,deployment paths in the Bash script as per our server setup.

#Usage
1. Running the Python Script
The Python script commit_check.py checks for new commits in the last 30 minutes.
$python3 commit_check.py
It will print the number of new commits, if any, found in the last 30 minutes.

2. Running the Bash Script
The Bash script deploy.sh automates the deployment process. It clones or pulls the latest code from the repository, copies it to the web directory, and restarts Nginx.
$./deploy.sh

#Testing
1.Commit Test:
Make a new commit to the GitHub repository.
Run the Python script to verify it detects the new commit.
Run the Bash script to deploy the changes to the server.

2.Nginx Test:
After deployment,used corn job for every 60min check it is automatically running the script, accessed server's IP address in a browser to verify the updated content is being served by Nginx.

#Troubleshooting
1.Git Errors:
Ensure that the Git repository is correctly configured, and there are no issues with access permissions or missing directories.
2.Nginx Issues:
If Nginx fails to restart, check the Nginx logs to identify the root cause of the problem.
3.Python Script Errors:
Verify that the GitHub token is valid and has the necessary permissions to access the repository.
4.Bash script:
Please ensure the deployment directory is correctly setup else would need to make a temp directory to clone and then need to copy content and remove it.
