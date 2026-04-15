# Active Response – automatyczna reakcja na ransomware

Podchodzę do Active Response w Wazuh tak samo, jak do automatyzacji w Azure: najpierw jasny warunek wyzwalający (reguła), potem konkretna akcja na hoście, a na końcu minimalizacja ryzyka błędnej izolacji.

## Logika działania

### 1. Zabicie procesu szyfrującego
Skrypt PowerShell:

- identyfikuje proces powiązany z Sysmon Event ID 11
- zatrzymuje go (`Stop-Process`)
- opcjonalnie blokuje ponowne uruchomienie (zmiana ACL)

### 2. Izolacja hosta
Analogicznie do „Isolate machine” w Defender for Endpoint:

- Windows Firewall blokuje cały ruch przychodzący i wychodzący
- pozostawiam tylko ruch do serwera Wazuh/SOC

### 3. Powiadomienie SOC
Active Response:

- zapisuje artefakty (PID, nazwa procesu, timestamp)
- wysyła alert do integratora (Teams/Slack/ticketing)

To dokładnie ten sam model, który znam z Azure Sentinel + Automation.
