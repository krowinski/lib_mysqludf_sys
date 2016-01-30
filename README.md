### lib_mysqludf_sys

A UDF library with functions to interact with the operating system. These functions allow you to interact with the execution environment in which MySQL runs.

### Tested on

Distributor ID: Debian
Description:    Debian GNU/Linux 8.3 (jessie)
Release:        8.3
Codename:       jessie

Mysql Percona:        5.6.28-76.1

### Preinstall (clean)
```Shell
apt-get install gcc libperconaserverclient18-dev percona-server-server-5.6
```

### Installation

```Shell
chmod 700 install.sh
```

```Shell
./install.sh 
```

### Testing

```Shell
 mysql -p

```

```SQL
mysql> SELECT CAST(lib_mysqludf_sys_info() AS CHAR(2048) CHARACTER SET utf8) as lib_mysqludf_sys_info, CAST(sys_eval('id') AS CHAR(2048) CHARACTER SET utf8) as sys_eval, sys_exec('echo 1') as sys_exec\G
*************************** 1. row ***************************
lib_mysqludf_sys_info: lib_mysqludf_sys version 0.0.3
             sys_eval: uid=102(mysql) gid=104(mysql) groups=104(mysql)

             sys_exec: 0
1 row in set (0.02 sec)
```


### Uninstall 

```SQL
DROP FUNCTION IF EXISTS lib_mysqludf_sys_info;
DROP FUNCTION IF EXISTS sys_get;
DROP FUNCTION IF EXISTS sys_set;
DROP FUNCTION IF EXISTS sys_exec;
DROP FUNCTION IF EXISTS sys_eval;
```

### Documenation 

This library `lib_mysqludf_sys` contains a number of functions that allows one to interact with the operating system.

1.  [`sys_eval`](#sys_eval) - executes an arbitrary command, and returns it's output.
2.  [`sys_exec`](#sys_exec) - executes an arbitrary command, and returns it's exit code.
3.  [`sys_get`](#sys_get) - gets the value of an environment variable.
4.  [`sys_set`](#sys_set) - create an environment variable, or update the value of an existing environment variable.

Use [`lib_mysqludf_sys_info()`](#lib_mysqludf_sys_info) to obtain information about the currently installed version of `lib_mysqludf_sys`.

##### sys_eval

`sys_eval` takes one command string argument and executes it, returning its output.

###### Syntax

sys_eval(**arg1**)

###### Parameters and Return Values

`**arg1**`

A command string valid for the current operating system or execution environment.

returns

Whatever output the command pushed to the standard output stream.

######  A Note of Caution

Be very careful in deciding whether you need this function. UDFs are available to all database users - you cannot grant EXECUTE privileges for them. As the commandstring passed to `sys_exec` can do pretty much everything, exposing the function poses a very real security hazard.

Even for a benign user, it is possible to accidentally do a lot of damage with it. The call will be executed with the privileges of the os user that runs MySQL, so it is entirely feasible to delete MySQL's data directory, or worse.

The function is intended for specialized MySQL applications where one needs extended control over the operating system. Currently, we do not have UDF's for ftp, email and http, and this function can be used to implement such functionality in case it is really necessary (datawarehouse staging areas could be a case in example).

You have been warned! If you don't see the hazard, please don't try to find it; just trust me on this.

If you do decide to use this library in a production environment, make sure that only specific commands can be run and file access is limited by using [AppArmor](http://www.novell.com/documentation/apparmor/index.html).

##### sys_exec

`sys_exec` takes one command string argument and executes it.

######  Syntax

sys_exec(**arg1**)

######  Parameters and Return Values

`**arg1**`

A command string valid for the current operating system or execution environment. 


returns


An (integer) exit code returned by the executed process.

######  A Note of Caution

Be very careful in deciding whether you need this function. UDFs are available to all database users - you cannot grant EXECUTE privileges for them. As the commandstring passed to `sys_exec` can do pretty much everything, exposing the function poses a very real security hazard.

Even for a benign user, it is possible to accidentally do a lot of damage with it. The call will be executed with the privileges of the os user that runs MySQL, so it is entirely feasible to delete MySQL's data directory, or worse.

The function is intended for specialized MySQL applications where one needs extended control over the operating system. Currently, we do not have UDF's for ftp, email and http, and this function can be used to implement such functionality in case it is really necessary (datawarehouse staging areas could be a case in example).

You have been warned! If you don't see the hazard, please don't try to find it; just trust me on this.

If you do decide to use this library in a production environment, make sure that only specific commands can be run and file access is limited by using [AppArmor](http://www.novell.com/documentation/apparmor/index.html).

#####  sys_get

`sys_get` takes the name of an environment variable and returns the value of the variable.

######  Syntax

sys_get([**arg1**)

######  Parameters and Return Values

`**arg1**`

A string that denotes the name of an environment value.

returns

If the variable exists, a string containing the value of the environment variable. If the variable does not exist, the function return NULL.

######  A Note of Caution

Be very careful in deciding whether you need this function. UDFs are available to all database users - you cannot grant EXECUTE privileges for them. The variables known in the environment where mysql runs are freely accessible using this function. Any user can get access to potentially secret information, such as the user that is running mysqld, the path of the user's home directory etc.

The function is intended for specialized MySQL applications where one needs extended control over the operating system.

You have been warned! If you don't see the hazard, please don't try to find it; just trust me on this.

##### sys_set

`sys_get` takes the name of an environment variable and returns the value of the variable.

######  Syntax

sys_set([**arg1, arg2**)

######  Parameters and Return Values

`**arg1**`

A string that denotes the name of an environment value.

`**arg2**`

An expression that contains the value that is to be assigned to the environment variable.

returns

0 if the assignment or creation succeed. non-zero otherwise.

######  A Note of Caution

Be very careful in deciding whether you need this function. UDFs are available to all database users - you cannot grant EXECUTE privileges for them. This function will overwrite existing environment variables.

The function is intended for specialized MySQL applications where one needs extended control over the operating system.

You have been warned! If you don't see the hazard, please don't try to find it; just trust me on this.


