#!/usr/bin/env bash
#-----------------------------------------------------------------------------------------------------------------------#
#
#   * Website    : https://wallacesalles.dev
#   * Author     : Wallace Salles
#   * Mainteiner : Wallace Salles
#   * Motivation : When you need to use more than 2 GitHub accounts on the same machine with the ssh-key.
#                  Or when you need to setup more than 2 GPG Keys (two different emails)
#
# VARIABLES -------------------------------------------------------------------------------------------
declare -A name
declare -A email
declare -A key
declare -A signingKey

type="$1"
USAGE_MSG="Usage: source $0 <type> \nType: [personal, job]"

# GIT CONFIG -----------------------------------------------------------------------------------------------------------#
# PERSONAL INFO
name["personal"]=${GIT_PERSONAL_ACCOUNT_NAME:-"wsalles"}
email["personal"]=${GIT_PERSONAL_ACCOUNT_EMAIL:-"wallace_robinson@hotmail.com"}
key["personal"]=${GIT_PERSONAL_ACCOUNT_KEY:-"id_rsa"}
signingKey["personal"]=${GIT_PERSONAL_ACCOUNT_SIGNING_KEY}
# JOB INFO
name["job"]=${GIT_JOB_ACCOUNT_NAME}
email["job"]=${GIT_JOB_ACCOUNT_EMAIL}
key["job"]=${GIT_JOB_ACCOUNT_KEY}
signingKey["job"]=${GIT_JOB_ACCOUNT_SIGNING_KEY}

# METHODS ---------------------------------------------------------------------------------------------
function task {
  ssh-add -D
  ssh-add ~/.ssh/${key["$type"]}
  ssh-add -l

  git config --global user.name ${name["$type"]}
  git config --global user.email ${email["$type"]}
  git config --global commit.gpgsign true
  
  [ ! -z ${signingKey["$type"]} ] \
    && git config --global user.signingkey ${signingKey["$type"]} \
    || git config --global --unset user.signingkey
}

# TESTS AND RUN ---------------------------------------------------------------------------------------
if [[ "${type}" == "job"  ]] || [[ "${type}" == "personal" ]]; then
  task
  echo -e "\n+ New Git config:"
  git config --global --list | tail -n100
else
  echo -e ${USAGE_MSG};
fi

# -----------------------------------------------------------------------------------------------------
