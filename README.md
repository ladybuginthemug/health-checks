

This repo will be populated with lots of fancy checks.


### health-checks
```
./checks.sh help

Usage: ./checks.sh [help|iam|resources|network|logs|security]

```

```
./checks.sh network

=======NETWORK INFORMATION==============================================================================================
1: lo: 
  
2: enp2s0: 
 
=======OPEN PORTS=======================================================================================================

Netid                State            Recv-Q           Send-Q           Local Address:Port           Peer Address:Port                                  
udp                  UNCONN                0                0                                                                           
tcp                  LISTEN                0                0                                        

=======EST CONNECTIONS==================================================================================================

State                Recv-Q           Send-Q           Local Address:Port           Peer Address:Port           Process                                            
CLOSE-WAIT           0                0                                                                                                                                               
ESTAB                0                0     
                                                                                        
=======SURICATA LOGS====================================================================================================

=======DOCKER INFORMATION===============================================================================================
Client: Docker Engine 


=======RUNNING CONTAINERS===============================================================================================

=======VIRTUAL MACHINES=================================================================================================

```

```
./checks.sh resources

=======SYSTEM UPTIME===============================================================
 09:26:08 up 1 days, 13:30,  0 users,  load average: 1.25, 1.52, 1.31

=======CPU USAGE===================================================================
%Cpu(s): 0.0 us,  0.0 sy,  0.0 ni, 0 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st

=======MEMORY USAGE================================================================
               total        used        free      shared  buff/cache   available
Mem:           
Swap:          

=======DISK USAGE==================================================================
Filesystem      Size  Used Avail Use% Mounted on

```

```
./checks.sh iam

=======IAM USER LIST================

=======IAM GROUP LIST===============

=======USERS WITH SUDO ACCESS=======
``` 

```
./checks.sh logs

========/var/log/*.log==============
```

```
./checks.sh security

=========RUNNING SERVICES=====================
*.service        loaded  active

=========FAILED LOGINS========================


=========ROOTKIT CHECK========================
You must be the root user to run this program.


```

