# Scripts

## nordvpn-best-server:

>This is a script that uses the nordvpn api to get the list of contries and corresponding contry-IDs. This is then saved to a text file. The script then uses the contry-ID of your chosen contry to get the best server available according to nordvpn.

### Usage:
Naviagate to the directory the script is in and run:
```
./nordvpn-best-server Contry
```
or to connect directly:
```
sudo nordvpn connect $(nordvpn-best-server Contry)
```

You can also add the location to path
```
export PATH=$PATH:your/script/location
```
or move the script to a folder allready on the parh. (recommended)

Further you can also create an alias in, for example .bashrc for your contry of choice:
```
alias best='nordvpn-best-server Contry'
```
and connect with:
```
sudo nordvpn c $(best)
```
#### Note:
If the script is placed outside the $HOME directory the text file doesn't seem to be saved.
Probably a premission issue. It's only a temp list anyway and the script stil works. 
I have tested it on arch-linux placed in the /usr/local/bin directory.

>-------------------------------------------------------------------------------------------------------------------------------------------
