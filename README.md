# zfw-zet

## Installation

### Ubuntu

1. Install package via the installation script.

``` bash
curl -sSLf https://raw.githubusercontent.com/netfoundry/zfw-zet/refs/heads/main/files/install-zfw-zet.bash | bash
```

2. Enable and start the service

``` bash
sudo systemctl enable --now ziti-edge-tunnel.service
```

3. Add an Identity.

```
sudo ziti-edge-tunnel add --jwt "$(< ./in-file.jwt)" --identity myIdentityName
```

### Debian
