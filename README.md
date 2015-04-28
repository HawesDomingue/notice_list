# ARL Notice List Application
Description: An Oracle ApEx application designed to organize members of notification lists at Applied Research Laboratories.

Authors:	K.C. Hawes-Domingue (EID: kh549) and Kahli Holmes (EID: kh27624)
			
Disclaimer: This application was created for educational purposes for a course at The University of Texas at Austin.

Instructions for Setup:
1) Create tables, sequences, and triggers:   From your Oracle ApEx workspace, go to the SQL Workshop > SQL Scripts. Upload all files in the ddl files folder and then run them in order (arl.ddl, arl.ddl2, arl.ddl3, arl.ddl4).
2) Insert some test data:   Go to the SQL Workshop menu > SQL Commands. Copy-paste the SQL code from data.sql into the text field and click Run. You should get a message that the command executed successfully.
3) Upload the application:   From the Application Builder, choose Import. Select the file called apex-app-with-object-definitions.sql. Leave File Type as "Database Application, Page or Component Export". Click Next, then Next to confirm. Leave settings at defaults and choose "Install Application". Leave "Install Supporting Objects" selected and click Next, then Install. Select "Run Application" to begin using the application, or "Edit Application" if you would like to add additional users or make changes.

Authentication:
When you inserted the test data in step 2, you were granted a "Test Admin" account that is tied to your ApEx user account and has admin authorization when using the Notice List application. Log in with your ApEx credentials to test out the application. For other users to gain access to the application, they must not only have an ApEx account, but have their employee information tied to the account via the "User" table. To give another ApEx user access to the application, go to the top-right icon that has a person with a wrench and select "Manage Users and Groups" > "Create User". You will then need to use the Object Browser to edit the "User" table and insert a row. When creating the entry, you will need the employee's employee_id from the ACTIVE_EMPLOYEES table and their ApEx username (a user_id will be generated automatically).

More data!
If you would like to test the application with fake employee data, use the application's "Upload Employee Data" wizard with the file emp_data.csv, following the steps to confirm and upload.
