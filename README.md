# Interprétation ORL

Logiciel hors ligne d'aide à l'interprétation des examens ORL et du sommeil : audiogramme, VHIT, VNG, PEA, PEO, polygraphie et polysomnographie Cidelec, polygraphie Jawac (Nomics).

Tout le logiciel tient dans un seul fichier, `Interpretation_ORL.html`. Il s'ouvre dans Edge ou Chrome en mode application. **Aucune donnée patient ne quitte le poste et aucune n'est stockée dans ce dépôt.**

## Installation (à faire une fois par poste)

- **Le plus simple :** télécharger `installer_depuis_internet.bat` (bouton *Raw*, puis *Enregistrer sous*) et double-cliquer dessus.
- **Ou :** *Code → Download ZIP*, décompresser, puis double-cliquer sur `Installer.bat`.

L'installation copie le logiciel dans `%LOCALAPPDATA%\InterpretationORL` (même dossier qu'avant : réglages et dossier surveillé conservés). Elle crée l'icône « Interpretation ORL » sur le Bureau et dans le menu Démarrer.

## Mise à jour automatique

À chaque ouverture, le lanceur (`lancer.ps1`) :
1. lit `version.txt` sur GitHub (5 s maximum) ;
2. si la version est nouvelle, télécharge `Interpretation_ORL.html` et vérifie son empreinte SHA-256 ;
3. remplace l'ancienne version, gardée en `Interpretation_ORL.html.precedente` ;
4. ouvre le logiciel.

Sans internet, la version déjà installée s'ouvre normalement. Un journal des mises à jour est tenu dans `mises_a_jour.log`.

## Modifier le logiciel

Demander la modification à Claude en lui indiquant ce dépôt (`c2kgyvg6f8-lab/interpretation-orl`). Claude modifie `Interpretation_ORL.html` et l'envoie sur GitHub. L'action GitHub *version* recalcule alors `version.txt`, et les postes se mettent à jour à leur prochaine ouverture.

Le fichier peut aussi être modifié directement sur github.com (crayon ✏️ → *Commit changes*).

Voir `CHANGELOG.md` pour l'historique des modifications.
