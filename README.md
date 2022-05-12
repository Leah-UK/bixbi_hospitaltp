### <p align='center'>[Support Me Here](https://ko-fi.com/bixbi) | [FiveM Profile](https://forum.cfx.re/u/Leah_UK/summary)</p>
------

# Information
[**Bixbi_HospitalTP**](https://forum.cfx.re/t/esx-release-bixbi-hospital-teleport/2470070) is a *simple* teleport to hospital script.

You can define how long to send someone to hospital for (*with a max duration*). You can also define in the config if they should be given items for their stay, such as food. Finally, there's the ability to check the range of the player from the "hospital", if they get too far away it will teleport them back.

### [Demonstration Video](https://youtu.be/JhATMxlgoNs)

---

# Requirements
- [ox_lib](https://github.com/overextended/ox_lib)

---

# Exports
## Client
#### Send to Hospital
```lua
TriggerEvent('bixbi_hospitaltp:Send', duration, location) -- sent from client
TriggerClientEvent('bixbi_hospitaltp:Send', source, duration, location) -- sent from server
```
#### Release from Hospital
```lua
TriggerEvent('bixbi_hospitaltp:Release') -- sent from client
TriggerClientEvent('bixbi_hospitaltp:Release', source) -- sent from server
```

---
<p align='center'>Feel free to modify to your liking. Please keep my name <b>(Leah#0001)</b> in the credits of the fxmanifest. <i>If your modification is a bug-fix I ask that you make a pull request, this is a free script; please contribute when you can.</i></p>
