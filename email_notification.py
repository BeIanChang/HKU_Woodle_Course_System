import smtplib
from datetime import datetime, timedelta
from email.message import EmailMessage
import database_model as db
from PyQt5.QtWidgets import QApplication, QMainWindow, QLabel
from PyQt5.QtCore import Qt

"""
EMAIL_ACCOUNT = "hkuwoodle@163.com"
EMAIL_PASSWORD = "JSECUMKJKFVTDMJZ"
"""
EMAIL_ACCOUNT = "hkuwoodle@outlook.com"
EMAIL_PASSWORD = "woodlehku1120"

class Ui_EmailWindow(object):
    def setupUi(self, MainWindow, message):
        MainWindow.setObjectName("MainWindow")
        MainWindow.resize(400, 200)

        # Central Widget
        self.centralwidget = QLabel(MainWindow)
        self.centralwidget.setText(message)
        self.centralwidget.setAlignment(Qt.AlignCenter)

        MainWindow.setCentralWidget(self.centralwidget)

def send_email(receiver_email, course_info):
    # email configuration
    mail_host = "smtp.office365.com"
    mail_user = EMAIL_ACCOUNT
    mail_pass = EMAIL_PASSWORD
    smtp_port = 587  # Use 587 if using starttls()
    

    # Create email message
    message = EmailMessage()
    message['Subject'] = "Upcoming course notification"
    message['From'] = mail_user
    message['To'] = receiver_email

    # Prepare email body
    message_body = f"(Auto generated email, please don't reply)\n\n"
    message_body += f"Dear student,\n\nHere is the course information for your upcoming class:\n\n"
    message_body += f"Course name: {course_info[0][0]}\n"
    message_body += f"Course code: {course_info[0][1]}\n"
    message_body += f"Classroom address: {course_info[0][2]}\n"
    message_body += f"Teacher's message: {course_info[0][3]}\n"
    message_body += f"Zoom link: {course_info[0][4]}\n"
    message_body += f"Tutorial/Lecture Notes: {course_info[0][5]}\n\n"
    
    message.set_content(message_body)

    try:
        
        with smtplib.SMTP(mail_host, smtp_port) as server:
            server.starttls()
            server.login(mail_user, mail_pass)
            server.send_message(message)
        return "Email sent successfully."
    except smtplib.SMTPAuthenticationError:
        print("SMTP Authentication Error: Check your username and password.")
        return "SMTP Authentication Error: Check your username and password."
    except smtplib.SMTPException as e:
        print(f"Failed to send email: {str(e)}")
        return f"Failed to send email: {str(e)}"

if __name__ == "__main__":
    conn = db.connect_db()
    course_info = db.get_course_in_an_hour(conn, 1, "10:30", "2")
    print(course_info)
    send_email("yitjunyam@gmail.com", course_info)