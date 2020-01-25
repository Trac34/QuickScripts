#!/usr/bin/env python3

from http.server import HTTPServer, SimpleHTTPRequestHandler
import ssl
import sys

def main(ip,port,certpath,keypath):

    httpd = HTTPServer((ip, port), SimpleHTTPRequestHandler)

    httpd.socket = ssl.wrap_socket(httpd.socket, keyfile=keypath, certfile=certpath, server_side=True)
    print("Serving https as ip [ %s ] on port %d..." % (ip,port))
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("Exiting...")
        sys.exit(0)


def get_ip():
    import re
    import subprocess as sp
    from sys import platform
    def _g(n=0):
        if n == 1:
            return sp.check_output(["ipconfig"])
        else: # Sanity else statement
            return sp.check_output(["ifconfig"])

    def _c(lo):
        assert(type(lo)) == list
        for i,c in enumerate(lo):
            print("{} : {}".format(i,c))
        ch = input("Choose your IP address: ")
        try:
            ch = int(ch.strip())
        except:
            print("Please enter the number on the left of the list")
            _c(lo)
        if type(ch) != int:# 
            _c(lo)
        if (ch < 0) or (ch > (len(lo)-1) ):
            _c(lo)
        return lo[ch]

    if platform == "linux" or platform == "linux32":
        x = _g()
        zx = x.decode("utf-8")
    # Magic number :/
        ip = zx.split()[156]
        return ip
    
    elif platform == "win32":
        x = _g(1)
        ux = x.decode("utf-8")
        x = None
        lx = ux.split('\r\n\r')
        ux = None   # Why wait for the garbage collector?
        rr = re.compile(".*IPv4 Address.*")
        ips = []
        for i in lx:
            if re.search(rr, i):
                ips.append(i.split("\r\n")[1].split(":")[1].strip())
        ip = _c(ips) 
        return ip



if __name__=="__main__":
    port = 4443
    ip = ''
    certpath="/root/certs/pi4Cert.pem"
    keypath="/root/certs/pi4Key.pem"
    if len(sys.argv) == 2:
        port = int(sys.argv[1])
    elif len(sys.argv) == 3:
        ip = sys.argv[1]
        port = int(sys.argv[2])
    if ip == '':
        ip = get_ip()
    main(ip,port,certpath,keypath)
