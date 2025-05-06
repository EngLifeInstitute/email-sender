# Email-sender

## OPTION 1: Use SendGrid
 - You need a DNS registered
 - Create a free account at SendGrid 
 - Generate an API Key with Mail Send permission
    1. In Settings > API Key: Create an API key and save it in the ".env" file, in SENDGRID_API_KEY field
    2. In Settings > Sender Authentication: Add DNS records
    
    * Reference: [SendGrid](https://www.youtube.com/watch?v=H6X5t1amgAE&ab_channel=C%23Artisan)
 - If you are using Route 53 in AWS to host your DNS record, you can use the terraform file (Change the values for your use case):
    ```
    terraform init
    terraform plan
    terraform apply
    ```
 - You can delete the changes using:
    ```
    terraform destroy
    ```
 - Create and activate a python virtual environment (Windows || Inside of ../option-1/):
    ```
    python -m venv option_1_env
    .\option_1_env\Scripts\Activate
    ```
 - Install the project dependencies:
    ```
    pip install -r requirements.txt
    ```
 - Run the script inside of "../option-1/":
    ```
    python main.py
    ```
## OPTION 2: Use smtplib
 - Follow the instructions of this video: [Reference](https://www.youtube.com/shorts/Tuyai2xNwvE)
 - Create and activate a python virtual environment (Windows || Inside of ../option-2/):
    ```
    python -m venv option_2_env
    .\option_2_env\Scripts\Activate
    ```
 - Install the project dependencies:
    ```
    pip install -r requirements.txt
    ```
 - Run the script inside of "../option-2/":
    ```
    python main.py
    ```