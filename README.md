# HKU Woodle Course System

Smart course companion that takes attendance via face recognition, launches the right dashboard UI, and emails students about upcoming classes. The system blends computer vision, PyQt5, and MySQL automation to demonstrate how applied AI can drive practical workflows.

## Problem & Outcome
- **Problem:** Manual attendance and fragmented course information frustrated HKU students.
- **Outcome:** Built a desktop assistant that recognises students in real time, logs attendance, surfaces class materials, and sends reminder emails—all powered by a single Python codebase.

## Feature Highlights
- **Face-recognition attendance:** OpenCV LBPH model (`face_capture.py`, `train.py`, `faces.py`) identifies students from a live webcam feed and writes login events to MySQL.
- **Adaptive GUI:** PyQt5 welcome window (`welcome_window.py`) checks whether a course starts within the next hour; it launches either a course-material view (`course_window.py`) or a timetable view (`timetable_window.py`).
- **Automated notifications:** `email_notification.py` fetches upcoming course data and emails students using Outlook SMTP credentials.
- **Database abstraction:** `database_model.py` wraps raw SQL to keep UI logic clean and makes it easier to port to other frameworks.

## Repository Layout
```
assets/                  Logos and UI imagery
config.py                Central place for DB credentials and constants
database_model.py        Query helpers (login tracking, timetable, upcoming courses)
face_capture.py          Capture labelled face images for new users
train.py                 Train LBPH recogniser (outputs train.yml + labels.pickle)
faces.py                 OpenCV window + text-to-speech attendance flow
faces_gui.py             PySimpleGUI alternative interface
welcome_window.py        PyQt5 launcher UI; routes to course/timetable windows
course_window.py         Course material display (slides, Zoom links, notes)
timetable_window.py      Weekly timetable view
email_notification.py    SMTP sender for class reminders
facerecognition.sql      MySQL schema + sample data
haarcascade/             Haar cascade XML models
requirements.txt         Python dependencies
```

## Environment Setup
```bash
conda create -n woodle python=3.9
conda activate woodle
pip install -r requirements.txt
```
Database:
```bash
mysql -u root -p
mysql> CREATE DATABASE facerecognition;
mysql> USE facerecognition;
mysql> SOURCE facerecognition.sql;
```
Update `config.py` with your database host/user/password and email credentials for Outlook (used by the notification module).

## End-to-End Workflow
1. **Capture training data**
   ```bash
   python face_capture.py     # configure user_name + NUM_IMGS at top of file
   ```
   Images are stored under `data/<user_name>/` for inspection.
2. **Train the recogniser**
   ```bash
   python train.py
   ```
   Produces `train.yml` (LBPH weights) and `labels.pickle` (id mapping).
3. **Run attendance + dashboard**
   ```bash
   python welcome_window.py   # PyQt5 UI
   # or python faces_gui.py    # PySimpleGUI variant
   ```
   When a face is recognised, `database_model.update_login_time` records the event, text-to-speech greets the student, and the UI opens the relevant screen.
4. **Send reminder emails (optional)**
   ```bash
   python email_notification.py
   ```
   Demonstrates how upcoming course data drives automated communications.

## Results & Learnings
- Reduced sign-in friction by eliminating manual password prompts; students authenticate by presence.
- Reused the same database layer across computer-vision, GUI, and notification modules, proving the design is modular enough for future web/mobile clients.
- Wrapped computer-vision models with user-friendly flows, highlighting experience bridging AI and UX.


