====== Elk-Stack ======
Prerequisites:
  - Ansible
  - Python (including pip & docker-py)

Clone the repository and run the site.yml playbook using the hosts file in the same directory
After a couple of minutes you'll be able to get to the nginx server

Comments:
* The default user for the nginx is: username - amnon, passsword - Aa123456
You can always add more users using htpasswd command (or alternatively recreate the file and destroy amnon user using the same command and -c flag)
* If you are using firewall please allow port 80/tcp from the host server
  
  
====== MYSQL ======
- Clone the repository and run the "docker-compose" yaml file
- Every table in the Master server will automatically be copied to the Slave server
* The passwords for the DB servers are just "password"

