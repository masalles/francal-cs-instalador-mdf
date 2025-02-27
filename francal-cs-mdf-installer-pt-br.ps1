# Configura a codificação para UTF-8 para garantir que caracteres especiais sejam exibidos corretamente
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Configura a política de execução para permitir a execução do script
Set-ExecutionPolicy Bypass -Scope Process -Force

# Limpa a tela
Clear-Host

# Função para verificar se um comando existe
function Existe-Comando {
    param ($Comando)
    return $null -ne (Get-Command $Comando -ErrorAction SilentlyContinue)
}

# Função para exibir texto colorido
function Escrever-Colorido {
    param ($Texto, $Cor = "White")
    Write-Host $Texto -ForegroundColor $Cor
}

# Função para exibir cabeçalho
function Mostrar-Cabecalho {
    param ($Titulo)
    Escrever-Colorido "" 
    Escrever-Colorido "  $Titulo" "Cyan"
    Escrever-Colorido "  --------------------------------------------------------------" "DarkGray"
    Escrever-Colorido ""
}

# Função para exibir mensagem de status
function Mostrar-Status {
    param ($Mensagem, $Tipo = "normal")
    
    $prefixo = "    "
    
    switch ($Tipo) {
        "sucesso" { 
            Escrever-Colorido "$prefixo[OK] $Mensagem" "Green"
        }
        "info" { 
            Escrever-Colorido "$prefixo[i] $Mensagem" "Cyan"
        }
        "aviso" { 
            Escrever-Colorido "$prefixo[!] $Mensagem" "Yellow"
        }
        "erro" { 
            Escrever-Colorido "$prefixo[X] $Mensagem" "Red"
        }
        "progresso" { 
            Escrever-Colorido "$prefixo[*] $Mensagem" "Yellow"
        }
        default { 
            Escrever-Colorido "$prefixo$Mensagem" "White"
        }
    }
}

# Função para exibir barra de progresso
function Mostrar-Progresso {
    param (
        $Pacote,
        $Porcentagem,
        $NovaLinha = $false
    )
    
    $prefixo = "    "
    $barraLargura = 30
    $barraCompleta = [math]::Floor(($barraLargura * $Porcentagem) / 100)
    $barra = "[" + ("#" * $barraCompleta) + (" " * ($barraLargura - $barraCompleta)) + "]"
    
    if ($NovaLinha) {
        Write-Host "$prefixo$barra $Porcentagem% - $Pacote" -ForegroundColor Cyan
    } else {
        Write-Host "`r$prefixo$barra $Porcentagem% - $Pacote" -NoNewline -ForegroundColor Cyan
    }
}

# Função para exibir texto com animação de cores
function Mostrar-TextoAnimado {
    param (
        $Texto,
        $Duracao = 5,  # Duração em segundos
        $Velocidade = 100  # Intervalo em milissegundos
    )
    
    $prefixo = "    "
    $cores = @("Cyan", "Blue", "Magenta", "Yellow", "Green", "Cyan")
    $iteracoes = $Duracao * 1000 / $Velocidade
    $contador = 0
    
    while ($contador -lt $iteracoes) {
        $corIndex = $contador % $cores.Count
        $cor = $cores[$corIndex]
        
        Write-Host "`r$prefixo[>] $Texto" -NoNewline -ForegroundColor $cor
        Start-Sleep -Milliseconds $Velocidade
        $contador++
    }
    
    # Deixa a mensagem final em Cyan
    Write-Host "`r$prefixo[>] $Texto" -NoNewline -ForegroundColor Cyan
}

# Função para exibir mensagem de despedida
function Mostrar-Despedida {
    $scriptName = Split-Path $MyInvocation.MyCommand.Path -Leaf
    
    Write-Host ""
    Write-Host "    [!] Encerrando o Microsoft Data Formulator..." -ForegroundColor Yellow
    Write-Host "    [!] Para executar novamente, digite: powershell -File $scriptName" -ForegroundColor Yellow
    Write-Host ""
}

