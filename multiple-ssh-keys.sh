#!/usr/bin/env bash
#-----------------------------------------------------------------------------------------------------------------------#
#
#   * Website    : https://wallacesalles.dev
#   * Athor      : Wallace Salles
#   * Mainteiner : Wallace Salles
#   * Motivation: When you need to use more than 2 GitHub accounts on the same machine with the ssh-key.
# VARIABLES -------------------------------------------------------------------------------------------
declare -A name
declare -A email
declare -A key

name["personal"]="wsalles"
email["personal"]="wallace_robinson@hotmail.com"
key["personal"]="id_rsa_wallace_robinson@hotmail.com"

name["job"]="wallacesalles-hotmart"
email["job"]="wallace.salles@hotmart.com"
key["job"]="id_rsa"

type="$1"
USAGE_MSG="Usage: source $0 <type> \nType: [personal, job]"

# METHODS ---------------------------------------------------------------------------------------------
function task {
  echo -e "Let's the use:\n- ${name["$type"]}\n- ${email["$type"]}\n- ${key["$type"]}\n"
  ssh-add -D
  ssh-add ~/.ssh/${key["$type"]}
  ssh-add -l

  git config --global user.name ${name["$type"]}
  git config --global user.email ${email["$type"]}
}

# TESTS AND RUN ---------------------------------------------------------------------------------------
if [[ "${type}" == "job"  ]] || [[ "${type}" == "personal" ]]; then
  echo "Passed!"
  task
else
  echo -e ${USAGE_MSG};
fi

# -----------------------------------------------------------------------------------------------------
