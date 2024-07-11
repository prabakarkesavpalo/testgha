
# gh extension install github importer
gh extension install github/gh-actions-importer
gh actions-importer update

# set environment variables
gh actions-importer configure

✔ Which CI providers are you configuring?: Jenkins
Enter the following values (leave empty to omit):
✔ Personal access token for GitHub: ****************************************
✔ Base url of the GitHub instance: https://github.com/bbstogh/repo-public
✔ Personal access token for Jenkins: **********************************
✔ Username of Jenkins user: admin
✔ Base url of the Jenkins instance: http://20.198.168.77:8080

GITHUB_ACCESS_TOKEN=
GITHUB_INSTANCE_URL=https://github.com
JENKINS_ACCESS_TOKEN=
JENKINS_INSTANCE_URL=http://20.198.168.77:8080
JENKINS_USERNAME=admin

# Use importer to audit Jenkins jobs
gh actions-importer audit jenkins --output-dir tmp/audit

[2024-07-11 06:04:05] Logs: 'tmp/audit/log/valet-20240711-060405.log'
[2024-07-11 06:04:05] Auditing 'http://20.198.168.77:8080'
[2024-07-11 06:04:05] Output file(s):==========================================|
[2024-07-11 06:04:05]   tmp/audit/gh1/error.txt
[2024-07-11 06:04:05]   tmp/audit/gh1/config.json
[2024-07-11 06:04:05]   tmp/audit/test/error.txt
[2024-07-11 06:04:05]   tmp/audit/test/config.json
[2024-07-11 06:04:05]   tmp/audit/workflow_usage.csv
[2024-07-11 06:04:05]   tmp/audit/audit_summary.md
[2024-07-11 06:04:12] Secrets redacted in file(s):                              
[2024-07-11 06:04:12]   tmp/audit/gh1/config.json                               
[2024-07-11 06:04:12]   tmp/audit/log/valet-20240711-060054.log                 
[2024-07-11 06:04:12]   tmp/audit/gh1/error.txt                                 
[2024-07-11 06:04:12]   tmp/audit/test/config.json                              
[2024-07-11 06:04:12]   tmp/audit/test/error.txt    

# Use importer to migrate Jenkins jobs
gh actions-importer migrate jenkins --target-url https://github.com/bbstogh/repo-public --output-dir tmp/migrate --source-url http://20.198.168.77:8080/job/gh1

[2024-07-11 06:08:43] Logs: 'tmp/migrate/log/valet-20240711-060843.log'         
[2024-07-11 06:08:47] Pull request: 'https://github.com/bbstogh/repo-public/pull/1'