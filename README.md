# Azure Mass Toolkit
This is a collection of scripts written in PowerShell for simple, but commonly needed mass operations on your Azure environments.

The list of scripts and their use is listed below:

* snapshot-mass-remover - For removing snapshots listed on a file.

## How to use
These scripts should be used after login on your Azure Tenant on the terminal. Manually adding the login step on these scripts is possible and will save you time on the execution of the scripts, but is not advised as the use of over automation for mass-item updates or removal on your cloud environment is highly critical and may lead to an enormous error.

## Limitations
As these scripts are to be run on terminal providing a set of arguments after logging in the needed Azure tenant, there are some limitations to take into consideration. Execution of these scripts is linear, meaning they should be run separately for each terminal session as a session collision might take place: one script per OS and Az login session. Scripts context run should also be taken into consideration as a way to ease its use: setting different Azure contexts (Tenant + Subscription) consequently takes more resources and time to process than organizing activities per context than per script or activity type.