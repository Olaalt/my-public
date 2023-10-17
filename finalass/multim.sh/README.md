# vagrant
 vagrentfile will be replace by vargant.sh after running vagrant init 
 cat <<EOF > is use to replace vagrant file with following script
# the slave node
setup: using ubuntu/focal64
slave hostname: bimslave
# Network: 
type:private network 
ip: fix 192.168.56.3

# Machine updates
update and upgrade the slave machine

# ssh
-creating an ssh pass 
-changing the passwd authentication from no to yes os that the user can ssh into it 
-restart system for change to apply 

# communication 
-install avahi-daemon which allows system ip discovery between nodes
_ install libnss-mdns this allows host name switching betweens nodes 


# Master node
configeration 
-CPU: 2
-RAM: 256 
os: ubuntu/focal64

# network 
-type: Private 
IP: Fix 192.168.56.4

# Machine updates
update and upgrade the slave machine

# ssh
-creating an ssh pass 
-changing the passwd authentication from no to yes os that the user can ssh login  via ssh using passwd
-restart system for change to apply 

# communication 
-install avahi-daemon which allows system ip discovery between nodes
_ install libnss-mdns this allows host name switching betweens nodes 

# vagrant up 
- will bring up the machines

# source provisioning.sh 
 will call this script to 

# Master node

-a user altschool is created 
-give the user a passwd 4040
-G added the user to the root group
-generate sshkey for altschool user
-copy ssh public key  to slave machine 

# LAMP

-update machine 
-install apache2 
-install ufw fire wall on Apache2
-install mysql