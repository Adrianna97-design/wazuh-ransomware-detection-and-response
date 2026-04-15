# Wyjaśnienie niestandardowej reguły Wazuh

Reguła wykrywa masowe tworzenie plików o rozszerzeniach typowych dla ransomware, bazując na Sysmon Event ID 11 (FileCreate).

Aby uniknąć false positives:

- wykluczam katalogi systemowe (`Temp`, `SoftwareDistribution`, `WinSxS`)
- stosuję korelację wielu zdarzeń w krótkim czasie (8 zdarzeń w 30 sekund)
- analizuję rozszerzenia plików charakterystyczne dla ransomware

Reguła jest powiązana z MITRE ATT&CK T1486 (Data Encrypted for Impact).
