# Ben: implement get function to pull data from database
from config import *

##### Template
        # mycursor = conn.cursor()
        # sql = ""
        # mycursor.execute(sql)
        # result = mycursor.fetchall()
        # return result   


############################ Pull Data from DB #############################
    # db connection function
def connect_db():
    conn = mysql.connector.connect(user=CONFIG_USER, password=CONFIG_PASSWORD,host=CONFIG_HOST,database=CONFIG_DATABASE)
    return conn

def get_user_email(conn, user_id):
    mycursor = conn.cursor()
    sql = """
    SELECT user_email FROM Users WHERE user_id = %s
    """
    mycursor.execute(sql, (user_id,))
    result = mycursor.fetchall()
    return result[0][0]

    ## Usage: for the redirection of the mainpage button 
    ## Variable: user_id
    ## Return: is there any course that will be started in an hours
    ## Return Type: Boolean
def get_is_course_start_in_an_hour(conn, user_id, time, weekday):
    #### Dummy Template (time should be range not equal)
    mycursor = conn.cursor()
    sql = """
    SELECT COUNT(*) AS is_class 
    FROM Registercourses rc
    JOIN Coursetimeslots cs ON rc.course_id = cs.course_id 
    WHERE rc.user_id = %s 
    AND cs.start_time >= %s 
    AND cs.start_time <= ADDTIME(%s, '01:00:00')
    AND cs.day_in_week = %s
    """
    mycursor.execute(sql, (user_id, time, time, weekday))
    result = mycursor.fetchall()
    return bool(result[0][0])

    ## Usage: get course data in course table
    ## Return: course_name, course_code, course_venue, teacher_message, zoom_link, lecture_note
    ## Return Type: Array
def get_course_in_an_hour(conn, user_id, time, weekday):
    mycursor = conn.cursor()
    sql = """
    SELECT c.course_name, c.course_code, cs.course_venue, c.teacher_message, c.zoom_link, c.lecture_note, u.user_name
    FROM Registercourses rc, Courses c, Coursetimeslots cs, users u
    WHERE rc.user_id = %s
    AND rc.course_id = c.course_id
    AND rc.course_id = cs.course_id
    AND c.teacher_user_id = u.user_id
    AND cs.start_time >= %s
    AND cs.start_time <= ADDTIME(%s, '01:00:00')
    AND cs.day_in_week = %s 
    """
    mycursor.execute(sql, (user_id, time, time, weekday))
    result = mycursor.fetchall()
    return result

    ## Usage: for the redirection of the mainpage button 
    ## Return: is there any course that will be started in an hours
    ## Return Type: Array
def get_name_time(conn):
    mycursor = conn.cursor()
    sql = """
    SELECT * FROM Users ORDER BY user_login_date DESC, user_login_time DESC
    """
    mycursor.execute(sql)
    result = mycursor.fetchall()
    return result[0][0],result[0][1], result[0][3]

    ## Usage: get course data in course table
    ## Return: ....
    ## Return Type: Array
def get_course_data(conn, course_id):
    mycursor = conn.cursor()
    sql = """
    SELECT * FROM Courses WHERE course_id = %s
    """
    mycursor.execute(sql, (course_id,))
    return mycursor.fetchall()

    ## Usage: get course time table of an user
    ## Return: ....
    ## Return Type: Array
def get_course_timetable(conn, user_id):
    mycursor = conn.cursor()
    sql = """
    SELECT cs.*
    FROM Registercourses rc
    JOIN Coursetimeslots cs ON rc.course_id = cs.course_id 
    WHERE rc.user_id = %s;
    """
    mycursor.execute(sql, (user_id,))
    return mycursor.fetchall()

    ############################ Update Data from DB #############################
    ##Usage: Update the login time of user after login
def update_login_time(conn, user_id, login_time, login_date):
    mycursor = conn.cursor()
    sql = """
        UPDATE Users
        SET user_login_time = %s, user_login_date = %s
        WHERE user_id = %s
    """
    mycursor.execute(sql, (login_time, login_date, user_id))
    conn.commit()
    mycursor.close()

def get_course_data(conn, day):
    mycursor = conn.cursor()
    sql = """
    SELECT C.course_code, C.course_name, CT.start_time, CT.end_time, CT.course_venue
    FROM Courses C
    JOIN Coursetimeslots CT ON C.course_id = CT.course_id
    WHERE CT.day_in_week = %s;
    """
    mycursor.execute(sql, (day,))
    return mycursor.fetchall()

# Testing
# conn= connect_db()
# print(get_is_course_start_in_an_hour(conn))
