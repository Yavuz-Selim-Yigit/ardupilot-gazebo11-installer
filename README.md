# 🚀 ArduPilot + Gazebo 11 Otomatik Kurulum (Ubuntu 22.04)

Bu proje, Ubuntu 22.04 üzerinde **ArduPilot** ve **Gazebo Classic 11** ile **rover**, **boat** ve **submarine** simülasyonlarını tek komutla kurmak için bir betik sağlar.

---

## 📦 Gereksinimler

- Ubuntu 22.04 (64-bit)
- İnternet bağlantısı
- Yaklaşık 6 GB boş alan

---

## 🛠 Desteklenen Simülasyonlar
| Araç Türü | Durum | Destek |
|-----------|--------|--------|
| Rover     | ✅     | Tam    |
| Boat      | ✅     | Beta   |
| Submarine | ✅     | Gelişmiş |
| Drone     | ⚠️     | Uçuş için optimize değil |

## 🔧 Kurulum

Terminale aşağıdaki komutları girerek kurulumu başlat:

```bash
git clone https://github.com/kullaniciadi/ardupilot-gazebo11-installer.git
cd ardupilot-gazebo11-installer
chmod +x install.sh
./install.sh
```

---

## 🧪 Simülasyon Test Komutları
## 🛻 Rover Simülasyonu

Terminal 1
```bash
cd ~/ardupilot
./Tools/autotest/sim_vehicle.py -v APMrover2 -f gazebo-rover --console --map
```

Terminal 2
```bash
gazebo --verbose ~/ardupilot_gazebo/worlds/rover.world
```

## 🚤 Boat Simülasyonu

Terminal 1
```bash
cd ~/ardupilot
./Tools/autotest/sim_vehicle.py -v APMrover2 -f gazebo-boat --console --map
```

Terminal 2
```bash
gazebo --verbose ~/ardupilot_gazebo/worlds/boat.world
```

## 🌊 Submarine (Denizaltı) Simülasyonu

```bash
gazebo --verbose ~/ardupilot_gazebo/worlds/bluerov2.world
```
