pragma SPARK_Mode (On);

package GlobaleDatentypen is

   -- Sonstiges
   type Anfang_Ende_Enum is (Anfangswert, Endwert);
   for Anfang_Ende_Enum use (Anfangswert => 0, Endwert => 1);

   type Schwierigkeitsgrad_Enum is (Leer, Einfach, Mittel, Schwer);
   subtype Schwierigkeitsgrad_Verwendet_Enum is Schwierigkeitsgrad_Enum range Einfach .. Schwierigkeitsgrad_Enum'Last;
   -- Sonstiges



   -- Für Anzeige
   type TextDateien is range 0 .. 31;
   type TextZeilen is range 0 .. 93;
   subtype TextZeilenOhneNull is TextZeilen range 1 .. TextZeilen'Last;
   -- Für Anzeige



   -- Für Tastenbelegung
   type Tastenbelegung_Enum is (Nicht_Vorhanden,
                                -- Bewegung
                                Hoch, Links, Runter, Rechts, Links_Oben, Rechts_Oben, Links_Unten, Rechts_Unten, Ebene_Hoch, Ebene_Runter,
                                Auswählen, Menü_Zurück,
                                Bauen, Forschung, Tech_Baum,
                                Nächste_Stadt, Einheit_Mit_Bewegungspunkte, Alle_Einheiten, Einheiten_Ohne_Bewegungspunkte, Nächste_Stadt_Mit_Meldung, Nächste_Einheit_Mit_Meldung,
                                -- Einheitenbefehle Verbesserungen
                                Straße_Bauen, Schiene_Bauen, Tunnel_Bauen, Mine_Bauen, Farm_Bauen, Festung_Bauen, Wald_Aufforsten, Roden_Trockenlegen,
                                -- Einheitenbefehle allgemein
                                Heilen, Verschanzen, Runde_Aussetzen, Plündern, Einheit_Auflösen, Einheit_Verbessern,
                                Heimatstadt_Ändern,
                                -- Sonstiges
                                Infos, Diplomatie, GeheZu,
                                Stadt_Umbenennen, Stadt_Abreißen, Stadt_Suchen,
                                Runde_Beenden, Cheatmenü);

   subtype Tastenbelegung_Verwendet_Enum is Tastenbelegung_Enum range Hoch .. Tastenbelegung_Enum'Last;
   subtype Tastenbelegung_Bewegung_Enum is Tastenbelegung_Verwendet_Enum range Hoch .. Ebene_Runter;
   subtype Tastenbelegung_Bewegung_Stadt_Enum is Tastenbelegung_Verwendet_Enum range Hoch .. Rechts_Unten;
   subtype Tastenbelegung_Befehle_Enum is Tastenbelegung_Verwendet_Enum range Straße_Bauen .. Einheit_Verbessern;
   subtype Tastenbelegung_Verbesserung_Befehle_Enum is Tastenbelegung_Befehle_Enum range Straße_Bauen .. Roden_Trockenlegen;
   subtype Tastenbelegung_Allgemeine_Befehle_Enum is Tastenbelegung_Befehle_Enum range Heilen .. Tastenbelegung_Befehle_Enum'Last;
   -- Für Tastenbelegung



   -- Für Rassen
   type Rassen_Enum is (Leer, Menschen, Kasrodiah, Lasupin, Lamustra, Manuky, Suroka, Pryolon, Talbidahr, Moru_Phisihl, Larinos_Lotaris, Carupex, Alary, Tesorahn, Natries_Zermanis, Tridatus, Senelari, Aspari_2, Ekropa);
   for Rassen_Enum use (Leer => 0, Menschen => 1, Kasrodiah => 2, Lasupin => 3, Lamustra => 4, Manuky => 5, Suroka => 6, Pryolon => 7, Talbidahr => 8, Moru_Phisihl => 9, Larinos_Lotaris => 10, Carupex => 11, Alary => 12,
                        Tesorahn => 13, Natries_Zermanis => 14, Tridatus => 15, Senelari => 16, Aspari_2 => 17, Ekropa => 18);
   subtype Rassen_Verwendet_Enum is Rassen_Enum range Menschen .. Rassen_Enum'Last;

   type Spieler_Enum is (Leer, Spieler_Mensch, Spieler_KI);
   type RassenImSpielArray is array (Rassen_Verwendet_Enum'Range) of Spieler_Enum;

   type Staatsform_Enum is (Anarchie,
                            Demokratie);

   type StaatsformenArray is array (1 .. 5) of Staatsform_Enum;
   -- Für Rassen



   -- Für Karte
   type Kartenfeld is range -1_000 .. 1_000;
   subtype KartenfeldPositivMitNullwert is Kartenfeld range 0 .. Kartenfeld'Last;
   subtype KartenfeldPositiv is Kartenfeld range 1 .. KartenfeldPositivMitNullwert'Last;
   subtype Stadtfeld is KartenfeldPositiv range 1 .. 20;
   subtype SichtweiteMitNullwert is KartenfeldPositivMitNullwert range 0 .. 10;
   subtype Sichtweite is SichtweiteMitNullwert range 1 .. 10;
   subtype LoopRangeMinusEinsZuEins is Kartenfeld range -1 .. 1;
   subtype LoopRangeMinusZweiZuZwei is Kartenfeld range -2 .. 2;
   subtype LoopRangeMinusDreiZuDrei is Kartenfeld range -3 .. 3;
   subtype LoopRangeNullZuEins is Kartenfeld range 0 .. 1;
   -- Rückgabewert, Planeteninneres, Unterirdisch/Unterwasser, Oberfläche, Himmel, Weltraum/Orbit
   subtype Ebene is LoopRangeMinusDreiZuDrei range -3 .. 2;

   -- Kartenwerte
   type Kartengröße_Enum is (Leer, Karte_20_20, Karte_40_40, Karte_80_80, Karte_120_80, Karte_120_160, Karte_160_160, Karte_240_240, Karte_320_320, Karte_1000_1000, Karte_Nutzer);
   subtype Kartengröße_Verwendet_Enum is Kartengröße_Enum range Karte_20_20 .. Kartengröße_Enum'Last;
   subtype Kartengröße_Zufall_Enum is Kartengröße_Verwendet_Enum range Karte_20_20 .. Karte_1000_1000;

   type Kartenart_Enum is (Leer, Inseln, Kontinente, Pangäa, Nur_Land, Chaos);
   subtype Kartenart_Verwendet_Enum is Kartenart_Enum range Inseln .. Kartenart_Enum'Last;

   type Kartentemperatur_Enum is (Leer, Kalt, Gemäßigt, Heiß, Eiszeit, Wüste);
   subtype Kartentemperatur_Verwendet_Enum is Kartentemperatur_Enum range Kalt .. Kartentemperatur_Enum'Last;

   type Kartenform_Enum is (Leer, X_Zylinder, Y_Zylinder, Torus, Kugel, Viereck, Kugel_Gedreht, Tugel, Tugel_Gedreht, Tugel_Extrem);
   subtype Kartenform_Verwendet_Enum is Kartenform_Enum range X_Zylinder .. Kartenform_Enum'Last;

   type Karten_Ressourcen_Reichtum_Enum is (Leer, Arm, Wenig, Mittel, Viel, Überfluss);
   subtype Karten_Ressourcen_Reichtum_Verwendet_Enum is Karten_Ressourcen_Reichtum_Enum range Arm .. Karten_Ressourcen_Reichtum_Enum'Last;

   type Karten_Grund_Enum is (Leer,
                              -- Feld
                              Wasser, Küstengewässer, Unterwasser_Wasser, Unterwasser_Küstengewässer,
                              Eis, Unterwasser_Eis,
                              Lava, Planetenkern,
                              Tundra, Wüste, Hügel, Gebirge, Wald, Dschungel, Sumpf, Flachland, Hügel_Mit, Wolken, Weltraum, Erde, Erdgestein, Sand, Gestein,
                              Korallen, Unterwasser_Wald,
                              -- Ressourcen
                              Fisch, Wal,
                              Kohle, Eisen, Öl, Hochwertiger_Boden, Gold,
                              -- Fluss
                              Flusskreuzung_Vier, Fluss_Waagrecht, Fluss_Senkrecht, Flusskurve_Unten_Rechts, Flusskurve_Unten_Links, Flusskurve_Oben_Rechts, Flusskurve_Oben_Links, Flusskreuzung_Drei_Oben,
                              Flusskreuzung_Drei_Unten, Flusskreuzung_Drei_Rechts, Flusskreuzung_Drei_Links, Flussendstück_Links, Flussendstück_Rechts, Flussendstück_Unten, Flussendstück_Oben, Fluss_Einzeln,
                              -- Unterirdischer Fluss
                              Unterirdische_Flusskreuzung_Vier, Unterirdischer_Fluss_Waagrecht, Unterirdischer_Fluss_Senkrecht, Unterirdische_Flusskurve_Unten_Rechts, Unterirdische_Flusskurve_Unten_Links,
                              Unterirdische_Flusskurve_Oben_Rechts, Unterirdische_Flusskurve_Oben_Links, Unterirdische_Flusskreuzung_Drei_Oben, Unterirdische_Flusskreuzung_Drei_Unten,
                              Unterirdische_Flusskreuzung_Drei_Rechts, Unterirdische_Flusskreuzung_Drei_Links, Unterirdisches_Flussendstück_Links, Unterirdisches_Flussendstück_Rechts,
                              Unterirdisches_Flussendstück_Unten, Unterirdisches_Flussendstück_Oben, Unterirdischer_Fluss_Einzeln,
                              -- Lavafluss
                              Lavaflusskreuzung_Vier, Lavafluss_Waagrecht, Lavafluss_Senkrecht, Lavaflusskurve_Unten_Rechts, Lavaflusskurve_Unten_Links, Lavaflusskurve_Oben_Rechts, Lavaflusskurve_Oben_Links,
                              Lavaflusskreuzung_Drei_Oben, Lavaflusskreuzung_Drei_Unten, Lavaflusskreuzung_Drei_Rechts, Lavaflusskreuzung_Drei_Links, Lavaflussendstück_Links, Lavaflussendstück_Rechts,
                              Lavaflussendstück_Unten, Lavaflussendstück_Oben, Lavafluss_Einzeln
                             );

   subtype Karten_Grund_Alle_Felder_Enum is Karten_Grund_Enum range Wasser .. Unterwasser_Wald;
   subtype Karten_Grund_Wasser_Mit_Eis_Enum is Karten_Grund_Alle_Felder_Enum range Wasser .. Unterwasser_Eis;
   subtype Karten_Grund_Wasser_Enum is Karten_Grund_Wasser_Mit_Eis_Enum range Wasser .. Unterwasser_Küstengewässer;
   subtype Karten_Grund_Land_Enum is Karten_Grund_Alle_Felder_Enum range Eis .. Gestein;
   subtype Karten_Grund_Land_Ohne_Eis_Enum is Karten_Grund_Land_Enum range Tundra .. Gestein;
   subtype Karten_Grund_Ressourcen_Enum is Karten_Grund_Enum range Fisch .. Gold;
   subtype Karten_Grund_Ressourcen_Wasser is Karten_Grund_Ressourcen_Enum range Fisch .. Wal;
   subtype Karten_Grund_Ressourcen_Land is Karten_Grund_Ressourcen_Enum range Kohle .. Gold;
   subtype Karten_Fluss_Enum is Karten_Grund_Enum range Flusskreuzung_Vier .. Lavafluss_Einzeln;
   subtype Karten_Grund_Fluss_Enum is Karten_Fluss_Enum range Flusskreuzung_Vier .. Fluss_Einzeln;
   subtype Karten_Grund_Unterirdischer_Fluss_Enum is Karten_Fluss_Enum range Unterirdische_Flusskreuzung_Vier .. Unterirdischer_Fluss_Einzeln;
   subtype Karten_Grund_Lavafluss_Enum is Karten_Fluss_Enum range Lavaflusskreuzung_Vier .. Lavafluss_Einzeln;
   subtype Landschaft_Wahrscheinlichkeit_Enum is Karten_Grund_Land_Ohne_Eis_Enum range Tundra .. Sumpf;
   -- Flachland muss hier immer am Schluss kommen, sonst geht der Kartengenerator kaputt!
   subtype Karten_Grund_Generator_Enum is Karten_Grund_Land_Ohne_Eis_Enum range Tundra .. Flachland;
   subtype Karten_Unterwasser_Generator_Enum is Karten_Grund_Alle_Felder_Enum range Korallen .. Unterwasser_Wald;

   -- Muss aktuell immer so lange sein wie (EinheitenID + GebäudeID + 1), wegen TextBauenNeuArray und der Anzeige der Bauliste
   type KartenverbesserungEinheitenID is range -1 .. 100;

   -- Immer dran denken, alle Wegearten am Schluss hinzufügen.
   type Karten_Verbesserung_Enum is (Leer,
                                     -- Städte
                                     Eigene_Hauptstadt, Eigene_Stadt,
                                     Fremde_Hauptstadt, Fremde_Stadt,
                                     -- Gebilde
                                     Farm, Mine,
                                     Festung, Sperre,
                                     -- Wege - Straßen
                                     Straßenkreuzung_Vier, Straße_Waagrecht, Straße_Senkrecht, Straßenkurve_Unten_Rechts, Straßenkurve_Unten_Links, Straßenkurve_Oben_Rechts, Straßenkurve_Oben_Links,
                                     Straßenkreuzung_Drei_Oben, Straßenkreuzung_Drei_Unten, Straßenkreuzung_Drei_Rechts, Straßenkreuzung_Drei_Links, Straßenendstück_Links, Straßenendstück_Rechts,
                                     Straßenendstück_Unten, Straßenendstück_Oben, Straße_Einzeln,
                                     -- Schienen
                                     Schienenkreuzung_Vier, Schiene_Waagrecht, Schiene_Senkrecht, Schienenkurve_Unten_Rechts, Schienenkurve_Unten_Links, Schienenkurve_Oben_Rechts, Schienenkurve_Oben_Links,
                                     Schienenkreuzung_Drei_Oben, Schienenkreuzung_Drei_Unten, Schienenkreuzung_Drei_Rechts, Schienenkreuzung_Drei_Links, Schienenendstück_Links, Schienenendstück_Rechts,
                                     Schienenendstück_Unten, Schienenendstück_Oben, Schiene_Einzeln,
                                     -- Tunnel
                                     Tunnelkreuzung_Vier, Tunnel_Waagrecht, Tunnel_Senkrecht, Tunnelkurve_Unten_Rechts, Tunnelkurve_Unten_Links, Tunnelkurve_Oben_Rechts, Tunnelkurve_Oben_Links,
                                     Tunnelkreuzung_Drei_Oben, Tunnelkreuzung_Drei_Unten, Tunnelkreuzung_Drei_Rechts, Tunnelkreuzung_Drei_Links, Tunnelendstück_Links, Tunnelendstück_Rechts,
                                     Tunnelendstück_Unten, Tunnelendstück_Oben, Tunnel_Einzeln
                                    );

   subtype Karten_Verbesserung_Stadt_ID_Enum is Karten_Verbesserung_Enum range Leer .. Eigene_Stadt;
   subtype Karten_Verbesserung_Städte_Enum is Karten_Verbesserung_Enum range Eigene_Hauptstadt .. Fremde_Stadt;
   subtype Karten_Verbesserung_Eigene_Städte_Enum is Karten_Verbesserung_Städte_Enum range Eigene_Hauptstadt .. Eigene_Stadt;
   subtype Karten_Verbesserung_Fremde_Städte_Enum is Karten_Verbesserung_Städte_Enum range Fremde_Hauptstadt .. Fremde_Stadt;
   subtype Karten_Verbesserung_Gebilde_Enum is Karten_Verbesserung_Enum range Farm .. Sperre;
   subtype Karten_Verbesserung_Gebilde_Friedlich_Enum is Karten_Verbesserung_Gebilde_Enum range Farm .. Mine;
   subtype Karten_Verbesserung_Gebilde_Kampf_Enum is Karten_Verbesserung_Gebilde_Enum range Festung .. Sperre;
   subtype Karten_Verbesserung_Weg_Enum is Karten_Verbesserung_Enum range Straßenkreuzung_Vier .. Straße_Einzeln;
   subtype Karten_Verbesserung_Schiene_Enum is Karten_Verbesserung_Enum range Schienenkreuzung_Vier .. Schiene_Einzeln;
   subtype Karten_Verbesserung_Tunnel_Enum is Karten_Verbesserung_Enum range Tunnelkreuzung_Vier .. Tunnel_Einzeln;

   subtype EbeneVorhanden is Ebene range -2 .. 2;
   type BelegterGrund is range 0 .. 18 * 1_000 + 100;

   type SichtbarkeitArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range) of Boolean;

   type Besondere_Ressourcen_Enum is (Leer, Kohle);
   subtype Besondere_Ressourcen_Verwendet_Enum is Besondere_Ressourcen_Enum range Kohle .. Besondere_Ressourcen_Enum'Last;

   type Bewertung_Werte_Enum is (Wertigkeit, Nahrung, Produktion, Geld, Wissen, Verteidigung, Angriff);
   -- Für Karte



   -- Für Einheiten
   type Bewegung_Enum is (Leer, Keine_Bewegung_Möglich, Normale_Bewegung_Möglich, Beladen_Bewegung_Möglich, Entladen_Bewegung_Möglich, Gegner_Blockiert, Transporter_Stadt_Möglich);

   type MaximaleEinheitenMitNullWert is range 0 .. 1_000;
   subtype MaximaleEinheiten is MaximaleEinheitenMitNullWert range 1 .. MaximaleEinheitenMitNullWert'Last;

   subtype EinheitenIDMitNullWert is KartenverbesserungEinheitenID range 0 .. 50;
   subtype EinheitenID is EinheitenIDMitNullWert range 1 .. EinheitenIDMitNullWert'Last;

   -- Passierbarkeit
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
   -- Für Einheiten



   -- Für Gebäude
   subtype GebäudeID is KartenverbesserungEinheitenID range 1 .. 27;

   type Gebäude_Spezielle_Eigenschaften_Enum is (Leer, Eigenschaft);
   subtype Gebäude_Spezielle_Eigenschaften_Verwendet_Enum is Gebäude_Spezielle_Eigenschaften_Enum range Eigenschaft .. Gebäude_Spezielle_Eigenschaften_Enum'Last;
   -- Für Gebäude



   -- Für Forschung
   subtype ForschungIDNichtMöglich is KartenverbesserungEinheitenID range -1 .. 75;
   subtype ForschungIDMitNullWert is ForschungIDNichtMöglich range 0 .. ForschungIDNichtMöglich'Last;
   subtype ForschungID is ForschungIDMitNullWert range 1 .. ForschungIDMitNullWert'Last;

   type AnforderungForschungArray is array (1 .. 4) of ForschungIDMitNullWert;
   type ErforschtArray is array (ForschungID'Range) of Boolean;
   -- Für Forschung



   -- Für Stadt
   subtype MaximaleStädteMitNullWert is MaximaleEinheitenMitNullWert range 0 .. 100;
   subtype MaximaleStädte is MaximaleStädteMitNullWert range 1 .. 100;

   type KostenLager is range -10_000 .. 10_000;
   subtype GesamtePermanenteKosten is KostenLager range -500 .. 5_000;
   subtype GesamtproduktionStadt is GesamtePermanenteKosten range -500 .. 500;
   subtype ProduktionFeld is GesamtproduktionStadt range -100 .. 100;
   subtype ProduktionElement is ProduktionFeld range -10 .. 10;

   type UmgebungBewirtschaftungArray is array (GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range, GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range) of Boolean;

   type Stadt_Meldung_Art_Enum is (Produktion_Fertig, Hungersnot, Einheit_In_Der_Nähe);
   type Stadt_Meldung_Enum is (Leer, Produktion_Abgeschlossen, Einheit_Unplatzierbar, Einwohner_Wachstum, Einwohner_Reduktion, Fremde_Einheit_Nahe_Stadt);
   subtype Stadt_Meldungen_Verwendet_Enum is Stadt_Meldung_Enum range Produktion_Abgeschlossen .. Stadt_Meldung_Enum'Last;

   type PermanenteKostenArray is array (GlobaleDatentypen.Permanente_Kosten_Verwendet_Enum'Range) of GlobaleDatentypen.GesamtePermanenteKosten;
   -- Für Stadt



   -- Für Diplomatie
   type Status_Untereinander_Enum is (Unbekannt, Neutral, Nichtangriffspakt, Krieg);
   subtype Status_Untereinander_Bekannt_Enum is Status_Untereinander_Enum range Neutral .. Status_Untereinander_Enum'Last;
   -- Für Diplomatie

end GlobaleDatentypen;
