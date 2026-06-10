{ pkgs, ... }:
{
  # Common packages for all platforms
  home.packages = with pkgs; [
    # DNS utils such as named, dig, nslookup, rndc, ... (a lot): https://bind9.readthedocs.io/en/latest/manpages.html
    # arpaname - translate IP addresses to the corresponding ARPA names
    # ddns-confgen - TSIG key generation tool
    # delv - DNS lookup and validation utility
    # dig - DNS lookup utility
    # dnssec-cds - change DS records for a child zone based on CDS/CDNSKEY
    # dnssec-dsfromkey - DNSSEC DS RR generation tool
    # dnssec-importkey - import DNSKEY records from external systems so they can be managed
    # dnssec-keyfromlabel - DNSSEC key generation tool
    # dnssec-keygen: DNSSEC key generation tool
    # dnssec-ksr - Create signed key response (SKR) files for offline KSK setups
    # dnssec-revoke - set the REVOKED bit on a DNSSEC key
    # dnssec-settime: set the key timing metadata for a DNSSEC key
    # dnssec-signzone - DNSSEC zone signing tool
    # dnssec-verify - DNSSEC zone verification tool
    # dnstap-read - print dnstap data in human-readable form
    # filter-aaaa.so - filter AAAA in DNS responses when A is present
    # filter-a.so - filter A in DNS responses when AAAA is present
    # synthrecord.so - dynamically synthesize PTR, A and AAAA records
    # host - DNS lookup utility
    # mdig - DNS pipelined lookup utility
    # named-checkconf - named configuration file syntax checking tool
    # named-checkzone - zone file validation tool
    # named-compilezone - zone file converting tool
    # named-journalprint - print zone journal in human-readable form
    # named-makejournal - create a journal from zone files
    # named-nzd2nzf - convert an NZD database to NZF text format
    # named-rrchecker - syntax checker for individual DNS resource records
    # named.conf - configuration file for named
    # named - Internet domain name server
    # nsec3hash - generate NSEC3 hash
    # nslookup - query Internet name servers interactively
    # nsupdate - dynamic DNS update utility
    # rndc-confgen - rndc key generation tool
    # rndc.conf - rndc configuration file
    # rndc - name server control utility
    # tsig-keygen - TSIG key generation tool
    bind
    # Command-line tool and library for transferring data with URLs: https://curl.se/
    curl
    # Dev Container CLI: https://github.com/devcontainers/cli
    devcontainer
    # Disk information utility: https://diskinfo-di.sourceforge.io/
    di
    # Interactive process viewer: https://htop.dev/
    htop
    # Command-line JSON processor: https://jqlang.org/
    jq
    # Tool to list open files: https://github.com/lsof-org/lsof
    lsof
    # Set of tools for controlling the network subsystem in Linux: https://net-tools.sourceforge.io/
    # arp - manipulate the system ARP cache
    # hostname - set or display the current host, domain or node name of the system
    # ifconfig - configure a network interface
    # ipmaddr - adds, changes, deletes, and displays multicast addresses
    # iptunnel - creates, changes, deletes, and displays configured tunnels
    # mii-tool - view, manipulate media-independent interface status
    # nameif - name network interfaces based on MAC addresses
    # netstat - Print network connections, routing tables, interface statistics, masquerade connections, and multicast memberships
    # plipconfig - fine tune PLIP device parameters
    # rarp - manipulate the system RARP table
    # route - show / manipulate the IP routing table
    # slattach - attach a network interface to a serial line
    nettools
    # Command-line program to manage files on cloud storage: https://rclone.org/
    rclone
    # Recursively searches directories for a regex pattern while respecting your gitignore: https://github.com/BurntSushi/ripgrep
    ripgrep
    # Fast incremental file transfer utility: https://rsync.samba.org/
    rsync
    # Network sniffer: https://www.tcpdump.org/
    tcpdump
  ];
}
