package TextnummernKonstanten is
   pragma Pure;
   
   ZeugEinwohner : constant Positive := 1;
   ZeugNahrungsmittel : constant Positive := ZeugEinwohner + 1;
   ZeugRessourcenproduktion : constant Positive := ZeugNahrungsmittel + 1;
   ZeugGeldproduktion : constant Positive := ZeugRessourcenproduktion + 1;
   ZeugWissensproduktion : constant Positive := ZeugGeldproduktion + 1;
   ZeugKorruption : constant Positive := ZeugWissensproduktion + 1;
   ZeugBauprojekt : constant Positive := ZeugKorruption + 1;
   ZeugVerbleibendeBauzeit : constant Positive := ZeugBauprojekt + 1;
   ZeugLebenspunkte : constant Positive := ZeugVerbleibendeBauzeit + 1;
   ZeugBewegungspunkte : constant Positive := ZeugLebenspunkte + 1;
   ZeugErfahrungspunkte : constant Positive := ZeugBewegungspunkte + 1;
   ZeugBeschäftigung : constant Positive := ZeugErfahrungspunkte + 1;
   ZeugAngriff : constant Positive := ZeugBeschäftigung + 1;
   ZeugVerteidigung : constant Positive := ZeugAngriff + 1;
   ZeugRang : constant Positive := ZeugVerteidigung + 1;
   ZeugKeines : constant Positive := ZeugRang + 1;
   ZeugAktuelleRunde : constant Positive := ZeugKeines + 1;
   ZeugAktuelleGeldmenge : constant Positive := ZeugAktuelleRunde + 1;
   ZeugVerbleibendeForschungszeit : constant Positive := ZeugAktuelleGeldmenge + 1;
   ZeugAktuellesForschungsprojekt : constant Positive := ZeugVerbleibendeForschungszeit + 1;
   ZeugVerfügbareArbeiter : constant Positive := ZeugAktuellesForschungsprojekt + 1;
   ZeugWirdBenötigt : constant Positive := ZeugVerfügbareArbeiter + 1;
   ZeugBaukosten : constant Positive := ZeugWirdBenötigt + 1;
   ZeugAktuelleLadung : constant Positive := ZeugBaukosten + 1;
   ZeugHeimatstadt : constant Positive := ZeugAktuelleLadung + 1;
   ZeugPermanenteNahrungskosten : constant Positive := ZeugHeimatstadt + 1;
   ZeugPermanenteGeldkosten : constant Positive := ZeugPermanenteNahrungskosten + 1;
   ZeugPermanenteProduktionskosten : constant Positive := ZeugPermanenteGeldkosten + 1;
   ZeugAktuellePosition : constant Positive := ZeugPermanenteProduktionskosten + 1;
   ZeugPermanenterNahrungsbonus : constant Positive := ZeugAktuellePosition + 1;
   ZeugPermanenterProduktionsbonus : constant Positive := ZeugPermanenterNahrungsbonus + 1;
   ZeugPermanenterGeldbonus : constant Positive := ZeugPermanenterProduktionsbonus + 1;
   ZeugPermanenterWissenbonus : constant Positive := ZeugPermanenterGeldbonus + 1;
   ZeugPermanenterVerteidigungsbonus : constant Positive := ZeugPermanenterWissenbonus + 1;
   ZeugPermanenterAngriffsbonus : constant Positive := ZeugPermanenterVerteidigungsbonus + 1;
   ZeugGebäude : constant Positive := ZeugPermanenterAngriffsbonus + 1;
   ZeugEinheiten : constant Positive := ZeugGebäude + 1;
   ZeugLeer : constant Positive := ZeugEinheiten + 1;
   
   -- Die Zahlen für die Ja/Nein müssen immer nacheinander kommen, da nur die erste Konstante verwendet wird und darauf aufbauen die Zweite ermittelt wird.
   ZeugJa : constant Positive := ZeugLeer + 1;
   ZeugNein : constant Positive := ZeugJa + 1;
   ZeugMit : constant Positive := ZeugNein + 1;
   ZeugFrieden : constant Positive := ZeugMit + 1;
   ZeugNichtangriffspakt : constant Positive := ZeugFrieden + 1;
   ZeugKrieg : constant Positive := ZeugNichtangriffspakt + 1;
   ZeugKampfwerte : constant Positive := ZeugKrieg + 1;
   ZeugTransportkapazität : constant Positive := ZeugKampfwerte + 1;
   ZeugTransportergröße : constant Positive := ZeugTransportkapazität + 1;
   ZeugEinheitengröße : constant Positive := ZeugTransportergröße + 1;
   
   -- Die Zahlen für die Größe müssen immer nacheinander kommen, da nur die erste Konstante verwendet wird und darauf aufbauen die weitern Größen ermittelt werden.
   ZeugKlein : constant Positive := ZeugEinheitengröße + 1;
   ZeugMittel : constant Positive := ZeugKlein + 1;
   ZeugGroß : constant Positive := ZeugMittel + 1;
   ZeugRiesige : constant Positive := ZeugGroß + 1;
   ZeugGigantisch : constant Positive := ZeugRiesige + 1;
   
   -- Die Auswahlteile für das Baumenü muss immer nacheinandern kommen, da mit der Position Berechnungen angestellt werden.
   ZeugStadt : constant Positive := ZeugGigantisch + 1;
   ZeugEinheit : constant Positive := ZeugStadt + 1;
   ZeugGebäudeBaumenü : constant Positive := ZeugEinheit + 1;
   ZeugEinheitenBaumenü : constant Positive := ZeugGebäudeBaumenü + 1;
   ZeugZurück : constant Positive := ZeugEinheitenBaumenü + 1;
   ZeugWeiter : constant Positive := ZeugZurück + 1;
   
   AnfangZeug : constant Positive := 1;
   EndeZeug : constant Positive := ZeugWeiter;
   
   
   
   FrageWievieleAutospielstände : constant Positive := 1;
   FrageBeschäftigungAbbrechen : constant Positive := FrageWievieleAutospielstände + 1;
   FrageLandverbesserungErsetzen : constant Positive := FrageBeschäftigungAbbrechen + 1;
   FrageEinheitAuflösen : constant Positive := FrageLandverbesserungErsetzen + 1;
   FrageGebäudeAbreißen : constant Positive := FrageEinheitAuflösen + 1;
   FrageKriegErklären : constant Positive := FrageGebäudeAbreißen + 1;
   FrageLandverbesserungPlündern : constant Positive := FrageKriegErklären + 1;
   FrageBauprojekt : constant Positive := FrageLandverbesserungPlündern + 1;
   FrageForschungsprojekt : constant Positive := FrageBauprojekt + 1;
   FrageSpielstandÜberschreiben : constant Positive := FrageForschungsprojekt + 1;
   FrageYAchsengrößeEingeben : constant Positive := FrageSpielstandÜberschreiben + 1;
   FrageSpielstandname : constant Positive := FrageYAchsengrößeEingeben + 1;
   FrageRundenAutomatischSpeichern : constant Positive := FrageSpielstandname + 1;
   FrageXAchsengrößeEingeben : constant Positive := FrageRundenAutomatischSpeichern + 1;
   FrageNeueTaste : constant Positive := FrageXAchsengrößeEingeben + 1;
   FrageStadtAbreißen : constant Positive := FrageNeueTaste + 1;
   FrageSpeziesDiplomatie : constant Positive := FrageStadtAbreißen + 1;
   FrageGewonnenWeiterspielen : constant Positive := FrageSpeziesDiplomatie + 1;
   FrageWelcheEbene : constant Positive := FrageGewonnenWeiterspielen + 1;
   FrageWelcheYPosition : constant Positive := FrageWelcheEbene + 1;
   FrageWelcheXPosition : constant Positive := FrageWelcheYPosition + 1;
   FrageAuflösungsbreite : constant Positive := FrageWelcheXPosition + 1;
   FrageAuflösungshöhe : constant Positive := FrageAuflösungsbreite + 1;
   FrageBildrate : constant Positive := FrageAuflösungshöhe + 1;
   FrageStadtname : constant Positive := FrageBildrate + 1;
   FrageEisschicht : constant Positive := FrageStadtname + 1;
   FrageMinimaleLandhöhe : constant Positive := FrageEisschicht + 1;
   FrageMaximaleLandhöhe : constant Positive := FrageMinimaleLandhöhe + 1;
   FrageMinimaleLandbreite : constant Positive := FrageMaximaleLandhöhe + 1;
   FrageMaximaleLandbreite : constant Positive := FrageMinimaleLandbreite + 1;
   FrageKIEinsetzen : constant Positive := FrageMaximaleLandbreite + 1;
   FrageGebäudeverkauf : constant Positive := FrageKIEinsetzen + 1;
   FrageSpielstandLöschen : constant Positive := FrageGebäudeverkauf + 1;
   FrageStadtSuchen : constant Positive := FrageSpielstandLöschen + 1;
   FrageSoundlautstärke : constant Positive := FrageStadtSuchen + 1;
   FrageMusiklautstärke : constant Positive := FrageSoundlautstärke + 1;
   FrageBauprojektWechseln : constant Positive := FrageMusiklautstärke + 1;
   FrageForschungsprojektWechseln : constant Positive := FrageBauprojektWechseln + 1;
   
   AnfangFrage : constant Positive := 1;
   EndeFrage : constant Positive := FrageForschungsprojektWechseln;
   
   
   
   MeldungVerbesserung : constant Positive := 1;
   MeldungBefehl : constant Positive := MeldungVerbesserung + 1;
   MeldungVerbesserungExistiert : constant Positive := MeldungBefehl + 1;
   MeldungStädtemaximum : constant Positive := MeldungVerbesserungExistiert + 1;
   MeldungBewegungspunkte : constant Positive := MeldungStädtemaximum + 1;
   MeldungVerbesserungTechnologie : constant Positive := MeldungBewegungspunkte + 1;
   MeldungStatus : constant Positive := MeldungVerbesserungTechnologie + 1;
   MeldungImKrieg : constant Positive := MeldungStatus + 1;
   MeldungNichtangriffspakt : constant Positive := MeldungImKrieg + 1;
   MeldungBelegt : constant Positive := MeldungNichtangriffspakt + 1;
   MeldungLadenFehlgeschlagen : constant Positive := MeldungBelegt + 1;
   MeldungUnverbesserbar : constant Positive := MeldungLadenFehlgeschlagen + 1;
   MeldungNichtEigenesGebiet : constant Positive := MeldungUnverbesserbar + 1;
   MeldungVerbessertZuGroß : constant Positive := MeldungNichtEigenesGebiet + 1;
   MeldungFehlenderLaderaum : constant Positive := MeldungVerbessertZuGroß + 1;
   MeldungSpeichernFehlgeschlagen : constant Positive := MeldungFehlenderLaderaum + 1;
   
   AnfangMeldung : constant Positive := 1;
   EndeMeldung : constant Positive := MeldungSpeichernFehlgeschlagen;
   
   
   
   LadezeitSpielwelt : constant Positive := 1;
   LadezeitAllgemeines : constant Positive := LadezeitSpielwelt + 1;
   LadezeitKüstenwasser : constant Positive := LadezeitAllgemeines + 1;
   LadezeitLandschaft : constant Positive := LadezeitKüstenwasser + 1;
   LadezeitUnterfläche : constant Positive := LadezeitLandschaft + 1;
   LadezeitFlüsse : constant Positive := LadezeitUnterfläche + 1;
   LadezeitRessourcen : constant Positive := LadezeitFlüsse + 1;
   LadezeitSpezies : constant Positive := LadezeitRessourcen + 1;
   LadezeitRechnet : constant Positive := LadezeitSpezies + 1;
   LadezeitEinheiten : constant Positive := LadezeitRechnet + 1;
   LadezeitStädte : constant Positive := LadezeitEinheiten + 1;
   LadezeitForschung : constant Positive := LadezeitStädte + 1;
   LadezeitDiplomatie : constant Positive := LadezeitForschung + 1;
   LadezeitRundenwechsel : constant Positive := LadezeitDiplomatie + 1;
   LadezeitSpielstand : constant Positive := LadezeitRundenwechsel + 1;
   
   AnfangLadezeit : constant Positive := 1;
   EndeLadezeit : constant Positive := LadezeitSpielstand;
   
   KurzeBeschreibung : constant Positive := 1;
   LangeBeschreibung : constant Positive := 2;
   
   
   
   subtype ZeugVorhanden is Positive range AnfangZeug .. EndeZeug;
   
   subtype FragenVorhanden is Positive range AnfangFrage .. EndeFrage;
     
   subtype Spielmeldungen is Natural range 0 .. EndeMeldung;
   subtype SpielmeldungenVorhanden is Positive range AnfangMeldung .. Spielmeldungen'Last;
   
   subtype LadezeitVorhanden is Positive range AnfangLadezeit .. EndeLadezeit;
   
   subtype Beschreibungen is Positive range KurzeBeschreibung .. LangeBeschreibung;

end TextnummernKonstanten;
