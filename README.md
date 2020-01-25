# QuickScripts
Simple tools that I built for day-to-day tasks
## server.py
###
Looks for .pem files to use for TLS wrapped HTTP server
# Linux
The get_ip() function uses a magic number . It works on my Pi. You may need to adjust or actually build a regex

# Windows
The get_ip() function is a bit more robust, but you need an addional interaction with the program. I would change the
  `ip = _c(ips)` line to `ip = ips[n]` , n being the know number in the list that you're LAN address is
  
Generate a TLS public\private key pair, change the paths under `if __name__=="__main__":` line and run with:
python server.py
    or
python server.py [port]
    or 
python server.py [ip] [port]
