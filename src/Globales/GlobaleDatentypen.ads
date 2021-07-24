pragma SPARK_Mode (On);

package GlobaleDatentypen is

   -- Sonstiges
   type Anfang_Ende_Enum is (Leer, Anfangswert, Endwert);
   for Anfang_Ende_Enum use (Leer => 0, Anfangswert => 1, Endwert => 2);
   subtype Anfang_Ende_Verwendet is Anfang_Ende_Enum range Anfangswert .. Endwert;

   type Schwierigkeitsgrad_Enum is (Leer, Einfach, Mittel, Schwer);
   subtype Schwierigkeitsgrad_Verwendet_Enum is Schwierigkeitsgrad_Enum range Einfach .. Schwer;
   -- Sonstiges

   -- Für Anzeige
   type TextDateien is range 0 .. 28;
   type TextZeilen is range 0 .. 104;
   subtype TextZeilenOhneNull is TextZeilen range 1 .. TextZeilen'Last;
   -- Für Anzeige



   -- Für Tastenbelegung
   type Tastenbelegung_Enum is (Nicht_Vorhanden,
                                -- Bewegung
                                Hoch, Links, Runter, Rechts, Links_Oben, Rechts_Oben, Links_Unten, Rechts_Unten, Ebene_Hoch, Ebene_Runter,
                                Auswählen, Menü_Zurück,
                                Bauen, Forschung, Tech_Baum,
                                Nächste_Stadt, Einheit_Mit_Bewegungspunkte, Alle_Einheiten, Einheiten_Ohne_Bewegungspunkte,
                                -- Einheitenbefehle
                                Straße_Bauen, Mine_Bauen, Farm_Bauen, Festung_Bauen, Wald_Aufforsten, Roden_Trockenlegen, Heilen, Verschanzen, Runde_Aussetzen, Plündern, Einheit_Auflösen, Einheit_Verbessern,
                                Infos, Diplomatie, GeheZu,
                                Stadt_Umbenennen, Stadt_Abreißen, Stadt_Suchen,
                                Runde_Beenden, Cheatmenü);

   subtype Tastenbelegung_Verwendet_Enum is Tastenbelegung_Enum range Hoch .. Cheatmenü;
   subtype Tastenbelegung_Bewegung_Enum is Tastenbelegung_Verwendet_Enum range Hoch .. Ebene_Runter;
   subtype Tastenbelegung_Bewegung_Stadt_Enum is Tastenbelegung_Verwendet_Enum range Hoch .. Rechts_Unten;
   subtype Tastenbelegung_Befehle_Enum is Tastenbelegung_Verwendet_Enum range Straße_Bauen .. Einheit_Verbessern;
   subtype Tastenbelegung_Verbesserung_Befehle_Enum is Tastenbelegung_Befehle_Enum range Straße_Bauen .. Roden_Trockenlegen;
   -- Für Tastenbelegung



   -- Für Rassen
   type Rassen_Enum is (Leer, Rasse_1, Rasse_2, Rasse_3, Rasse_4, Rasse_5, Rasse_6, Rasse_7, Rasse_8, Rasse_9, Rasse_10, Rasse_11, Rasse_12, Rasse_13, Rasse_14, Rasse_15, Rasse_16, Rasse_17, Rasse_18);
   for Rassen_Enum use (Leer => 0, Rasse_1 => 1, Rasse_2 => 2, Rasse_3 => 3, Rasse_4 => 4, Rasse_5 => 5, Rasse_6 => 6, Rasse_7 => 7, Rasse_8 => 8, Rasse_9 => 9, Rasse_10 => 10, Rasse_11 => 11, Rasse_12 => 12,
                        Rasse_13 => 13, Rasse_14 => 14, Rasse_15 => 15, Rasse_16 => 16, Rasse_17 => 17, Rasse_18 => 18);
   subtype Rassen_Verwendet_Enum is Rassen_Enum range Rasse_1 .. Rasse_18;

   type Spieler_Enum is (Leer, Spieler_Mensch, Spieler_KI);
   for Spieler_Enum use (Leer => 0, Spieler_Mensch => 1, Spieler_KI => 2);
   type RassenImSpielArray is array (Rassen_Verwendet_Enum'Range) of Spieler_Enum;
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
   -- Rückgabewert, Tiefenbohrung, Unterirdisch/Unterwasser, Oberfläche, Himmel, Weltraum/Orbit
   subtype Ebene is LoopRangeMinusDreiZuDrei range -3 .. 2;

   -- Kartenwerte
   type Kartengröße_Enum is (Leer, Karte_20_20, Karte_40_40, Karte_80_80, Karte_120_80, Karte_120_160, Karte_160_160, Karte_240_240, Karte_320_320, Karte_1000_1000, Karte_Nutzer);
   for Kartengröße_Enum use (Leer => 0, Karte_20_20 => 1, Karte_40_40 => 2, Karte_80_80 => 3, Karte_120_80 => 4, Karte_120_160 => 5, Karte_160_160 => 6, Karte_240_240 => 7, Karte_320_320 => 8,
                               Karte_1000_1000 => 9, Karte_Nutzer => 10);
   subtype Kartengröße_Verwendet_Enum is Kartengröße_Enum range Karte_20_20 .. Karte_Nutzer;
   subtype Kartengröße_Zufall_Enum is Kartengröße_Verwendet_Enum range Karte_20_20 .. Karte_1000_1000;

   type Kartenart_Enum is (Leer, Inseln, Kontinente, Pangäa, Nur_Land, Chaos);
   for Kartenart_Enum use (Leer => 0, Inseln => 1, Kontinente => 2, Pangäa => 3, Nur_Land => 4, Chaos => 5);
   subtype Kartenart_Verwendet_Enum is Kartenart_Enum range Inseln .. Chaos;

   type Kartentemperatur_Enum is (Leer, Kalt, Gemäßigt, Heiß, Eiszeit, Wüste);
   for Kartentemperatur_Enum use (Leer => 0, Kalt => 1, Gemäßigt => 2, Heiß => 3, Eiszeit => 4, Wüste => 5);
   subtype Kartentemperatur_Verwendet_Enum is Kartentemperatur_Enum range Kalt .. Wüste;

   type Kartenform_Enum is (Leer, X_Zylinder, Y_Zylinder, Torus, Kugel, Viereck, Kugel_Gedreht);
   for Kartenform_Enum use (Leer => 0, X_Zylinder => 1, Y_Zylinder => 2, Torus => 3, Kugel => 4, Viereck => 5, Kugel_Gedreht => 6);
   subtype Kartenform_Verwendet_Enum is Kartenform_Enum range X_Zylinder .. Kugel_Gedreht;

   type Karten_Grund_Enum is (Leer,
                              -- Feld
                              Wasser, Küstengewässer, Unter_Wasser, Unter_Küstengewässer,
                              Eis, Lava, Flachland, Tundra, Wüste, Hügel, Gebirge, Wald, Dschungel, Sumpf, Hügel_Mit, Wolken, Weltraum, Erde, Gestein,
                              -- Ressource
                              Fisch, Wal,
                              Kohle, Eisen, Öl, Hochwertiger_Boden, Gold,
                              -- Fluss
                              Flusskreuzung_Vier, Fluss_Waagrecht, Fluss_Senkrecht, Flusskurve_Unten_Rechts, Flusskurve_Unten_Links, Flusskurve_Oben_Rechts, Flusskurve_Oben_Links, Flusskreuzung_Drei_Oben,
                              Flusskreuzung_Drei_Unten, Flusskreuzung_Drei_Rechts, Flusskreuzung_Drei_Links, Flussendstück_Links, Flussendstück_Rechts, Flussendstück_Unten, Flussendstück_Oben, Fluss_Einzeln);
   subtype Karten_Grund_Alle_Felder_Enum is Karten_Grund_Enum range Wasser .. Gestein;
   subtype Karten_Grund_Felder_Ungünstig_Enum is Karten_Grund_Alle_Felder_Enum range Wasser .. Lava;
   subtype Karten_Grund_Wasser_Mit_Eis_Enum is Karten_Grund_Felder_Ungünstig_Enum range Wasser .. Eis;
   subtype Karten_Grund_Wasser_Enum is Karten_Grund_Wasser_Mit_Eis_Enum range Wasser .. Unter_Küstengewässer;
   subtype Karten_Grund_Land_Enum is Karten_Grund_Alle_Felder_Enum range Eis .. Gestein;
   subtype Karten_Grund_Land_Ohne_Eis_Enum is Karten_Grund_Land_Enum range Flachland .. Gestein;
   subtype Karten_Grund_Ressourcen_Enum is Karten_Grund_Enum range Fisch .. Gold;
   subtype Karten_Grund_Ressourcen_Wasser is Karten_Grund_Ressourcen_Enum range Fisch .. Wal;
   subtype Karten_Grund_Ressourcen_Land is Karten_Grund_Ressourcen_Enum range Kohle .. Gold;
   subtype Karten_Grund_Fluss_Enum is Karten_Grund_Enum range Flusskreuzung_Vier .. Fluss_Einzeln;
   subtype Landschaft_Wahrscheinlichkeit_Enum is Karten_Grund_Land_Ohne_Eis_Enum range GlobaleDatentypen.Tundra .. GlobaleDatentypen.Sumpf;

   -- Muss aktuell immer so lange sein wie (EinheitenID + GebäudeID + 1), wegen TextBauenNeuArray und der Anzeige der Bauliste
   type KartenverbesserungEinheitenID is range 0 .. 78;

   type Karten_Verbesserung_Enum is (Leer,
                                     -- Städte
                                     Eigene_Hauptstadt, Eigene_Stadt,
                                     Fremde_Hauptstadt, Fremde_Stadt,
                                     -- Gebilde
                                     Farm, Mine,
                                     Festung, Sperre,
                                     -- Straßen
                                     Straßenkreuzung_Vier, Straße_Waagrecht, Straße_Senkrecht, Straßenkurve_Unten_Rechts, Straßenkurve_Unten_Links, Straßenkurve_Oben_Rechts, Straßenkurve_Oben_Links,
                                     Straßenkreuzung_Drei_Oben, Straßenkreuzung_Drei_Unten, Straßenkreuzung_Drei_Rechts, Straßenkreuzung_Drei_Links, Straßenendstück_Links, Straßenendstück_Rechts,
                                     Straßenendstück_Unten, Straßenendstück_Oben, Straße_Einzeln);
   subtype Karten_Verbesserung_Stadt_ID_Enum is Karten_Verbesserung_Enum range Leer .. Eigene_Stadt;
   subtype Karten_Verbesserung_Städte_Enum is Karten_Verbesserung_Enum range Eigene_Hauptstadt .. Fremde_Stadt;
   subtype Karten_Verbesserung_Eigene_Städte_Enum is Karten_Verbesserung_Städte_Enum range Eigene_Hauptstadt .. Eigene_Stadt;
   subtype Karten_Verbesserung_Fremde_Städte_Enum is Karten_Verbesserung_Städte_Enum range Fremde_Hauptstadt .. Fremde_Stadt;
   subtype Karten_Verbesserung_Gebilde_Enum is Karten_Verbesserung_Enum range Farm .. Sperre;
   subtype Karten_Verbesserung_Gebilde_Friedlich_Enum is Karten_Verbesserung_Gebilde_Enum range Farm .. Mine;
   subtype Karten_Verbesserung_Gebilde_Kampf_Enum is Karten_Verbesserung_Gebilde_Enum range Festung .. Sperre;
   subtype Karten_Verbesserung_Straße_Enum is Karten_Verbesserung_Enum range Straßenkreuzung_Vier .. Straße_Einzeln;

   subtype EbeneVorhanden is Ebene range -2 .. 2;
   type BelegterGrund is range 0 .. 18 * 1_000 + 100;

   type SichtbarkeitArray is array (GlobaleDatentypen.Rassen_Verwendet_Enum'Range) of Boolean;
   -- Für Karte



   -- Für Einheiten
   type Bewegung_Enum is (Leer, Keine_Bewegung_Möglich, Normale_Bewegung_Möglich, Beladen_Bewegung_Möglich, Entladen_Bewegung_Möglich, Gegner_Blockiert, Transporter_Stadt_Möglich);
   -- type Befehle_Enum is (Keine, Straße_Bauen, Mine_Bauen, Farm_Bauen, Festung_Bauen, Wald_Aufforsten, Roden_Trockenlegen, Heilen, Verschanzen, Runde_Aussetzen, Einheit_Auflösen, Plündern);

   type MaximaleEinheitenMitNullWert is range 0 .. 1_000;
   subtype MaximaleEinheiten is MaximaleEinheitenMitNullWert range 1 .. MaximaleEinheitenMitNullWert'Last;

   subtype EinheitenIDMitNullWert is KartenverbesserungEinheitenID range 0 .. 50;
   subtype EinheitenID is EinheitenIDMitNullWert range 1 .. EinheitenIDMitNullWert'Last;

   -- Passierbarkeit
   type Passierbarkeit_Enum is (Leer,
                                Boden,
                                Wasser, Unterwasser,
                                Luft, Weltraum,
                                Unteridrisch, Planeteninneres,
                                Lava);
   subtype Passierbarkeit_Vorhanden_Enum is Passierbarkeit_Enum range Boden .. Lava;
   subtype Passierbarkeit_Fliegen_Enum is Passierbarkeit_Vorhanden_Enum range Luft .. Weltraum;


   type EinheitenTyp is range 1 .. 12;
   -- Für später merken, jetzt aber noch nicht einbauen/nutzen, da sonst ständig Zeug verschoben werden muss
   subtype UnbewaffneterTyp is EinheitenTyp range 1 .. 2;
   subtype NahkämpferTyp is EinheitenTyp range 3 .. 4;
   subtype FernkampfTyp is EinheitenTyp range 5 .. 6;
   -- Für Einheiten



   -- Für Gebäude
   subtype GebäudeID is KartenverbesserungEinheitenID range 1 .. 25;
   -- Für Gebäude



   -- Für Forschung
   subtype ForschungIDMitNullWert is KartenverbesserungEinheitenID range 0 .. 25;
   subtype ForschungID is ForschungIDMitNullWert range 1 .. ForschungIDMitNullWert'Last;

   type AnforderungForschungArray is array (1 .. 4) of ForschungIDMitNullWert;
   type ErforschtArray is array (ForschungID'Range) of Boolean;
   -- Für Forschung



   -- Für Stadt
   subtype MaximaleStädteMitNullWert is MaximaleEinheitenMitNullWert range 0 .. 100;
   subtype MaximaleStädte is MaximaleStädteMitNullWert range 1 .. 100;

   type KostenLager is range -10_000 .. 10_000;
   subtype GesamtproduktionStadt is KostenLager range -500 .. 500;
   subtype WerteNahrungMaterialGeldWissenVerteidigungAngriff is GesamtproduktionStadt range -100 .. 100;

   type UmgebungBewirtschaftungArray is array (GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range, GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range) of Boolean;

   type Stadt_Meldung_Enum is (Keine, Produktion_Abgeschlossen, Einwohner_Wachstum, Einwohner_Reduktion, Einheit_Unplatzierbar, Stadt_Angegriffen);
   -- Für Stadt



   -- Für Diplomatie
   type Status_Untereinander_Enum is (Kein_Kontakt,
                                      -- Neutral
                                      Neutral,
                                      -- Friedlich
                                      Offene_Grenzen, Nichtangriffspakt, Defensivbündnis, Offensivbündnis,
                                      -- Aggressiv
                                      Krieg);
   subtype Status_Untereinander_Neutral_Enum is Status_Untereinander_Enum range Neutral .. Neutral;
   subtype Status_Untereinander_Friedlich_Enum is Status_Untereinander_Enum range Offene_Grenzen .. Offensivbündnis;
   subtype Status_Untereinander_Aggressiv_Enum is Status_Untereinander_Enum range Krieg .. Krieg;
   -- Für Diplomatie

end GlobaleDatentypen;
