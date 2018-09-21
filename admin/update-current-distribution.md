The update process of ioChem-BD is quite straighforward by the use of a **shell script  utility**  bundled with the platform. Its is advised to update as soon as you get the notification of new releases to fix bugs and get the latest functionalities. 
These are the steps to perform such update:
   1. Shutdown the service
   2. Backup application files and data (better run a [backup script](https://documentation.iochem-bd.org/backup-policy.html) if you already have one defined)
   3. Run update script and check process logs 
   4. Start the service


Previous considerations prior updating:
  * In the code examples,  *IOCHEMBD_HOME* is considered the base path where the software is installed 
  * All operations should be executed by the same linux user that installed and runs the software, unless otherwise advised

###1. Shutdown the server### 
Update process must be performed with the service stopped.

```bash
iochembd$  cd *IOCHEMBD_HOME*/apache-tomcat-7.0.37/bin/shutdown.sh
... wait one minute
iochembd$  ps -eaf | grep tomcat
... if there is no running process it has stopped properly otherwise kill the process
```

###2. Perform a backup of the application files and data###
Please review [backup script](https://documentation.iochem-bd.org/backup-policy.html) page on the documentation for more information about the backup process automation.

###3. Run update script###
The update script has been upgraded, please download the new one [here](/files/updater.sh) and replace the one inside  *IOCHEMBD_HOME/updates* folder

Then run the utility:
```bash
iochembd$   cd *IOCHEMBD_HOME*/updates
iochembd$   ./updater.sh
```

The update process will start downloading pending patches and applying them one by one until it reaches the latest. 
In case you get an error updating the platform, please copy the output text from the update tool and send it to contact@iochem-bd.org, we will contact you as soon as possible to aid you in this process.sdkgf

###4. Start the server###
Start the server again to apply latest updates:
```bash
iochembd$   cd *IOCHEMBD_HOME*/apache-tomcat-7.0.37/bin/startup.sh
```
This will finish the update process of the ioChem-BD platform.