# TierTaxi
TierTaxi ist das Abschlussprojekt eines SQL-Kurses und demonstriert die Entwicklung einer relationalen Datenbank für einen fiktiven Tiertransport-Service.
Das Projekt umfasst:
- Eine vollständige SQL-Datenbankstruktur für die Verwaltung von Tiertransporten
- Implementierte Trigger zur Automatisierung von Aktionen und Sicherstellung der Datenintegrität
- Benutzerdefinierte Funktionen zur Unterstützung komplexer Abfragen und Geschäftslogik

Das TierTaxi-Unternehmen bietet Transporte via Tiere an.
Kunden können sich Tiere zum Transport an ihrem Standort für eine gewünschte nicht definierte Dauer mieten. Ein Kunde kann je Auftrag ein Tier buchen. 

Der Buchungsprozess beginnt, wenn ein Kunde ein Tier für den Transport anfragt. Hierbei wird ein Auftrag angelegt. Der Auftrag muss genehmigt werden. Es werden folgende Punkte geprüft:
- Verfügbarkeit eines Tieres am Standort
- Gewicht des Kunden darf zulässiges Gewicht des Tieres nicht überschreiten
- Gültiges Tierarztprotokoll (Tierarztprotokoll darf nicht älter als ein Jahr sein)

Mit der Genehmigung des Auftrages geht der Auftrag in die Durchführung. Entspricht die angefragte Buchung nicht den geprüften Kriterien, wird der Auftrag abgelehnt und der Buchungsprozess ist beendet.

Der Buchungsprozess kann durch die gespeicherten Prozedur sp_Buchungsprozess angestoßen werden. Der Prozedur wird eine Kunden ID übergeben. Zunächst wird geprüft, ob der Kunde bereits angelegt ist und es am Kunden-Standort geeignete Tiere (siehe oben) gibt. Sofern es ein geeignetes Tier für den Kunden gibt, wird ein Auftrag in der Auftrags-Tabelle angelegt und das Tier ist nicht mehr für Buchungen verfügbar, bis die Endzeit der Buchung eingetragen wird und der Buchungsstatus sich wieder ändert. Die Prozedur greift auf die Tabellenwertfunktion tf_Verfuegbarkeit_Tier und die Skalarwert-Funktion sf_Tier_in_Durchfuehrung zu.

Wenn bei einem genehmigten Auftrag der Kunde die Mietdauer beendet, und somit das Enddatum und die Enduhrzeit feststehen, ist der Auftrag abgeschlossen. Es erfolgt eine Rechnung. Abgerechnet wird die gemietete Zeit in angefangen Stunden (aufgerundet auf die volle Stunde). Die Futterkosten variieren je nach Futtertyp (Karnivore, Omnivore, Herbivore) und Größe (Futtermenge) des Tieres. 

Der Trigger trg_Buchungszeit_Insert wird ausgelöst, sobald eine Endzeit der Buchung in die Tabelle Aufträge eingetragen wird. Daraufhin berechnet sich automatisch die Gesamtdauer der Buchung (berechnete Spalte) und es wird (ausgelöst durch diesen Trigger) eine Zeile in der Tabelle Rechnung mit den entsprechenden Daten angelegt.

Die Tiere müssen regelmäßig zum Tierarzt. Eine gespeicherte Prozedur (sp_TAP_aktualiseren) prüft, ob das Tierarztprotokoll der Tiere noch gültig ist. Falls der letzte Termin zu weit in der Vergangenheit liegt, wird der Status des Tierarztprotokolls für das Tier auf abgelaufen gesetzt und das Tier kann nicht mehr gebucht werden.



