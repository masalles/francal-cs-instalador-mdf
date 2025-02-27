# 🎈 FRANCAL >> CUSTOMER SUCCESS
# Instalador do Microsoft Data Formulator (Script PowerShell)

> **Este script PowerShell automatiza a instalação e execução do Microsoft Data Formulator.**

![Windows Terminal](https://img.shields.io/badge/Windows%20Terminal-PowerShell-blue?style=flat&logo=windows-terminal)  
![License](https://img.shields.io/badge/License-MIT-green?style=flat)  

---

## ⚡ Visão Geral  
Este script PowerShell **automatiza** a configuração do Microsoft Data Formulator, garantindo um processo de instalação suave para os componentes de backend e frontend. Se você precisa de um deployment rápido e sem erros, este é o seu script! 🚀

### 🔧 **O que ele faz**  
**O script instala as ferramentas necessárias, clona o repositório, configura um ambiente virtual Python, instala as dependências, inicia o servidor HTML e executa a interface web para o Microsoft Data Formulator.**

✅ **Clona o Repositório** (Garante que a versão mais recente seja instalada)  
✅ **Configura o Ambiente Virtual Python** (Isola dependências)  
✅ **Instala as Dependências de Backend** (Garante as bibliotecas corretas)  
✅ **Inicia o Servidor Backend** (Executa o serviço baseado em Python)  
✅ **Instala as Dependências de Frontend** (Configura a interface)  
✅ **Inicia o Servidor Frontend** (Abre o ambiente de desenvolvimento)  

---

## 🛠️ Pré-requisitos  
- **Privilégios de Administrador** 🛑 (Execute como Administrador)  
- **Windows 10/11** (Testado na versão 21H2+)  
- **Política de Execução do PowerShell**: Certifique-se de que scripts podem ser executados  

---

## 🚀 Como Usar  
### Clique com o botão direito em "PowerShell", "Executar como Administrador"

### Crie uma pasta para o projeto: Ex.:"c:\mdf\projeto01":  
```powershell
mkdir c:\mdf\projeto01
```
```powershell
cd c:\mdf\projeto01
```
Cole o comando para executar o script e pressione "ENTER" para iniciar:  
```powershell
irm "https://raw.githubusercontent.com/masalles/francal-cs-instalador-mdf/refs/heads/main/francal-cs-mdf-installer-pt-br.ps1" | iex
```

## 🔒 Segurança  
Sempre inspecione os scripts antes de executá-los!
(Faça o download do script e salve localmente antes de usar o comando):  
```powershell
Get-Content francal-cs-mdf-installer-pt-br.ps1
```
Se a execução for bloqueada, permita temporariamente a execução de scripts:  
```powershell
Set-ExecutionPolicy RemoteSigned -Scope Process -Force
```

---

## ⚠️ Notas Importantes  
- Requer Windows 10/11 (testado na versão 21H2+).  
- O backend e o frontend devem rodar em processos separados.  
- Reiniciar o sistema após a instalação pode melhorar o desempenho.  

---

## 🤝 Contribuindo  
Contribuições são bem-vindas! Siga estes passos:  
1. Faça um fork do repositório.  
2. Crie um branch para a funcionalidade (`git checkout -b feature/FuncionalidadeIncrível`).  
3. Faça o commit das suas alterações (`git commit -m 'Adiciona a FuncionalidadeIncrível'`).  
4. Envie para o branch (`git push origin feature/FuncionalidadeIncrível`).  
5. Abra um Pull Request.  

---

## 📜 Licença  
Este projeto está licenciado sob a Licença MIT. Fique à vontade para usá-lo, modificá-lo e distribuí-lo conforme necessário.

💡 Dica Pro: Após rodar o script, reinicie seu computador para melhores resultados! 🎉
