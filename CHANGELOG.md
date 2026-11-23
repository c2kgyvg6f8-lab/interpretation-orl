# Historique

## 2026-11-23 – Polygraphie : exclusion de l'éveil, durée validée, indicateurs autonomes
- **Polygraphie uniquement** : la polysomnographie garde son fonctionnement antérieur.
- **Périodes analysées = périodes validées par le médecin.** Quand l'export EDF contient des périodes validées ou dévalidées (Cidelec, ou zones d'exclusion Jawac), elles sont la seule base d'analyse et le logiciel n'exclut rien de lui-même. Les pertes de signal situées dans une période validée sont signalées, pour être dévalidées si besoin.
- **Exclusion automatique de l'éveil, en dernier recours seulement** (export sans périodes validées), par époques de 30 s. Un épisode d'éveil est retenu en cas de :
  - lumière allumée au moins 10 s ;
  - position debout ;
  - mouvements d'au moins 10 s sur deux époques consécutives.
- **Pertes d'oxymétrie** retirées du calcul de l'oxymétrie, avec une marge de 5 s.
- **Index** rapportés à la durée validée, et non plus à la durée d'enregistrement.
- **Compte rendu de polygraphie :**
  - seulement les durées totales (enregistrement, durée validée), sans heures ;
  - pas de temps de sommeil ;
  - hypopnées codées sur la désaturation seule, sans micro-éveil ;
  - résultat de l'appareil placé en note technique.
- **Nouveaux index (polygraphie) :**
  - indicateurs non corticaux d'éveil : ceux de l'appareil (NCI Cidelec) quand l'export les contient, sinon accélération du pouls ;
  - index d'évènements respiratoires (apnées, hypopnées et baisses de débit suivies d'un indicateur autonome) ;
  - estimation du temps en limitation de débit inspiratoire (aplatissement du plateau inspiratoire).
- **Interprétation rédigée** : validité, sévérité et nature des évènements, oxygénation, fragmentation, analyse positionnelle. Conclusion « non positionnel » quand c'est le cas ; composante positionnelle dite non évaluable quand le temps sur le dos est trop court.
- **Apnées centrales** non renseignées quand aucun capteur d'effort n'est exploitable (classement impossible).
- **Alerte « peu de temps sur le dos »** : la sévérité n'est plus dite sous-estimée quand l'IAH hors dos est du même niveau que l'IAH global.

## 2026-11-06 – Version de départ
