# Integracja alertów Wazuh z Teams/Slack/ticketing

Po wyzwoleniu reguły ransomware (np. 92001), Wazuh generuje alert JSON.  
Moduł `ossec-integrator` działa podobnie do Azure Logic Apps — odbiera zdarzenie i wysyła je dalej.

## Integracja z Microsoft Teams

Teams obsługuje webhooki, więc konfiguruję integrator:

- nazwa hosta
- PID i nazwa procesu
- ścieżki plików szyfrowanych
- timestamp
- informacja o izolacji hosta

SOC dostaje pełny kontekst incydentu.

## Integracja z systemem ticketowym (Jira/ServiceNow)

Wysyłam:

- nazwę zagrożenia
- host, użytkownika, proces
- wynik Active Response
- link do logów
- rekomendacje SOC

To działa jak automatyczne incydenty w Azure Sentinel.

## Integracja ze Slackiem

Slack również obsługuje webhooki.

Wysyłam:

- alert
- szczegóły procesu
- status izolacji
- link do dashboardu Wazuh
