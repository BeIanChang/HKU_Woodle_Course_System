# Face Recognition

Face recognition using python and mysql.

*******

## Useage

### Environment

Create virtual environment using Anaconda.
```
conda create -n face python=3.x
conda activate face
pip install -r requirements.txt
```

### MySQL Install

[Mac](https://dev.mysql.com/doc/mysql-osx-excerpt/5.7/en/osx-installation-pkg.html)

[Ubuntu](https://dev.mysql.com/doc/mysql-linuxunix-excerpt/5.7/en/linux-installation.html)

[Windows](https://dev.mysql.com/downloads/installer/)

You'll obtain an account and password after installation, then you should modify the `faces.py`, with the corresponding
`user` and `passwd`:
```
# create database connection
myconn = mysql.connector.connect(host="localhost", user="root", passwd="xxxxx", database="facerecognition")
```

*******

## Run

### 1. Face Recognition

#### 1.1 Collect Face Data
```
"""
user_name = "Jack"   # the name
NUM_IMGS = 400       # the number of saved images
"""
python face_capture.py
```
The camera will be activated and the captured images will be stored in `data/Jack` folder.      
**Note:** Only one person’s images can be captured at a time.

#### 1.2 Train a Face Recognition Model
```
python train.py
```
`train.yml` and `labels.pickle` will be created at the current folder.



### 2. Database Design

#### 2.1 Define Database
```
Our database now: 
Users(user_id, user_name, user_email, user_login_time, user_login_date)
Teachers(user_id, student_id_string)
Students(user_id, teacher_office)
Courses(course_id, course_code, course_name, teacher_user_id, welcome_message)
Coursetimeslots(course_id, start_time, end_time, day_in_week, course_venue)
Registercourse(user_id, course_id)
```
#### 2.2 Import Database
Open mysql server and import the file `facerecognition.sql`.
```
# login the mysql command
mysql -u root -p

# create database.  'mysql>' indicates we are now in the mysql command line
mysql> CREATE DATABASE facerecognition;
mysql> USE facerecognition;

# import from sql file
mysql> source facerecognition.sql
```



### 3. Login Interface

#### 3.1 OpenCV GUI
```
python faces.py
```

#### 3.2 PySimpleGUI GUI
```
python faces_gui.py
```

The camera will be activated and recognize your face using the pretrained model.    
**You need to** implement other useful functions in this part.

