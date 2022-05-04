pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package EinheitStadtDatentypen is
   
   -------------------- -1 kommt noch von der ForschungID, mal umbauen.
   -------------------- Dieser Kommentar braucht mal eine Überarbeitung!
   -------------------- Hier braucht alles mal eine Überarbeitung!!!
   type MinimimMaximumID is range 0 .. 78;
   
   

   -- Für Einheiten
   type MaximaleEinheitenMitNullWert is range 0 .. 1_000;
   subtype MaximaleEinheiten is MaximaleEinheitenMitNullWert range 1 .. MaximaleEinheitenMitNullWert'Last;

   subtype EinheitenIDMitNullWert is MinimimMaximumID range 0 .. 50;
   subtype EinheitenID is EinheitenIDMitNullWert range 1 .. EinheitenIDMitNullWert'Last;

   type Passierbarkeit_Enum is (
                                Leer_Enum,
                                
                                Boden_Enum,
                                
                                Wasser_Enum, Küstenwasser_Enum,
                                Unterwasser_Enum, Unterküstenwasser_Enum,
                                
                                Luft_Enum, Weltraum_Enum,
                                
                                Unterirdisch_Enum, Planeteninneres_Enum, Lava_Enum
                               );

   subtype Passierbarkeit_Vorhanden_Enum is Passierbarkeit_Enum range Boden_Enum .. Passierbarkeit_Enum'Last;
   subtype Passierbarkeit_Fliegen_Enum is Passierbarkeit_Vorhanden_Enum range Luft_Enum .. Weltraum_Enum;

   type Einheit_Art_Enum is (
                             Leer_Enum,
                             
                             Arbeiter_Enum, Nahkämpfer_Enum, Fernkämpfer_Enum, Beides_Enum, Sonstiges_Enum, Cheat_Enum
                            );
   subtype Einheit_Art_Verwendet_Enum is Einheit_Art_Enum range Arbeiter_Enum .. Einheit_Art_Enum'Last;

   type Permanente_Kosten_Enum is (
                                   Leer_Enum,
                                   
                                   Nahrung_Enum, Geld_Enum, Ressourcen_Enum, Hier_Spezielle_Ressourcen_Einbauen_Enum
                                  );
   subtype Permanente_Kosten_Verwendet_Enum is Permanente_Kosten_Enum range Nahrung_Enum .. Permanente_Kosten_Enum'Last;

   type Einheit_Meldung_Art_Enum is (
                                     Aufgabe_Fertig_Enum, Einheit_In_Der_Nähe_Enum
                                    );
   type Einheit_Meldung_Enum is (
                                 Leer_Enum,
                                 
                                 Aufgabe_Abgeschlossen_Enum, Fremde_Einheit_Nahe_Enum
                                );
   subtype Einheit_Meldung_Verwendet_Enum is Einheit_Meldung_Enum range Aufgabe_Abgeschlossen_Enum .. Einheit_Meldung_Enum'Last;

   type BewegungFloat is digits 2 range -100.00 .. 100.00;
   subtype VorhandeneBewegungspunkte is BewegungFloat range 0.00 .. BewegungFloat'Last;
   
   type Lebenspunkte is range 0 .. 1_000;
   subtype LebenspunkteVorhanden is Lebenspunkte range 1 .. Lebenspunkte'Last;
   
   -- Negativer Bereich für Abzug.
   type KampfwerteAllgemein is range -100 .. 100;
   subtype Kampfwerte is KampfwerteAllgemein range 0 .. 100;
   
   type Transport_Enum is (
                           Kein_Transport_Enum,
                           
                           Klein_Transport_Enum, Mittel_Transport_Enum, Groß_Transport_Enum, Riesig_Transport_Enum, Gigantisch_Transport_Enum
                          );
   pragma Ordered (Transport_Enum);
   
   subtype Transport_Vorhanden_Enum is Transport_Enum range Klein_Transport_Enum .. Gigantisch_Transport_Enum;
     
   -- Hier den Minimalwert bei 0 lassen, wenn ausversehen ein Transport zugewiesen wird, dann kann die Einheit trotzdem nich transportieren.
   type Transportplätze is range 0 .. 10;
   subtype TransportplätzeVorhanden is Transportplätze range 1 .. Transportplätze'Last;
   -- Für Einheiten
   


   -- Für Gebäude
   subtype GebäudeIDMitNullwert is MinimimMaximumID range 0 .. 27;
   subtype GebäudeID is GebäudeIDMitNullwert range 1 .. GebäudeIDMitNullwert'Last;

   type Gebäude_Spezielle_Eigenschaften_Enum is (
                                                  Leer_Enum,
                                                  
                                                  Eigenschaft_Enum
                                                 );
   subtype Gebäude_Spezielle_Eigenschaften_Verwendet_Enum is Gebäude_Spezielle_Eigenschaften_Enum range Eigenschaft_Enum .. Gebäude_Spezielle_Eigenschaften_Enum'Last;
   -- Für Gebäude



   -- Für Forschung
   type ForschungIDNichtMöglich is range -1 .. 75;
   subtype ForschungIDMitNullWert is ForschungIDNichtMöglich range 0 .. ForschungIDNichtMöglich'Last;
   subtype ForschungID is ForschungIDMitNullWert range 1 .. ForschungIDMitNullWert'Last;

   type AnforderungForschungArray is array (1 .. 4) of ForschungIDNichtMöglich;
   type ErforschtArray is array (ForschungID'Range) of Boolean;
   -- Für Forschung
   


   -- Für Stadt
   subtype MaximaleStädteMitNullWert is MaximaleEinheitenMitNullWert range 0 .. 100;
   subtype MaximaleStädte is MaximaleStädteMitNullWert range 1 .. 100;

   ---------------------- Das hier mal an die neuen Produktionsidee anpassen.
   type KostenLager is range -10_000 .. 10_000;
   subtype GesamtePermanenteKosten is KostenLager range -500 .. 5_000;
   subtype GesamtproduktionStadt is GesamtePermanenteKosten range -500 .. 500;
   subtype ProduktionFeld is GesamtproduktionStadt range -100 .. 100;
   subtype ProduktionElement is ProduktionFeld range -10 .. 10;

   type ProduktionSonstiges is new ProduktionFeld range -1 .. 100;

   type Stadt_Meldung_Art_Enum is (
                                   Produktion_Fertig_Enum, Hungersnot_Enum, Einheit_In_Der_Nähe_Enum
                                  );
   type Stadt_Meldung_Enum is (
                               Leer_Enum,
                               
                               Produktion_Abgeschlossen_Enum, Einheit_Unplatzierbar_Enum, Einwohner_Wachstum_Enum, Einwohner_Reduktion_Enum, Fremde_Einheit_Nahe_Stadt_Enum
                              );
   subtype Stadt_Meldungen_Verwendet_Enum is Stadt_Meldung_Enum range Produktion_Abgeschlossen_Enum .. Stadt_Meldung_Enum'Last;
   -- Für Stadt

end EinheitStadtDatentypen;
