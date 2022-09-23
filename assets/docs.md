# EasyFinance
EasyFinance - ein Praxis-Projekt von Robert Ackermann. Made with <span style="color: #e25555">&#9829;</span> and <span style="color: #e25555; padding-left: 2px;">&#x2615;</span> in Erfurt.
## Intro
EasyFinance ist eine App mit der du deine Einnahmen, Ausgaben und die Gewichtungen deiner Portfolio Positionen überwachen kannst. Neben diesen Hauptfunktionen stehen dir ein Zinseszins- und ein Zielsparen-Rechner zur Verfügung. Wieso solltest du aber ausgerechnet unsere App nutzen, bei all den unzähligen Konkurrenzprodukten die es auf dem Markt gibt? Anders als bei den anderen, wirst du bei uns nicht mit unzähligen unnützen Funtkionen überflutet, die dich nur vom wesentlichen ablenken und dich überfordern können. Wir haben uns darauf konzentriert, die Bedienung und Nutzung der App so einfach wie möglich zu gestalten und dir gleichzeitig alles zu geben, was du für deinen Weg in die finanzielle Unabhängigkeit brauchst!


## Allgemeine Hinweise
Die App wurde mit dem Framework Flutter realisiert. Mit Flutter soll es Entwicklern möglichst einfach gemacht werden, Cross-Plattform-Apps in der Programmiersprache dart zu entwickeln. Da wir uns im Rahmen des Moduls "Programmierung mobiler Endgeräte" bereits mit der Entwicklung von Android Apps beschäftigen durften, habe ich mich im Folgenden mehr auf die iOS Seite konzentriert. Die App sollte an sich auch auf Android funktionieren, dies wurde aber nicht getestet. Nach implementieren der App wurde diese auf den Xcode Simulatoren iPhone 8 - iOS 14.0 und iPhone 11 Pro - iOS 14.0, sowie auf den echten Geräten iPhone 8 - iOS 14.2 und iPhone SE (1. Generation) - iOS 14.0.1 getestet. Zum Speichern der Daten wurde in diesem Projekt Firebase/Firestore genutzt. In Zukunft ist hier geplant Firebase durch eine eigene node.js API mit mysql-Datenbank zu ersetzen und so eine bessere Kontrolle darüber zu haben, wo die Daten der Nutzer gespeichert und verwahrt werden.      

## Arbeitszeit
Das Praxisprojekt ist so ausgelegt dass es innerhalb von 75 Stunden realisiert werden kann. Hier folgt eine kurze Aufschlüsselung, welcher Bereich der Applikation wie viel Zeit in Anspruch genommen hat. 

