# Convert a Windows OS Trial to Full Version

```
dism /online /get-currentedition
```

![alt text](../Assets/ConvertTrialToFull/Image1.png)

```
dism /online /get-targeteditions
```

![alt text](../Assets/ConvertTrialToFull/image2.png)

```
dism /online /set-edition:serverstandard /productkey:YOURPRODUCTKEY /ACCEPTEULA
```

![alt text](../Assets/ConvertTrialToFull/IMAGE3.png)

## Reboot Server