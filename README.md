### lib_mysqludf_sys
A UDF library with functions to interact with the operating system. These functions allow you to interact with the execution environment in which MySQL runs.

## Tested on

Distributor ID: Debian
Description:    Debian GNU/Linux 8.3 (jessie)
Release:        8.3
Codename:       jessie

Mysql Percona:        5.6.28-76.1

## Preinstall (clean)
```Shell
apt-get install gcc libperconaserverclient18-dev percona-server-server-5.6
```

##Instalation

```Shell
chmod 700 install.sh
```

```Shell
./install.sh 
```

## Testing

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


## Uninstall 

```SQL
DROP FUNCTION IF EXISTS lib_mysqludf_sys_info;
DROP FUNCTION IF EXISTS sys_get;
DROP FUNCTION IF EXISTS sys_set;
DROP FUNCTION IF EXISTS sys_exec;
DROP FUNCTION IF EXISTS sys_eval;
```