| Bereich                                   | Arbeitszeit     |
| ----------------------------------------- | --------------- |
| Einarbeiten in Dart, Flutter & Firebase   | 15 Stunden      |
| Planung von Funktionen                    | 2 Stunden       |
| Recherche Design & Auswahl Farben         | 4 Stunden       |
| Verfassen von Texten für die App          | 3 Stunden       |
| Programmieren der App                     | 50 Stunden      |
| Code Refactorings                         | 5 Stunden       |
| Testing & Bugfixing                       | 8 Stunden       | 
| Erstellen der Dokumentation               | 3 Stunden       |
| **Gesamte Arbeitszeit**                   | **90 Stunden**  |
## Installation
Für das ausführen der Applikation muss auf dem Rechner Flutter installiert sein, hier kann die [Offizielle Dokumentation](https://flutter.dev/docs) als Hilfe dienen. 
Aktuell ist in den XCode Projekt Einstellungen unter Deployment Info, die iOS Version 14.0 festgelegt. Der Simulator sollte also über die selbe iOS Version verfügen oder 
diese Einstellung sollte angepasst werden.
Zum Installieren der Applikation müssen folgende Schritte ausgeführt werden:

Git Repository klonen:

    git clone https://source.ai.fh-erfurt.de/ro1376ac/easy-finance.git

Ins Projekt Verzeichniss navigieren:

    cd easy-finance

Paketabhängigkeiten installieren: 

    flutter pub get

Simulator starten

    open -a Simulator

App bauen und starten:

    flutter run 


## Funktionallitäten
Die Funktionallitäten werden hier nach Screens unterteilt ein mal kurz aufgelistet.

### Testkonten
E-Mail Adresse: rainer.zufall@easy-finance.de - Passwort: password 
E-Mail Adresse: caro.weiß@easy-finance.de - Passwort: password 

### Hinweise zu Formularen
Zahl-Eingabe Felder müssen stets gültige Zahlen beinhalten um als valide wahrgenommen zu werden (bitte Kommazahlen mit . eingeben) und Wort-Eingabe Felder müssen immer mit mindestens einem Zeichen gefüllt werden. 
### Registrierung
Hier kann sich der Nutzer ein Konto anlegen. Wichtig zu beachten ist, dass man eine gültige E-Mail Adresse angeben muss und ein mindestens sechs Zeichen langes Passwort.
### Login
Falls der Nutzer bereits einen Account für die App besitzt kann dieser sich hier einloggen, um zu seinem Nutzerbereich zu gelangen.

### Logout
Wenn der Nutzer eingelogt ist, findet dieser (mit Ausnahme der Artikel Views) oben rechts stets einen Icon-Button mit dem sich dieser ausloggen kann.
### Übersicht
Mit einem Klick auf die verschiedenen Bildkarten gelangt der Nutzer zu Artikeln die sich mit diversen Themen beschäftigen. Ebenso gibt es hier eine kleine Übersichts-Karte, die dem Nutzer auf einen Blick Monatliche Einnahmen und Ausgaben darstellt (Bedienung mit den Pfeiltasten). Über die Dokumentationskarte öffnet sich die Projektdokumentation.

### Ausgaben
Auf diesem Tab kann der Nutzer Ausgaben über den hinzufügen Button speichern. Bei einem langen Klick auf eine Ausgaben Kachel, lässt sich diese bearbeiten bzw. mit einem kurzen klick auf das Mülleimer Symbol auch löschen. Mithilfe der verschiedenen Reiter, kann der Nutzer seine Ausgaben nach Frequenz geordnet ansehen, auf dem Reiter Gesamt werden alle Kosten auf den Monat heruntergebrochen. Auf allen anderen Reitern werden nur Kosten der gleichen Kategorie aufaddiert.

### Einnahmen
Dieser Tab verfügt über die gleichen Funktionen wie der Ausgaben Tab. Das hinzufügen, bearbeiten und löschen von Einnahmen ist analog zu dem der Ausgaben.

### Investments
Der Verwalten Reiter besitzt die gleichen Funktionen wie der Ausgaben Tab. Das hinzufügen, bearbeiten und löschen von Investments ist analog zu dem der Ausgaben. Unter dem Reiter Aufteilung kann sich der Nutzer ein Kuchendiagramm ansehen, bei dem die Gewichtung seiner verschiedene Investments innerhalb seines Portfolios dargestellt wird. 

### Werkzeuge
Mithilfe des Zinseszins Rechners kann der Nutzer simulieren, wie sich sein Kapital unter den angegebenen Parametern verhällt. Wichtig zu beachten ist hier: Der angegebene Zinssatz ist jährlich und eine Verzinsung erfolgt in der Berechnung immer zur Jahresmitte.
Der Zielsparen Rechner ermöglicht dem Nutzer zu berechnen, wie viel dieser jeden Monat sparen muss, um ein gewisses finanzielles Zielkapital innerhalb eines bestimmten Zeitraums zu erreichen. In der Berechnung erfolgt die Verzinsung auch hier immer in der Mitte des Jahres. 

## Fazit
Das Entwickeln der App mit Flutter hat mir viel Freude bereitet. Bei Problemen und Fehlern während der Entwicklungsphase war die Dokumentation bzw. die vielen Einträge auf stackoverflow sehr hilfreich. Obwohl Flutter noch ein sehr junges Framework ist, hat dieses bereits eine große Community. Meiner Meinung nach ist die App-Entwicklung mit Flutter auch für Programmier Anfänger geeignet. Abschließend möchte ich anmerken das Flutter meiner Meinung nach ein Framework mit einer vielversprechenden Zukunft ist!     