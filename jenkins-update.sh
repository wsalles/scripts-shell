#!/usr/bin/env bash
#-----------------------------------------------------------------------------------------------------------------------#
#
#   * Website    : https://wallacesalles.dev/
#   * Author     : Wallace Salles
#   * Mainteiner : Wallace Salles
#
#-----------------------------------------------------------------------------------------------------------------------#
# Jenkins Patch --------------------------------------------------------------------------------------------------------#
patch=/usr/lib/jenkins/jenkins.war

# Link External: Latest Version ----------------------------------------------------------------------------------------#
link_external=http://updates.jenkins-ci.org/latest/jenkins.war

# ----------------------------------------------------------------------------------------------------------------------#
# RUN ------------------------------------------------------------------------------------------------------------------#
## Steps:
echo -e "::::::::::::::::::::\n:: Update Jenkins ::\n::::::::::::::::::::\n\n"
# 1) Check Current Version
version=$(grep -Po '(?<=version>)[^<]+' /var/lib/jenkins/config.xml)
echo -e "Current Version: $version \n"

# 2) Save old version:
cp -f $patch $patch.$version
echo -e "Save old patch: [ $patch.$version ] \n"

# 3) Download Latest Version
echo -e "Download Latest Version: $link_external\n"
wget -O $patch $link_external

# 4) Apply Update: Restart Jenkins
echo -e "\nApply Update...\n"
systemctl restart jenkins
echo -e "Finish!"
