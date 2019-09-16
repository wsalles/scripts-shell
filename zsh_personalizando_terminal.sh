# Carrega função para verificar instalação
. ./functions/checks #function: check_install

# Verifica se tem ZSH instalado
check_install zsh

# Verifica se tem o git instalado
check_install git

# Verifica se tem o cURL instalado
check_install curl

# Verificando se o On My Zsh já está instalado
ls ~/.oh-my-zsh/oh-my-zsh.sh > /dev/null 2>&1
if [ $? -ne 0 ]; then
	# Caso não tenha, então, instale
	curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh; zsh
	if [ $? -ne 0 ]; then
		echo "Algo ocorreu, verifique e tente novamente..."
		echo ""
		echo "Se não aparecer a mensagem “Shell changed.” acima da logo, pode ser que o script não tenha conseguido alterar seu shell ou talvez tivesse um erro na senha; nesse caso, basta você mesmo alterá-lo:"
		echo ""
		echo 'sudo usermod --shell $(which zsh) <seu_usuario>'
		echo ""
		return
	fi
	printf 'On My ZSH instalado com sucesso!\n\n'
fi

# Add ZSH no Bash_Profile
grep "zsh" ~/.bash_profile > /dev/null 2>&1
if [ $? -ne 0 ]; then
	echo "" >> ~/.bash_profile
	echo "# Add ZSH at startup" >> ~/.bash_profile
	echo "zsh" >> ~/.bash_profile
	echo "" >> ~/.bash_profile
	printf 'ZSH adicionado no seu BASH_PROFILE com sucesso!\n\n'
fi

# Helper: Imprime ajuda para carregar plugins
printf 'Dica:\nPara habilitar um plugin (tanto os desse link acima quanto os que veremos mais abaixo), \nbasta adicionar o nome dele na linha “plugins” do arquivo “.zshrc” que foi criado em sua pasta pessoal (“~/.zshrc”). \nPor exemplo, para habilitar o plugin “git”:\n'
printf 'plugins=(\n     git\n)\n\nPara carregar a lista de plugins, visite:\n'
printf "https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins \n\n"

# Verificando se o zsh-syntax-highlighting já está instalado
ls ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting > /dev/null 2>&1
if [ $? -ne 0 ]; then
	# Caso não tenha, então, instale
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	if [ $? -ne 0 ]; then
		printf "\nAlgo ocorreu, verifique e tente novamente...\nNão foi possivel instalar o zsh-syntax-highlighting\n"
		return
	fi
	printf 'zsh-syntax-highlighting instalado com sucesso!\n\n'
	printf '\nAdicione o zsh-syntax-highlighting na lista de plugins do seu “~/.zshrc”'
	printf '\nExemplo:\nplugins=(\n     git\n     zsh-syntax-highlighting\n)\n'
fi


# Verificando se o zsh-autosuggestions já está instalado
ls ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions > /dev/null 2>&1
if [ $? -ne 0 ]; then
	# Caso não tenha, então, instale
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	if [ $? -ne 0 ]; then
		printf "\nAlgo ocorreu, verifique e tente novamente...\nNão foi possivel instalar o zsh-autosuggestions\n"
		return
	fi
	printf 'zsh-autosuggestions instalado com sucesso!\n\n'
	printf '\nAdicione o zsh-autosuggestions na lista de plugins do seu “~/.zshrc”'
	printf '\nExemplo:\nplugins=(\n     git\n     zsh-syntax-highlighting\n     zsh-autosuggestions\n)\n'
	printf '\n\nPronto, basta usar Ctrl+→ (direita) para aceitar a próxima palavra ou simplesmente → para o comando completo'
fi


# Verificando se o Fuzzy Finder está instalado
ls ~/.fzf/install > /dev/null 2>&1
if [ $? -ne 0 ]; then
	# Iniciando a instalação do FZF (Fuzzy Finder)
	printf "\n- Iniciando a instalação do Fuzzy Finder, por favor, responda as questões abaixo:"
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
	if [ $? -ne 0 ]; then
		printf "\nAlgo ocorreu, verifique e tente novamente...\nNão foi possivel instalar o zsh-autosuggestions\n"
		return
	fi
	printf 'Fuzzy Finder instalado com sucesso!\n\n'
	printf '\nAdicione o zsh-autosuggestions na lista de plugins do seu “~/.zshrc”'
	printf '\nExemplo:\nplugins=(\n     git\n     zsh-syntax-highlighting\n    zsh-autosuggestions\n)\n'
	printf '\n\nPronto, agora você poderá usar Ctrl+T quando precisar procurar por arquivos, que nem você faria no seu editor!!!\n'
fi


printf '\nFim do Script\nO que o script fez por você?\n\n'
printf 'Instalação do:\n- Oh My ZSH\n- zsh-syntax-highlighting\n- zsh-autosuggestions\n- Fuzzy Finder\n\nSee ya!\n'



