pragma SPARK_Mode (On);

package EinheitStadtDatentypen is
   
   -- Muss aktuell immer so lange sein wie (EinheitenID + GebäudeID + 1), wegen TextBauenNeuArray und der Anzeige der Bauliste.
   -- Dieser Kommentar braucht mal eine Überarbeitung!
   type MinimimMaximumID is range -1 .. 78;
   
   

   -- Für Einheiten
   type MaximaleEinheitenMitNullWert is range 0 .. 1_000;
   subtype MaximaleEinheiten is MaximaleEinheitenMitNullWert range 1 .. MaximaleEinheitenMitNullWert'Last;

   subtype EinheitenIDMitNullWert is MinimimMaximumID range 0 .. 50;
   subtype EinheitenID is EinheitenIDMitNullWert range 1 .. EinheitenIDMitNullWert'Last;

   type Passierbarkeit_Enum is (Leer,
                                Boden,
                                Wasser, Küstenwasser,
                                Unterwasser, Unterküstenwasser,
                                Luft,
                                Weltraum,
                                Unterirdisch,
                                Planeteninneres, Lava);

   subtype Passierbarkeit_Vorhanden_Enum is Passierbarkeit_Enum range Boden .. Passierbarkeit_Enum'Last;
   subtype Passierbarkeit_Fliegen_Enum is Passierbarkeit_Vorhanden_Enum range Luft .. Weltraum;

   type Einheit_Art_Enum is (Leer, Arbeiter, Nahkämpfer, Fernkämpfer, Beides, Sonstiges);
   subtype Einheit_Art_Verwendet_Enum is Einheit_Art_Enum range Arbeiter .. Einheit_Art_Enum'Last;

   type Permanente_Kosten_Enum is (Leer, Nahrung, Geld, Ressourcen, Hier_Spezielle_Ressourcen_Einbauen);
   subtype Permanente_Kosten_Verwendet_Enum is Permanente_Kosten_Enum range Nahrung .. Permanente_Kosten_Enum'Last;

   type Einheit_Meldung_Art_Enum is (Aufgabe_Fertig, Einheit_In_Der_Nähe);
   type Einheit_Meldung_Enum is (Leer, Aufgabe_Abgeschlossen, Fremde_Einheit_Nahe);
   subtype Einheit_Meldung_Verwendet_Enum is Einheit_Meldung_Enum range Aufgabe_Abgeschlossen .. Einheit_Meldung_Enum'Last;

   type BewegungFloat is digits 2 range -100.00 .. 100.00;
   subtype VorhandeneBewegungspunkte is BewegungFloat range 0.00 .. BewegungFloat'Last;
   
   type Lebenspunkte is range 0 .. 1_000;
   subtype LebenspunkteVorhanden is Lebenspunkte range 1 .. Lebenspunkte'Last;
   
   -- Negativer Bereich für Abzug.
   type KampfwerteAllgemein is range -100 .. 100;
   subtype Kampfwerte is KampfwerteAllgemein range 0 .. 100;
   
   type Transportwerte is range 0 .. 10;
   subtype Transportplätze is Transportwerte range 1 .. Transportwerte'Last;
   -- Für Einheiten



   -- Für Gebäude
   subtype GebäudeIDMitNullwert is MinimimMaximumID range 0 .. 27;
   subtype GebäudeID is GebäudeIDMitNullwert range 1 .. GebäudeIDMitNullwert'Last;

   type Gebäude_Spezielle_Eigenschaften_Enum is (Leer, Eigenschaft);
   subtype Gebäude_Spezielle_Eigenschaften_Verwendet_Enum is Gebäude_Spezielle_Eigenschaften_Enum range Eigenschaft .. Gebäude_Spezielle_Eigenschaften_Enum'Last;
   -- Für Gebäude



   -- Für Forschung
   subtype ForschungIDNichtMöglich is MinimimMaximumID range -1 .. 75;
   subtype ForschungIDMitNullWert is ForschungIDNichtMöglich range 0 .. ForschungIDNichtMöglich'Last;
   subtype ForschungID is ForschungIDMitNullWert range 1 .. ForschungIDMitNullWert'Last;

   type AnforderungForschungArray is array (1 .. 4) of ForschungIDNichtMöglich;
   type ErforschtArray is array (ForschungID'Range) of Boolean;
   -- Für Forschung



   -- Für Stadt
   subtype MaximaleStädteMitNullWert is MaximaleEinheitenMitNullWert range 0 .. 100;
   subtype MaximaleStädte is MaximaleStädteMitNullWert range 1 .. 100;

   -- Das hier mal an die neuen Produktionsidee anpassen.
   type KostenLager is range -10_000 .. 10_000;
   subtype GesamtePermanenteKosten is KostenLager range -500 .. 5_000;
   subtype GesamtproduktionStadt is GesamtePermanenteKosten range -500 .. 500;
   subtype ProduktionFeld is GesamtproduktionStadt range -100 .. 100;
   subtype ProduktionElement is ProduktionFeld range -10 .. 10;

   type ProduktionSonstiges is new ProduktionFeld range -1 .. 100;

   type Stadt_Meldung_Art_Enum is (Produktion_Fertig, Hungersnot, Einheit_In_Der_Nähe);
   type Stadt_Meldung_Enum is (Leer, Produktion_Abgeschlossen, Einheit_Unplatzierbar, Einwohner_Wachstum, Einwohner_Reduktion, Fremde_Einheit_Nahe_Stadt);
   subtype Stadt_Meldungen_Verwendet_Enum is Stadt_Meldung_Enum range Produktion_Abgeschlossen .. Stadt_Meldung_Enum'Last;
   -- Für Stadt

end EinheitStadtDatentypen;
