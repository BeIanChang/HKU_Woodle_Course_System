############Import Library#############
import urllib
import numpy as np
import mysql.connector
import cv2
import pyttsx3
import pickle
from datetime import datetime
import sys
import PySimpleGUI as sg

############Local database#############
CONFIG_HOST="localhost"
CONFIG_USER="root"
CONFIG_PASSWORD="Zs55432102" ##change this to your local root password
CONFIG_DATABASE="facerecognition"
