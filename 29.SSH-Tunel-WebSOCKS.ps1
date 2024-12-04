# Establish a dynamic SSH tunnel (port forwarding). SOCKS Proxy HTTP/HTTPS for forwarding web browsing traffic.
    # -i: Path to the private key for public key authentication on the server.
    # -N: Prevents remote command execution and does not start an interactive shell or remote session. Useful for port forwarding only.


# Using plink (https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)
echo "`n" | plink -D 9090 <USER>@<REMOTE_IP> -P <REMOTE_PORT> -N -i "C:\<PATH>\idkey.ppk"

# Using SSH
ssh -D 9090 <USER>@<REMOTE_IP> -p <REMOTE_PORT> -N -i "C:\<PATH>\idkey"