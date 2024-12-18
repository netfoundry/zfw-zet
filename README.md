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

| Debian Release | UBUNTU_LTS | Architecture |
| ---- | ---- | ---- |
| 13 Trixie | jammy | x86_64, arm64 |
| 12 Bookworm | jammy | x86_64, arm64 |
| 11 Bullseye | focal | x86_64, arm64 |

1. Refer to the table to find the Ubuntu release name that is the contemporary of the Debian release. Substitute the Ubuntu release name for **focal** for the definition below.

``` bash
UBUNTU_LTS=focal
```

2. Install *gpg* package if not installed already.

``` bash
sudo apt update
sudo apt install --yes gnupg2
```

3. Subscribe the system to the OpenZiti package repository for the *UBUNTU_LTS* specified above.

``` bash
echo "deb [signed-by=/usr/share/keyrings/netfoundry-cloud.gpg] https://netfoundry.jfrog.io/artifactory/netfoundry-cloud-deb-stable ${UBUNTU_LTS} main" \
  | sudo tee /etc/apt/sources.list.d/zfw.list >/dev/null
```

4. Install the package signing *pubkey*.

``` bash
curl -sSLf https://netfoundry.jfrog.io/artifactory/api/security/keypair/public/repositories/netfoundry-cloud-deb-stable \
  | sudo gpg --dearmor --output /usr/share/keyrings/netfoundry-cloud.gpg
```

5. Ensure the *pubkey* is readable by all.

``` bash
sudo chmod a+r /usr/share/keyrings/netfoundry-cloud.gpg
```

6. Refresh the package list and install **zfw-zet**

``` bash
sudo apt update
sudo apt install --yes zfw-zet
```

7. Add interfaces to run zfw interception
   
``` bash
sudo vi /opt/openziti/etc/ziti-edge-tunnel.env
```
- To provide bi-directional transparency support only add
```
ZITI_DIVERTER=<comma separated interface list> e.g. ZITI_DIVERTER="eth0,eth1"
```
- To provide full IPv4/V6 firewalling add 
```
ZITI_FIREWALL=<comma separated interface list> e.g. ZITI_FIREWALL="eth0,eth1"
```
- - You can specify user rules and load them into zfw automatically. For more information about user rules, please refer to the [zfw Readme file](https://github.com/netfoundry/zfw?tab=readme-ov-file#load-rules-from-optopenzitibinuseruser_rulessh)
  - The user rules only get loaded at the start of the ziti-edge-tunnel, any modifications to the file will require a restart of the ziti-edge-tunnel service.**


8. Enable and start the service

``` bash
sudo systemctl enable --now ziti-edge-tunnel.service
```

9. Add an Identity.

```
sudo ziti-edge-tunnel add --jwt "$(< ./in-file.jwt)" --identity myIdentityName
```

