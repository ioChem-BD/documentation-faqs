To renew the platform license, the sysadmin has to follow the following steps:
   1. Shutdown the service   
   2. Replace the license file 
   3. Start the service

Previous considerations prior replacing license:
  * In the code examples,  *IOCHEMBD_HOME* is considered the base path where the software is installed 
  * All operations should be executed by the same linux user that installed and runs the software, unless otherwise advised


### 1. Shutdown the server 
Replacing the software license must be performed with the service stopped.

```bash
iochembd$  cd *IOCHEMBD_HOME*/apache-tomcat-7.0.37/bin
iochembd$  ./shutdown.sh
... wait one minute
iochembd$  ps -eaf | grep tomcat
... if there is no running process it has stopped properly otherwise kill the process
```

### 2. Replace the license file
Replace the outdated license file for the new one provided by the software development team (contact@iochem-bd.org) 
```bash
iochembd$  mv license.out *IOCHEMBD_HOME*/create/
```
Being license.out the new license file.


###3. Start the server###
Start the server again to load the license:
```bash
iochembd$   cd *IOCHEMBD_HOME*/apache-tomcat-7.0.37/bin
iochembd$   ./startup.sh
```
If everything runs as expected, the new license will be applied and the Create module will be fully accesible.