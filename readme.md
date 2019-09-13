# Terraform Workshop
Inspiration:
https://azurecitadel.com/automation/terraform/

Diese Datei beinhaltet die Agenda bzw. Speaker Notes.
In der Workshop.md ist das "Aufgabenprotokoll" während des Vortrags.
Für gewisse Teilbereiche gibt es jeweils einen branch mit Code für den aktuellen Fortschritt.

## Einstieg
- Infrastructure as Code
- Warum eigentlich?
- Versionierbarkeit
- Wiederholbarkeit
- Berechenbarkeit
- Automatisierbarkeit
- Wiederverwendbarkeit
- Planbarkeit / Prüfbarkeit (Code Review)
- Staging vs prod
    - ARM erwähnen
- Introduction to Terraform
    - https://www.terraform.io/intro/index.html
    - Use cases zeigen
    - Terraform geht auch ohne Cloud (z.b. Borg, Mesos, Kubernetes)

## Basics
Ziel: Infrastruktur mit Terraform erstellt haben
- Azure CLI einloggen
    - az account show / set -s subId  bzw. subname
- "terraform" ausführen
- Resource group + storage account
    - "stanza" Begriff
    - Ctrl+click auf storage account um zu sehen was man braucht
- Gitignore
- Git commit

## Variables
- Variablen zeigen (string, map)
    - Location, tags
- Variablen verwenden
    - Location, named index in tags
- Random string
    - Aufgabe: Selbst herausfinden
    - Terraform provider package "random"
    - Random_string
    - Länge: 8
    - Name muss für storage account gültig sein (lowercase a-z,0-9, 3-24 zeichen)
    - <sa>terraform<rnd>
    - Bonus: tag in name einbauen und sicherstellen dass der storageaccount nie länger als 24 zeichen wird
        - z.b. "${substr("sa${var.tags["source"]}${random_string.rnd.result}", 0, 24)}".
- "terraform console" - REPL
		
## Core
- Aufgabe: application insights & app service hinzufügen

## Meta
- Mögliche Fragen
    - Wie kann man ausdrücken, dass eine Ressource nur in einem bestimmten Fall ("var.createResource") angelegt werden soll?
        - count = "${var.createResource ? 1 : 0}"
    - Syntactically, what is the difference between "${var.indexCount - 1}" and "${var.indexCount-1}"?
        - "${var.indexCount - 1}" subtracts 1 from a variable called indexCount. "${var.indexCount-1}" returns the value of a variable called indexCount-1.
- Multiple resources with count
    - Erzeuge eine webapp pro location
    - Bonus: Erzeuge mehrere webapps pro location
    - Bonus2: Aktiviere Application Insights und nutze unsere AI-Instanz
    - Good to know
        - Count geht bei ARM auch auf manchen childs
        - Count geht bei Terraform nur auf top level
        - Viele childs sind bei Terraform aber top level ressources
        - Nicht alles unterstützt count
        - Count geht nicht bei allem
- Variables
    - Umgebungsvariablen TF_VAR_loc
    - Inline "terraform apply -var 'loc=uksouth'
    - terraform.tfvars / .auto.tfvars
        $ export TF_VAR_availability_zone_names='["us-west-1b","us-west-1d"]'
        For readability, and to avoid the need to worry about shell escaping, we recommend always setting complex variable values via variable definitions files.
        From <https://www.terraform.io/docs/configuration/variables.html> 
- Locals
    - Zwischenspeichern von häufig verwendeten string interpolations
    - "konstanten" welche häufig verwendet werden
    - "Default" values welche per Input überschrieben werden können
- Outputs
    - Storage account connection string
    - Application Insights Instrumentation Key
    - terraform output -json

## Collaboration
- ServicePrincipals zeigen
    - Könnte man auch als Aufgabe machen wenn genug Leute Zugriff auf ein AAD haben
- Remote State
- Aufgabe: Remote State konfigurieren, Änderungen synchronisieren
    - Bonus: Shared Repository aufbauen

## Advanced
- Daten von externer ressource verwenden
    - Data stanza
- Refactoring & Manipulating state
    - State mv
    - State rm
    - Import
- Aufgaben:
    - Rename a resource in terraform and apply without recreating it
    - Delete an webapp from the state and make it work again
    "/subscriptions/c5ddd65b-3515-4ab3-ba5f-93cd7f8e11fe/resourceGroups/terraform-ait-lab/providers/Microsoft.Web/sites/ait-terraform-lab-alex-westeuro
    pe-03"
- Locks nicht freigegeben
- Modules
    - Nuget für Terraform
    - https://registry.terraform.io/

## CI/CD
Projekt zeigen

## Bonus-Material
- https://azurecitadel.com/automation/terraform/TerraformMarketplaceVM/
- Environment-Strategie
    - https://github.com/ThorstenHans/azure-saturday-berlin-2019
- Terragrunt
- Terraform graph

## Abschluss
- ARM als Empfehlung für den Einstieg (mehr Doku, mehr Beispiele)
    - ARM und Terraform decken Abhängigkeiten und Performance gut ab
    - Terraform hat leicht niedrigere Einstiegshürde für Entwickler, wird aber schnell komplexer als ARM
        - ARM ist für Administratoren leichter zu bedienen, hat überall Azure-Integration
    - Learning: ARM-Wrapper-Templates werden bei komplexen Architekturen und Abhängigkeiten unhandlich
    - Abhängigkeiten: z.b. Netzwerk!
    - Das meiste gibt es in ARM auch, man muss es halt lernen (Beispiel: Copy)
- Terraform ist extrem schnell, leichtgewichtig und super für "Proof Of Concepts", Hackathons oder Vorträge
- Wer Erfahrung mit Infrastructure as Code hat, oder "großes vor hat", kann gerne Terraform nehmen
- AzPowershell oder Azure CLI für "einmaliges" oder Teilbereiche
    - Sequentiell, aber einfacher
    - Kein Kunde macht alles nur mit Terraform
- Backup-strategie für tfstate!
    - Locks auf die Ressourcen
- Terraform Enterprise: Azure Pipelines speziell für Terraform