# Função para instalar o Data Formulator com progresso
function Instalar-DataFormulator {
    $prefixo = "    "
    
    # Lista de pacotes principais que serão instalados
    $pacotesPrincipais = @(
        "data_formulator",
        "autopep8",
        "jupyter",
        "pandas",
        "docker",
        "namedlist",
        "matplotlib",
        "flask",
        "flask-cors",
        "openai",
        "azure-identity",
        "azure-keyvault-secrets",
        "python-dotenv",
        "vega_datasets",
        "litellm"
    )
    
    $totalPacotes = $pacotesPrincipais.Count
    
    # Inicia a instalação
    Escrever-Colorido ""
    Mostrar-Status "Iniciando instalacao do Microsoft Data Formulator..." "progresso"
    Escrever-Colorido ""
    
    # Instala o pacote principal e captura a saída
    $processo = Start-Process -FilePath "pip" -ArgumentList "install", "data_formulator", "-v" -NoNewWindow -PassThru -RedirectStandardOutput "pip_output.txt"
    
    # Inicializa a barra de progresso
    Mostrar-Status "Instalando pacotes..." "progresso"
    
    # Contador para acompanhar o progresso
    $pacoteAtual = 0
    
    # Enquanto o processo está em execução, mostra o progresso
    while (-not $processo.HasExited) {
        # Atualiza o pacote atual (com loop circular pelos pacotes)
        $pacoteAtual = ($pacoteAtual + 1) % $totalPacotes
        $pacote = $pacotesPrincipais[$pacoteAtual]
        
        # Calcula a porcentagem baseada no tempo decorrido (simulação)
        $porcentagemSimulada = [math]::Min(95, ($pacoteAtual * 100) / $totalPacotes)
        
        # Exibe a barra de progresso para o pacote atual
        Write-Host "`r$prefixo" -NoNewline
        
        # Desenha a barra de progresso
        $barraLargura = 30
        $barraCompleta = [math]::Floor(($barraLargura * $porcentagemSimulada) / 100)
        $barra = "[" + ("#" * $barraCompleta) + (" " * ($barraLargura - $barraCompleta)) + "]"
        
        # Exibe a barra com a porcentagem e o nome do pacote atual
        Write-Host "$barra $($porcentagemSimulada.ToString("0"))% - Instalando: $pacote" -NoNewline -ForegroundColor Cyan
        
        # Pequena pausa para simular progresso
        Start-Sleep -Milliseconds 300
    }
    
    # Garante que a barra de progresso chegue a 100%
    Write-Host "`r$prefixo" -NoNewline
    $barra = "[" + ("#" * $barraLargura) + "]"
    Write-Host "$barra 100% - Instalação concluída!" -ForegroundColor Green
    Escrever-Colorido ""
    
    # Remove o arquivo temporário
    if (Test-Path "pip_output.txt") {
        Remove-Item "pip_output.txt" -Force
    }
    
    Mostrar-Status "Microsoft Data Formulator instalado com sucesso!" "sucesso"
}

# Exibe o banner
Escrever-Colorido "" 
Escrever-Colorido "  =================================================================" "Magenta"
Escrever-Colorido "  |            FRANCAL >> CUSTOMER SUCCESS                        |" "Magenta"
Escrever-Colorido "  |            Ferramenta:                                        |" "Magenta"
Escrever-Colorido "  |             > MICROSOFT DATA FORMULATOR                       |" "Magenta"
Escrever-Colorido "  |               INSTALADOR AUTOMATIZADO                         |" "Magenta"
Escrever-Colorido "  =================================================================" "Magenta"
Escrever-Colorido ""

# Seção de pré-requisitos
Mostrar-Cabecalho "PRE-REQUISITOS"

# Instala o Chocolatey se não estiver instalado
if (-not (Existe-Comando "choco")) {
    Mostrar-Status "Instalando Chocolatey..." "progresso"
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
    Mostrar-Status "Chocolatey instalado com sucesso!" "sucesso"
} else {
    Mostrar-Status "Chocolatey ja esta instalado." "sucesso"
}

# Instala o Git se não estiver instalado
if (-not (Existe-Comando "git")) {
    Mostrar-Status "Instalando Git..." "progresso"
    choco install git -y
    Mostrar-Status "Git instalado com sucesso!" "sucesso"
} else {
    Mostrar-Status "Git ja esta instalado." "sucesso"
}

# Instala o Node.js (que inclui npm) se não estiver instalado
if (-not (Existe-Comando "node")) {
    Mostrar-Status "Instalando Node.js..." "progresso"
    choco install nodejs -y
    Mostrar-Status "Node.js instalado com sucesso!" "sucesso"
} else {
    Mostrar-Status "Node.js ja esta instalado." "sucesso"
}

