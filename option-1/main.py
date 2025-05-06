import string
import secrets
import os
from sendgrid import SendGridAPIClient
from sendgrid.helpers.mail import Mail
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()

SENDGRID_API_KEY = os.getenv("SENDGRID_API_KEY")
FROM_EMAIL = os.getenv("FROM_EMAIL")  # Your verified sender email

# 1. Generate a random alphanumeric string
def generate_token(length=16):
    chars = string.ascii_letters + string.digits
    return ''.join(secrets.choice(chars) for _ in range(length))

# 2. Send email via SendGrid
def send_email(to_email, token):
    message = Mail(
        from_email=FROM_EMAIL,
        to_emails=to_email,
        subject='Your Verification Token',
        html_content=f'<p>Hello!</p><p>Your verification token is: <strong>{token}</strong></p>'
    )
    try:
        sg = SendGridAPIClient(SENDGRID_API_KEY)
        response = sg.send(message)
        print(f"Email sent to {to_email}. Status code: {response.status_code}")
    except Exception as e:
        print("Error sending email:", e)

# 3. Main function
def process_email(email):
    token = generate_token()
    print(f"Generated token for {email}: {token}")
    send_email(email, token)
    return {email: token}

# Example usage
if __name__ == "__main__":
    email_input = input("Enter your email: ")
    result = process_email(email_input)
    print("Email sent. Token saved:", result)
