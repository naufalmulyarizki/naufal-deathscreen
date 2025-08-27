![preview1](https://r2.fivemanage.com/WX5Hv6yMgODTgG2WF6rml/images/backgroundgithub.png)

# Naufal Death Screen

Death Screen Custom Text FiveM (QBCORE)

# Features 
- Fitur Show Custom Text Death Screen
- Fitur Informasi dibunuh dengan senjata apa
- Fitur Informasi dibunuh oleh siapa

# Installation
- Download Resource
- Masukkan ke dalam resource kamu
- tambah export di ambulance job kamu

```lua
exports('isDead', function()
    return isDead
end)
```

- refresh dan start script

# Shared settings

```lua
Config = {}

Config.Debug = false
Config.weaponhashtable = {
    [tostring(GetHashKey("WEAPON_REVOLVER_MK269"))] = "Revolver MK2",
    [tostring(GetHashKey("WEAPON_DOUBLEACTION69"))] = "Double Action",
    [tostring(GetHashKey("WEAPON_CERAMICPISTOL"))] = "Ceramic Pistol",
    [tostring(GetHashKey("WEAPON_PISTOL5069"))] = "Pistol 50",
    [tostring(GetHashKey("WEAPON_MICROSMG69"))] = "Micro SMG",
} 
```

## Preview Script
### Preview Dibubuh Orang Lain
![previewprinter](https://r2.fivemanage.com/WX5Hv6yMgODTgG2WF6rml/previewdeathscreen2.png)

### Preview Mati Diri Sendiri
![previewprinter](https://r2.fivemanage.com/WX5Hv6yMgODTgG2WF6rml/previewdeathscreen1.png)

# Dependencies

- [qb-core](https://github.com/qbcore-framework/qb-core)
- [ox_lib](https://github.com/overextended/ox_lib)

# Github Star History
[![Star History Chart](https://api.star-history.com/svg?repos=naufalmulyarizki/naufal-deathscreen&type=Date)](https://star-history.com/#naufalmulyarizki/naufal-deathscreen&Date)