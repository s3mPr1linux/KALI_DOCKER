# Kali Linux latest with useful tools
FROM kalilinux/kali-rolling

# Set working directory to /root
WORKDIR /root

# Update
RUN apt-get -y update && DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade && apt-get -y autoremove && apt-get clean

# Fix fetching issues
RUN sed -i 's|http://|https://|g' /etc/apt/sources.list
RUN apt-get update -y

# Install Metasploit - avoid dependency issues
RUN DEBIAN_FRONTEND=noninteractive apt-get install -o Acquire::https::Verify-Peer=false -o Acquire::https::Verify-Host=false -y metasploit-framework 

# Install common and useful tools
RUN apt-get -y install curl wget vim git net-tools whois netcat-traditional pciutils usbutils

# Install useful languages
RUN apt-get -y install python3-pip golang nodejs npm

# Install additional security tools
RUN DEBIAN_FRONTEND=noninteractive apt-get install -o Acquire::https::Verify-Peer=false -o Acquire::https::Verify-Host=false -y hydra nmap wireshark john crackmapexec responder sqlmap 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -o Acquire::https::Verify-Peer=false -o Acquire::https::Verify-Host=false -y exploitdb man-db dirb nikto wpscan uniscan lsof apktool dex2jar ltrace strace binwalk

# Install Tor and proxychains, then configure proxychains with Tor
RUN apt-get -y install tor proxychains
COPY config/proxychains.conf /etc/proxychains.conf

# Install ZSH shell with custom settings and set it as default shell
RUN apt-get -y install zsh
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
COPY config/.zshrc .

ENTRYPOINT ["/bin/zsh"]
