import os
import requests
from datetime import datetime, timedelta

# Configuration of Git details
CONFIG = {
    "url": "https://api.github.com",
    "repo_owner": "pandamanish",
    "repo_name": "CI_CD_Pipeline",
    "branch_name": "main",
    "token": "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"  # GitHub Personal Access Token
}

# Fetching timestamp of half an hour ago commits
def get_time():
    now = datetime.utcnow()
    get_min = now - timedelta(minutes=30)
    return get_min.isoformat() + "Z"  # GitHub requires the time to be in ISO 8601 format.

# To check for new commits in the past half an hour 
def check_for_new_commits():
    timestamp = get_time() #calling the get_time to get the timestamp of last 30 mins using the above predefined funtion.
    url = f"{CONFIG['url']}/repos/{CONFIG['repo_owner']}/{CONFIG['repo_name']}/commits" # using the url by rendering the config dictonary and adding commits at the end to get the commit specifically.
    headers = {"Authorization": f"token {CONFIG['token']}"}
    params = {"sha": CONFIG['branch_name'], "since": timestamp}

    response = requests.get(url, headers=headers, params=params, verify=False)# using the request library to hit the github api and storing it in response object.
    response.raise_for_status()
    commits = response.json()

    if len(commits) != 0: #if commits is not null then yes there is commit which was done within last 30 min. 
        print(f"{len(commits)} new commit(s) in the past half an hour.")
        with open('C:/Users/17282/OneDrive/Documents/Python_Scripts/C_CD_Pipeline/status_file', 'w')as f:
            f.write("New commits detected.")
    else:
        print("No new commits found in the last half an hour.")
        if os.path.exists('C:/Users/17282/OneDrive/Documents/Python_Scripts/C_CD_Pipeline/status_file'):
            os.remove('/path/to/status_file')

check_for_new_commits()
