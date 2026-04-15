# Scenariusz detekcji – ransomware na Windows Server

W scenariuszu detekcji skupiłam się na ataku ransomware na Windows Server, bo to wektor, który najczęściej widziałam w środowiskach, z którymi pracowałam — szczególnie tam, gdzie przetwarzane są dane wrażliwe. W Wazuh wykorzystuję te same zasady, które stosuję w Azure Security Center: najpierw identyfikuję nietypowe zachowania, a dopiero później koreluję je z logami systemowymi.

Kluczowe są zdarzenia z Sysmon, bo pozwalają wykryć procesy szyfrujące pliki, takie jak:

- `vssadmin.exe delete shadows`
- masowe operacje na plikach wykonywane przez jeden proces
- nagły wzrost liczby modyfikacji w katalogach użytkowników
- tworzenie plików `.lock`, `.encrypted`, `.crypt`

Monitoruję również:

- nietypowe użycie `powershell.exe` z parametrami szyfrującymi
- procesy potomne uruchamiane przez `explorer.exe`
- błędy Volume Shadow Copy
- próby wyłączenia usług antywirusowych
- nagły wzrost użycia CPU/dysku

To podejście jest dla mnie naturalne, bo w Azure również opieram się na korelacji logów z wielu źródeł — NSG Flow Logs, Azure Monitor, Defender for Cloud — i przenoszę tę logikę do Wazuh.
