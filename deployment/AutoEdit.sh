#!/bin/bash
# Google Automator 
# This is the auto fix component to update documents. to compile and deploy web application

using_git_()
{
	cp -r gnglinuxdeployment/deployment/loaner ~/
	cd ~/loaner
	git init 
	git commit -m "Checking if flip worked"
	git remote add orginin $1
	git push -u origin master





}
 
#gcloud init 
#Afterwards lets start collecting the information we need from user input used https://stackoverflow.com/questions/18544359/how-to-read-user-input-into-a-variable-in-bash
#Will redplace {PRODID}
read -p 'Enter Project ID: ' projectID
#Replacing all the Project IDs in file 

sed -i "s/{PRODID}/$projectID/g" ~/gnglinuxdeployment/deployment/loaner/loaner/web_app/constants.py
sed -i "s/{PRODID}/$projectID/g" ~/gnglinuxdeployment/deployment/loaner/loaner/shared/config.ts
read -p 'Service Account Email: ' serviceAcct
#Create the Secret File and put it into the correct folder 
gcloud iam service-accounts keys create ~/gnglinuxdeployment/deployment/loaner/loaner/web_app/client-secret.json --iam-account $serviceAcct
#tHIS WILL REPLACE {APP_DOMAINS}

read -p 'Domain with Chrome Enterprised Enabled(example.com): ' domainName

sed -i "s/{APP_DOMAINS}/$domainName/g" ~/gnglinuxdeployment/deployment/loaner/loaner/shared/constants.py
 #THIS WILL REPLACE {ADMIN_EMAIL}
read -p 'Admin Email: ' adminEmail
sed -i "s/{APP_DOMAINS}/$domainName/g" ~/gnglinuxdeployment/deployment/loaner/loaner/shared/constants.py
#This will repalce {SEA} (send emails as )
sea="no-reply@$domainName"
sed -i "s/{SEA}/$domainName/g" ~/gnglinuxdeployment/deployment/loaner/loaner/shared/constants.py

#this will replace {SUPERADMINS_GROUP}technical-admins@example.com
sag="technical-admins@$domainName"
sed -i "s/{SUPERADMINS_GROUP}/$domainName/g" ~/gnglinuxdeployment/deployment/loaner/loaner/shared/constants.py
#THIS WILL REPLACE {OAUTH2ID}
read -p 'OAUTHID:  ' oauthID 
sed -i "s/{OAUTH2ID}/$domainName/g" ~/gnglinuxdeployment/deployment/loaner/loaner/shared/constants.py

#starting the Git Repository upload option
read -p 'Do you have a git Repository you are using? *Highly Recommended (Y/N)' response

if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
then
    read -p 'Paste in the Repository URL' gitUrl
    using_git_ "$gitUrl"
else
	cp -r gnglinuxdeployment/deployment/loaner ~/
   
fi

#copy it over to home.




#echo "Project ID: $projectID | Service Account Name: $serviceAcct | Domain: $domainName | Admin Email: $adminEmail"

#TEsting file replacement. 
file1=`cat ~/gnglinuxdeployment/deployment/UpdateMe.sh`
appConstants = `cat ~/gnglinuxdeployment/deployment/UpdateMe.sh`
#echo $file1
file2="$file1"
#replace string
strings='Google'
replaceMe='TEsting '

#sed -i 's/Google/testing/g' gnglinuxdeployment/deployment/AutoEdit.sh
echo ${file1//$strings/$replaceMe}
#worked!