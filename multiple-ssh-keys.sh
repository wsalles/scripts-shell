#!/usr/bin/env bash
# VARIABLES -------------------------------------------------------------------------------------------
name["personal"]="wsalles"
name["job"]="wallacesalles-hotmart"
email["personal"]="wallace_robinson@hotmail.com"
email["job"]="wallace.salles@hotmart.com"
key["personal"]="id_rsa_wallace_robinson@hotmail.com"
key["job"]="id_rsa"

type="$1"

# TESTS -----------------------------------------------------------------------------------------------
if [[ "${type}" = "job"  ]] || [[ "${type}" == "personal" ]]; then
  echo "Passed!"
else
  echo "Usage: $0 <type>" && echo "Type: [personal, job]" && exit 1;
fi

# RUN -------------------------------------------------------------------------------------------------

echo "Vamos usar o nome ${name[$type]}, o email ${email[$type]} e a chave ${key[$type]}"

ssh-add -D
ssh-add ~/.ssh/${key[$type]}
ssh-add -l

git config user.name ${name[$type]}
git config user.email ${email[$type]}


