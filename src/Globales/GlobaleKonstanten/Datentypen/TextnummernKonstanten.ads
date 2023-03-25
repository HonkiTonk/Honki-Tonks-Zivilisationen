package TextnummernKonstanten is
   pragma Pure;
   
   ZeugEinwohner : constant Positive := 1;
   ZeugNahrungsmittel : constant Positive := 2;
   ZeugRessourcenproduktion : constant Positive := 3;
   ZeugGeldproduktion : constant Positive := 4;
   ZeugWissensproduktion : constant Positive := 5;
   ZeugKorruption : constant Positive := 6;
   ZeugBauprojekt : constant Positive := 7;
   ZeugVerbleibendeBauzeit : constant Positive := 8;
   ZeugLebenspunkte : constant Positive := 9;
   ZeugBewegungspunkte : constant Positive := 10;
   ZeugErfahrungspunkte : constant Positive := 11;
   ZeugBeschäftigung : constant Positive := 12;
   ZeugAngriff : constant Positive := 13;
   ZeugVerteidigung : constant Positive := 14;
   ZeugRang : constant Positive := 15;
   ZeugKeines : constant Positive := 16;
   ZeugAktuelleRunde : constant Positive := 17;
   ZeugAktuelleGeldmenge : constant Positive := 18;
   ZeugVerbleibendeForschungszeit : constant Positive := 19;
   ZeugAktuellesForschungsprojekt : constant Positive := 20;
   ZeugVerfügbareArbeiter : constant Positive := 21;
   ZeugWirdBenötigt : constant Positive := 22;
   ZeugBaukosten : constant Positive := 23;
   ZeugAktuelleLadung : constant Positive := 24;
   ZeugHeimatstadt : constant Positive := 25;
   ZeugPermanenteNahrungskosten : constant Positive := 26;
   ZeugPermanenteGeldkosten : constant Positive := 27;
   ZeugPermanenteProduktionskosten : constant Positive := 28;
   ZeugAktuellePosition : constant Positive := 29;
   ZeugPermanenterNahrungsbonus : constant Positive := 30;
   ZeugPermanenterProduktionsbonus : constant Positive := 31;
   ZeugPermanenterGeldbonus : constant Positive := 32;
   ZeugPermanenterWissenbonus : constant Positive := 33;
   ZeugPermanenterVerteidigungsbonus : constant Positive := 34;
   ZeugPermanenterAngriffsbonus : constant Positive := 35;
   ZeugGebäude : constant Positive := 36;
   ZeugEinheiten : constant Positive := 37;
   ZeugLeer : constant Positive := 38;
   
   -- Die Zahlen für die Ja/Nein müssen immer nacheinander kommen, da nur die erste Konstante verwendet wird und darauf aufbauen die Zweite ermittelt wird.
   ZeugJa : constant Positive := 39;
   ZeugNein : constant Positive := 40;
   ZeugMit : constant Positive := 41;
   ZeugFrieden : constant Positive := 42;
   ZeugNichtangriffspakt : constant Positive := 43;
   ZeugKrieg : constant Positive := 44;
   ZeugKampfwerte : constant Positive := 45;
   ZeugTransportkapazität : constant Positive := 46;
   ZeugTransportergröße : constant Positive := 47;
   ZeugEinheitengröße : constant Positive := 48;
   
   -- Die Zahlen für die Größe müssen immer nacheinander kommen, da nur die erste Konstante verwendet wird und darauf aufbauen die weitern Größen ermittelt werden.
   ZeugKlein : constant Positive := 49;
   ZeugMittel : constant Positive := 50;
   ZeugGroß : constant Positive := 51;
   ZeugRiesige : constant Positive := 52;
   ZeugGigantisch : constant Positive := 53;
   
   ZeugStadt : constant Positive := 54;
   ZeugEinheit : constant Positive := 55;
   
   AnfangZeug : constant Positive := 1;
   EndeZeug : constant Positive := 55;
   
   
   
   FrageWievieleAutospielstände : constant Positive := 1;
   FrageBeschäftigungAbbrechen : constant Positive := 2;
   FrageLandverbesserungErsetzen : constant Positive := 3;
   FrageEinheitAuflösen : constant Positive := 4;
   FrageGebäudeAbreißen : constant Positive := 5;
   FrageKriegErklären : constant Positive := 6;
   FrageLandverbesserungPlündern : constant Positive := 7;
   FrageBauprojekt : constant Positive := 8;
   FrageForschungsprojekt : constant Positive := 9;
   FrageSpielstandÜberschreiben : constant Positive := 10;
   FrageYAchsengrößeEingeben : constant Positive := 11;
   FrageSpielstandname : constant Positive := 12;
   FrageRundenAutomatischSpeichern : constant Positive := 13;
   FrageXAchsengrößeEingeben : constant Positive := 14;
   FrageNeueTaste : constant Positive := 15;
   FrageStadtAbreißen : constant Positive := 16;
   FrageSpeziesDiplomatie : constant Positive := 17;
   FrageGewonnenWeiterspielen : constant Positive := 18;
   FrageWelcheEbene : constant Positive := 19;
   FrageWelcheYPosition : constant Positive := 20;
   FrageWelcheXPosition : constant Positive := 21;
   FrageAuflösungsbreite : constant Positive := 22;
   FrageAuflösungshöhe : constant Positive := 23;
   FrageBildrate : constant Positive := 24;
   FrageStadtname : constant Positive := 25;
   FrageEisschicht : constant Positive := 26;
   FrageMinimaleLandhöhe : constant Positive := 27;
   FrageMaximaleLandhöhe : constant Positive := 28;
   FrageMinimaleLandbreite : constant Positive := 29;
   FrageMaximaleLandbreite : constant Positive := 30;
   FrageKIEinsetzen : constant Positive := 31;
   FrageGebäudeverkauf : constant Positive := 32;
   FrageSpielstandLöschen : constant Positive := 33;
   FrageStadtSuchen : constant Positive := 34;
   FrageSoundlautstärke : constant Positive := 35;
   FrageMusiklautstärke : constant Positive := 36;
   
   AnfangFrage : constant Positive := 1;
   EndeFrage : constant Positive := 36;
   
   
   
   MeldungVerbesserung : constant Positive := 1;
   MeldungBefehl : constant Positive := 2;
   MeldungVerbesserungExistiert : constant Positive := 3;
   MeldungStädtemaximum : constant Positive := 4;
   MeldungBewegungspunkte : constant Positive := 5;
   MeldungVerbesserungTechnologie : constant Positive := 6;
   MeldungStatus : constant Positive := 7;
   MeldungImKrieg : constant Positive := 8;
   MeldungNichtangriffspakt : constant Positive := 9;
   MeldungBelegt : constant Positive := 10;
   MeldungUnladbar : constant Positive := 11;
   MeldungUnverbesserbar : constant Positive := 12;
   MeldungNichtEigenesGebiet : constant Positive := 13;
   MeldungVerbessertZuGroß : constant Positive := 14;
   MeldungFehlenderLaderaum : constant Positive := 15;
   
   AnfangMeldung : constant Positive := 1;
   EndeMeldung : constant Positive := 15;
   
   
   
   LadezeitSpielwelt : constant Positive := 1;
   LadezeitAllgemeines : constant Positive := 2;
   LadezeitKüstenwasser : constant Positive := 3;
   LadezeitLandschaft : constant Positive := 4;
   LadezeitUnterfläche : constant Positive := 5;
   LadezeitFlüsse : constant Positive := 6;
   LadezeitRessourcen : constant Positive := 7;
   LadezeitSpezies : constant Positive := 8;
   LadezeitRechnet : constant Positive := 9;
   LadezeitEinheiten : constant Positive := 10;
   LadezeitStädte : constant Positive := 11;
   LadezeitForschung : constant Positive := 12;
   LadezeitDiplomatie : constant Positive := 13;
   LadezeitRundenwechsel : constant Positive := 14;
   LadezeitSpielstand : constant Positive := 15;
   
   AnfangLadezeit : constant Positive := 1;
   EndeLadezeit : constant Positive := 15;

end TextnummernKonstanten;
