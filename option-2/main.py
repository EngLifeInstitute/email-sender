import smtplib
import string
import secrets
from email.mime.text import MIMEText

# 1. Generate a random alphanumeric string
def generate_token(length=16):
    chars = string.ascii_letters + string.digits
    return ''.join(secrets.choice(chars) for _ in range(length))

# 2. Send email
def send_email(to_email, token):
    from_email = "youremail@example.com"
    password = "yourpassword"  # Consider using environment variables

    msg = MIMEText(f"Your verification token is: {token}")
    msg["Subject"] = "Your Token"
    msg["From"] = from_email
    msg["To"] = to_email

    # Connect to the SMTP server (Gmail example)
    with smtplib.SMTP_SSL("smtp.gmail.com", 465) as server:
        server.login(from_email, password)
        server.send_message(msg)

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
