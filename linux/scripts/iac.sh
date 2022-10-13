#!/bin/bash

# Variables
ADM_USERS=('gandalf' 'elrond' 'aragorn')
SLS_USERS=('bilbo' 'frodo' 'pippin' 'merry')
SEC_USERS=('sam' 'gimli' 'legolas' 'boromir')

USER_DIRS=('public' 'adm' 'sls' 'sec')
USER_GROUPS=('ADM' 'SLS' 'SEC')

echo -e "Creating Directories...\n"
for dir in "${USER_DIRS[@]}"
do
    mkdir /"$dir"
done

echo -e "Creating User Groups...\n"
for group in "${USER_GROUPS[@]}"
do
    groupadd "$group"
done

echo -e "Modify Directories Permissions...\n"
index=0
for dir in "${USER_DIRS[@]}"
do
    if [ $dir == "public" ];
    then
        chmod 777 /"$dir"
    else
        chown root:"${USER_GROUPS[$index]}" /"$dir" && chmod 770 /"$dir"
        let "index++"
    fi
done

# Create users for adm group
for name in "${ADM_USERS[@]}"
do
    echo -e "Creating User - $name ...\n"
    useradd "$name" -m -s /bin/bash -p $(openssl passwd -crypt Pass123) -G ADM && passwd -e "$name" > /dev/null
done

# Create users for sales group
for name in "${SLS_USERS[@]}"
do
    echo -e "Creating User - $name ...\n"
    useradd "$name" -m -s /bin/bash -p $(openssl passwd -crypt Pass123) -G SLS && passwd -e "$name" > /dev/null
done

# Create users for security group
for name in "${SEC_USERS[@]}"
do
    echo -e "Creating User - $name ...\n"
    useradd "$name" -m -s /bin/bash -p $(openssl passwd -crypt Pass123) -G SEC && passwd -e "$name" > /dev/null
done

echo -e "Done...\n"
