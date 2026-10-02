# Instalação do ambiente no Windows (WSL2 + Docker Desktop)

Você só precisa fazer isso uma vez. Tempo estimado: 20–30 min, com dois reinícios.

---

## Pré-requisitos

| Item | Exigência |
|---|---|
| Windows 10 | 64-bit, versão 22H2 (build 19045) — Pro, Enterprise ou Education |
| Windows 11 | 64-bit, versão 23H2 (build 22631) ou superior |
| RAM | mínimo 8 GB (o BepiPred-3.0 dentro do EpiBuilder é pesado) |
| Processador | 64-bit com SLAT |
| BIOS/UEFI | virtualização habilitada (Intel VT-x / AMD-V) |

Para conferir sua versão do Windows: `Win + R` → digite `winver` → Enter.

---

## Passo 1 — Instalar o WSL2 com Ubuntu

Abra o **PowerShell como administrador** (botão direito no menu Iniciar →
"Terminal (Admin)" ou "Windows PowerShell (Admin)") e rode:

```powershell
wsl --install
```

Isso habilita os recursos do WSL, instala o Ubuntu e já define o WSL 2 como padrão.

**Reinicie o computador.**

Na primeira abertura do Ubuntu ele pede para criar um usuário e senha do Linux —
anote a senha, ela é usada no `sudo`.

Conferir depois do reinício:

```powershell
wsl --list --verbose
```

Você deve ver `Ubuntu` com `VERSION 2`. Se aparecer `VERSION 1`:

```powershell
wsl --set-default-version 2
wsl --set-version Ubuntu 2
```

Documentação oficial: https://learn.microsoft.com/en-us/windows/wsl/install

---

## Passo 2 — Instalar o Docker Desktop

Download direto (instalador oficial, x86_64, ~600 MB):

```
https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe
```

Página oficial com a documentação completa:
https://docs.docker.com/desktop/setup/install/windows-install/

Durante a instalação, deixe marcada a opção **"Use WSL 2 instead of Hyper-V"**.

**Reinicie o computador** ao final.

---

## Passo 3 — Ligar a integração com o WSL

Abra o **Docker Desktop** e espere o ícone da baleia ficar verde ("Engine running").

Depois vá em **Settings** (engrenagem) → **Resources** → **WSL Integration**:

- ligue **"Enable integration with my default WSL distro"**
- ligue também a chave do **Ubuntu** na lista abaixo
- clique em **Apply & Restart**

Documentação: https://docs.docker.com/desktop/features/wsl/

---

## Passo 4 — Garantir memória suficiente para o WSL

O EpiBuilder roda o BepiPred-3.0, que carrega um modelo de linguagem de proteínas
e consome vários GB. Crie o arquivo `C:\Users\<seu-usuario>\.wslconfig` com este
conteúdo (ajuste para no máximo ~75% da RAM da máquina):

```ini
[wsl2]
memory=8GB
processors=4
swap=4GB
```

Depois, no PowerShell:

```powershell
wsl --shutdown
```

E reabra o Docker Desktop.

---

## Passo 5 — Verificar que está tudo de pé

Abra o **Ubuntu** (menu Iniciar → Ubuntu) e rode:

```bash
docker run --rm hello-world
```

Se aparecer *"Hello from Docker!"*, o ambiente está pronto.

Confira também as ferramentas usadas pelo script:

```bash
sudo apt update && sudo apt install -y curl zip unzip
```

---

## Passo 6 — Rodar a análise

Ainda no Ubuntu:

```bash
mkdir -p ~/leptospira && cd ~/leptospira
# copie o run_analysis.sh para esta pasta, depois:
bash run_analysis.sh
```

Para copiar o script do Windows para o WSL, o disco do Windows fica montado em
`/mnt/c`. Se você salvou em Downloads:

```bash
cp /mnt/c/Users/$USER/Downloads/run_analysis.sh ~/leptospira/
```

O script faz tudo em sequência: baixa as imagens, baixa o proteoma, roda o
FastProtein, corta as 50 proteínas de membrana, roda o EpiBuilder, salva todos os
logs e no final gera `resultados_para_claude.zip`. É esse zip que você me manda.

**Não feche o terminal durante a execução.** Total estimado: 15–40 min,
dependendo da máquina.

---

## Se algo falhar

| Sintoma | Causa provável |
|---|---|
| `docker: command not found` no Ubuntu | integração WSL do passo 3 não foi aplicada |
| `Cannot connect to the Docker daemon` | Docker Desktop fechado — abra e espere ficar verde |
| `permission denied` em `/var/run/docker.sock` | rode `sudo usermod -aG docker $USER`, feche e reabra o Ubuntu |
| EpiBuilder morre sem mensagem / "Killed" | falta de RAM — revise o `.wslconfig` do passo 4 |
| `input.fasta` com menos de 3000 sequências | download do UniProt caiu; rode o script de novo |

Me manda o texto do erro que eu te ajudo a destravar.
