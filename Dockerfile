# Kali Linux latest with useful tools
FROM kalilinux/kali-rolling

# Set working directory to /root
WORKDIR /root

# Update
RUN apt-get update && \
    apt-get -y dist-upgrade && \
    apt-get -y autoremove && \
    apt-get clean

# Fix fetching issues
RUN sed -i 's|http://|https://|g' /etc/apt/sources.list
RUN apt-get update

# Install useful languages & tools
RUN DEBIAN_FRONTEND=noninteractive apt-get install -o Acquire::https::Verify-Peer=false -o Acquire::https::Verify-Host=false -y \
    apktool \
    braa \
    curl \
    dex2jar \
    dirb \
    git \
    golang \
    iputils-ping \
    lsof \
    ltrace \
    net-tools \
    netcat-traditional \
    nikto \
    nmap \
    nodejs \
    npm \
    proxychains \
    python3-pip \
    responder \
    snmp-check \
    sqlmap \
    strace \
    tor \
    uniscan \
    vim \
    wget \
    whois \
    wireshark \
    zsh

# Install knockpy
WORKDIR /root
RUN git clone https://github.com/guelfoweb/knock.git
RUN cd knock
RUN pip3 install -r requirements.txt
RUN python3 setup.py install

# Install the latest nuclei engine and templates
RUN sh -c "$(go install github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest)"

# Configure proxychains with Tor
COPY config/proxychains.conf /etc/proxychains.conf

# Setup ZSH and set it as the default shell
# To reload ZSH - omz reload
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
COPY config/.zshrc .
ENTRYPOINT ["/bin/zsh"]

# Cleanup
RUN apt-get update && \
    apt-get upgrade -y --no-install-recommends && \
    apt-get autoremove -y && \
    apt-get autoclean && \
    apt-get clean
