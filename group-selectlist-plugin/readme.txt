GROUP SELECT LIST, 1.1
======================
If the content of your select list needs more structure, you can now group the 
values.  This is done by adding a third column, the "group column" to the 
"List of Values SQL Statement".


TABLE OF CONTENTS
=================

* Installation and Update
* How to use
* Additional Details
* Uninstall
* Credits, License and Terms of Use
* Support
* Change Log


INSTALLATION
============
1. Ensure you are running Oracle APEX version 4.1 or higher
2. Unzip and extract all files
2. Access your target Workspace
3. Select the Application Builder
4. Select the Application where you wish to import the plug-in 
   (plug-ins belong to an application, not a workspace)
5. Access Shared Components > Plug-Ins
6. Click [Import >]
7. Browse and locate the installer file, item_type_plugin_com_oracle_apex_group_selectlist.sql
8. Complete the wizard

If the plug-in already exists in that application, you will need to confirm that you 
want to replace it.  Also, once imported, this plug-in can be installed into additional
applications within the same workspace.  Simply navigate to the Export Repository 
(Export > Export Repository), click Install, and then select the target application.
Once the install file is no longer needed, it can be removed from the Export Repository.


HOW TO USE
==========
1. Installation the plug-in (see INSTALLATION AND UPDATE)
2. Create a new page item
3. Pick "Plug-Ins" as type
4. Select the plug-in "Group Select List"
5. Follow the wizard
6. Have a look at the "List of Values" example for the SQL statement format the
   plug-in requires. 


ADDITIONAL DETAILS
==================
Remember to include your group column within your SQL Statement and also 
to order the result of your List of Values by the group column and then by 
the display column as shown below:

select e.ename as d,
       e.empno as r,
       d.dname as grp
  from emp e,
       dept d
 where d.deptno = e.deptno
 order by grp, d


UNINSTALL
=========
To completely remove the plug-in:

1. Access the plug-in under Shared Components > Plug-Ins
2. Click [Delete]
   Note: If the [Delete] button doesn't show that indicates the plug-in is in use within the
         application.  Click on 'Utilization' under 'Tasks' to see where it is used.


LICENSE AND TERMS OF USE
========================
Copyright 2013, Oracle. All rights reserved.

The plug-in is dual licensed under the MIT and GPL licenses:

  * http://www.opensource.org/licenses/mit-license.php
  * http://www.gnu.org/licenses/gpl.html

Terms of use: http://apex.oracle.com/plugins#TERMS


SUPPORT
=======
This plug-in is not part of Oracle Application Express software and is therefore not supported by Oracle Support.
Any issues with it can be discussed on the Application Express Forum at http://forums.oracle.com/forums/forum.jspa?forumID=137


CHANGE LOG
==========
v1.1 (10-Jan-2013)
-) Removed unsupported wwv_flow_utilities.add_null_value_entry call which caused a JavaScript error in APEX 4.2 (bug #16036196)

v1.0 (07-Oct-2010)
-) Initial edit
