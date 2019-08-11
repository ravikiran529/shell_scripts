#!/bin/bash
#To create new user:

usage(){
cat << EOF
Usage format:
 ====================================================
  password.sh [-u] <USER_NAME> [-p] <PASSWD>
     options: 
      u - Pass Username
      p - Set Password 
 ====================================================
EOF
exit 0
}
while getopts ":u:p:h" options; do
  case "${options}" in
     u)
       USER_NAME=${OPTARG}
       ;;
     p)
       PASSWD=${OPTARG}
       ;;
     h)
       usage
       ;;
     *)
       usage
       ;;
   esac
done

if [ -z "${USER_NAME}" ] || [ -z "${PASSWD}" ]
then
    echo "Username and password fields should not be empty."
    usage
fi

useradd ${USER_NAME} -p ${PASSWD}
if [ "$?" == "0" ]
then
    echo "New User: ${USER_NAME} created successfully!" 
else
    echo "User creation failed..Try another name."
fi
