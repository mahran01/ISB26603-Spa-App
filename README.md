# ISB26603-Spa-App

## Section A: Application Development
Develop an application that will allow the user to book a facial treatment
appointment through the app. Users are allowed to choose one or more services. The 
list of services provided by the spa is as follows:<br />
1. Acne treatment<br />
2. Pigmentation & uneven skin tone treatment<br />
3. Dark circle & eye bag<br />
4. Birthmark & moles<br />
User is required to input their information in the app as follows:<br />
1. Name<br />
2. Email<br />
3. Contact No.<br />
4. Appointment date<br />
5. Appointment time<br />
You may design your app based on your creativity. Be sure to plan a good user 
flow to make sure that this app achieves its outcome which is to book a facial
appointment. Each input needs to be verified (Users are not allowed to leave it 
empty). Create a message that will alert/inform the users:<br />
1. Any field in the form is empty.<br />
2. Appointment is booked.<br />
First-time users are required to register their details as listed in table **users**. 
Users can edit registration details once they register. The app has a database to keep 
all the data. Create a database named **facialdb** which has three tables named **users**, 
**facialbook** and **admin**. The structure of the table is as follows:<br />

### Table 1: users
| Column     | Type     | 
| ---------- | -------- |
| userid     | INTEGER  |
| name       | TEXT     |
| email      | TEXT     |
| phone      | INTEGER  |
| username   | TEXT     |
| password   | TEXT     |

### Table 2: facialbook
| Column          | Type     | 
| --------------- | -------- |
| bookid          | INTEGER  |
| userid          | INTEGER  |
| appointmentdat  | DATE     |
| appointmenttime | TIME     |
| services        | TEXT     |

### Table 3: admin
| Column          | Type     | 
| --------------- | -------- |
| adminid         | INTEGER  |
| username        | TEXT     |
| password        | TEXT     |

### RUBRIC
#### Requirement
##### Users
Page 1 (Non-registered user)<br />
1. Display the front page of the apps<br />
2. View facial treatment services<br />
3. Users are required to register (username and password)<br />
Page 2 (Registered user)<br />
1. Login (username and password)<br />
2. Update the user's profile (Name, email, phone, password)<br />
Page 3 (Registered user)<br />
1. Fill in the booking form (User can choose more than one service)<br />
Page 4 (Registered user)<br />
1. View booking appointment (date, time, services)<br />
2. Update and Delete appointment<br />
##### Admin
1. Login (username and password)<br />
2. View registered users (Name, services, appointment date/time)<br />
3. Update and Delete registered users<br />
4. Logout<br />

## Section B: Project Report (5%)
The project report should consist of the following components:<br />
1. Cover page<br />
2. Plagiarism statement with student signature (Refer to Appendix 1)<br />
3. Clear listing of individual tasks (Refer to Appendix 2)<br />
4. Project section<br />
    1. The student should write a step-by-step on how to use their app.<br />
    2. Students need to provide screenshots of their app to support the steps described in (i).<br />
5. Reference section<br />
Students need to provide all references that they’ve used to complete this project (Minimum 5 references).<br />

## Section C: Project Presentation (5%)
1. Presentation must be carried out by ALL members of the group highlighting the main points of their project (Codes and Database).<br />
2. You are required to run your apps and demonstrate how your apps work.<br />
3. Presentation duration 10-15 minutes.<br />