# Instala o Yarn se não estiver instalado
if (-not (Existe-Comando "yarn")) {
    Mostrar-Status "Instalando Yarn..." "progresso"
    npm install --global yarn
    Mostrar-Status "Yarn instalado com sucesso!" "sucesso"
} else {
    Mostrar-Status "Yarn ja esta instalado." "sucesso"
}

# Instala o Python3 se não estiver instalado
if (-not (Existe-Comando "python")) {
    Mostrar-Status "Instalando Python3..." "progresso"
    choco install python3 -y
    Mostrar-Status "Python3 instalado com sucesso!" "sucesso"
} else {
    Mostrar-Status "Python3 ja esta instalado." "sucesso"
}

# Instala o pip (instalador de pacotes do Python) se não estiver instalado
if (-not (Existe-Comando "pip")) {
    Mostrar-Status "Instalando pip..." "progresso"
    choco install pip -y
    Mostrar-Status "pip instalado com sucesso!" "sucesso"
} else {
    Mostrar-Status "pip ja esta instalado." "sucesso"
}

# Instala o virtualenv se não estiver instalado
if (-not (Existe-Comando "virtualenv")) {
    Mostrar-Status "Instalando virtualenv..." "progresso"
    pip install virtualenv
    Mostrar-Status "virtualenv instalado com sucesso!" "sucesso"
} else {
    Mostrar-Status "virtualenv ja esta instalado." "sucesso"
}

# Seção de configuração do ambiente
Mostrar-Cabecalho "CONFIGURACAO DO AMBIENTE"

# Cria e ativa um ambiente virtual
Mostrar-Status "Configurando ambiente virtual Python..." "progresso"
virtualenv venv
Mostrar-Status "Ambiente virtual criado com sucesso!" "sucesso"

# Ativa o ambiente virtual no PowerShell
Mostrar-Status "Ativando o ambiente virtual..." "progresso"
.\venv\Scripts\Activate.ps1
Mostrar-Status "Ambiente virtual ativado com sucesso!" "sucesso"

# Seção de instalação do Data Formulator
Mostrar-Cabecalho "INSTALACAO DO DATA FORMULATOR"

# Instala o Data Formulator com progresso
Instalar-DataFormulator

# Exibe mensagem de sucesso
Escrever-Colorido ""
Escrever-Colorido "  =================================================================" "Green"
Escrever-Colorido "  =                                                               =" "Green"
Escrever-Colorido "  =             INSTALACAO CONCLUIDA COM SUCESSO!                 =" "Green"
Escrever-Colorido "  =                                                               =" "Green"
Escrever-Colorido "  =================================================================" "Green"
Escrever-Colorido ""

# Exibe informações sobre o Data Formulator
Mostrar-Status "O Microsoft Data Formulator sera iniciado como um servidor web local." "info"
Mostrar-Status "Apos iniciar, ele abrira automaticamente em seu navegador padrao." "info"
Mostrar-Status "Endereco: http://localhost:5000" "info"
Mostrar-Status ""
Mostrar-Status "Para encerrar o servidor, pressione Ctrl+C nesta janela." "info"
Mostrar-Status ""

# Pausa antes de iniciar o Data Formulator com animação de cores
Mostrar-TextoAnimado "Pressione Enter para iniciar o Microsoft Data Formulator..." 10
$null = Read-Host

# Seção de inicialização
Mostrar-Cabecalho "INICIALIZACAO DO DATA FORMULATOR"

# Inicia o Data Formulator
Mostrar-Status "Iniciando Microsoft Data Formulator..." "progresso"
Mostrar-Status "Aguarde enquanto o servidor e iniciado e o navegador e aberto..." "info"
Mostrar-Status "Para encerrar o servidor, pressione Ctrl+C nesta janela." "info"
Escrever-Colorido ""

# Cria um arquivo de script temporário para executar o Data Formulator
$tempScriptPath = [System.IO.Path]::GetTempFileName() + ".ps1"
$scriptContent = @"
try {
    python -m data_formulator
} finally {
    Write-Host ""
    Write-Host "    [!] Encerrando o Microsoft Data Formulator..." -ForegroundColor Yellow
    Write-Host ""
}
"@
Set-Content -Path $tempScriptPath -Value $scriptContent

# Executa o script temporário
powershell -File $tempScriptPath

# Remove o script temporário
Remove-Item -Path $tempScriptPath -Force
