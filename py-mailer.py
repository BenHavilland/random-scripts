import sys, smtplib

SERVER = "smtp.sendgrid.com"
FROM = "yourgarage@email.com"
TO = ["5555555@vtext.com","my@email.com"]
SUBJECT = ""

try:
    TEXT = sys.argv[1]
except:
    TEXT = "Stop talking to yourself."

message = """
From: %s
To: %s
Subject: %s

%s
""" % (FROM, ", ".join(TO), SUBJECT, TEXT)

server = smtplib.SMTP_SSL(SERVER,465)
server.login('user', 'pass')
server.sendmail(FROM, TO, message)
server.quit()