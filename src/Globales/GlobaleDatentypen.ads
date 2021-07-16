pragma SPARK_Mode (On);

package GlobaleDatentypen is

   -- Für Anzeige
   type TextDateien is range 0 .. 27;
   type TextZeilen is range 0 .. 104;
   subtype TextZeilenOhneNull is TextZeilen range 1 .. TextZeilen'Last;
   -- Für Anzeige



   -- Für Tastenbelegung
   type Tastenbelegung_Enum is (Nicht_Vorhanden, Hoch, Links, Runter, Rechts, Links_Oben, Rechts_Oben, Links_Unten, Rechts_Unten, Ebene_Hoch, Ebene_Runter,
                                Auswählen, Menü_Zurück, Bauen, Forschung, Tech_Baum, Nächste_Stadt, Einheit_Mit_Bewegungspunkte, Alle_Einheiten, Einheiten_Ohne_Bewegungspunkte, Straße_Bauen,
                                Mine_Bauen, Farm_Bauen, Festung_Bauen, Wald_Aufforsten, Roden_Trockenlegen, Heilen, Verschanzen, Runde_Aussetzen, Einheit_Auflösen, Plündern,
                                Infos, Diplomatie, GeheZu, Stadt_Umbenennen, Stadt_Abreißen, Stadt_Suchen, Runde_Beenden, Cheatmenü);

   for Tastenbelegung_Enum use (Nicht_Vorhanden => 0, Hoch => 1, Links => 2, Runter => 3, Rechts => 4, Links_Oben => 5, Rechts_Oben => 6, Links_Unten => 7, Rechts_Unten => 8, Ebene_Hoch => 9, Ebene_Runter => 10,
                                Auswählen => 11, Menü_Zurück => 12, Bauen => 13, Forschung => 14, Tech_Baum => 15, Nächste_Stadt => 16, Einheit_Mit_Bewegungspunkte => 17, Alle_Einheiten => 18,
                                Einheiten_Ohne_Bewegungspunkte => 19, Straße_Bauen => 20, Mine_Bauen => 21, Farm_Bauen => 22, Festung_Bauen => 23, Wald_Aufforsten => 24, Roden_Trockenlegen => 25, Heilen => 26,
                                Verschanzen => 27, Runde_Aussetzen => 28, Einheit_Auflösen => 29, Plündern => 30, Infos => 31, Diplomatie => 32, GeheZu => 33, Stadt_Umbenennen => 34, Stadt_Abreißen => 35,
                                Stadt_Suchen => 36, Runde_Beenden => 37, Cheatmenü => 38);

   subtype Tastenbelegung_Verwendet_Enum is Tastenbelegung_Enum range Hoch .. Cheatmenü;
   subtype Tastenbelegung_Bewegung_Enum is Tastenbelegung_Verwendet_Enum range Hoch .. Ebene_Runter;
   subtype Tastenbelegung_Bewegung_Stadt_Enum is Tastenbelegung_Verwendet_Enum range Hoch .. Rechts_Unten;
   subtype Tastenbelegung_Befehle_Enum is Tastenbelegung_Verwendet_Enum range Straße_Bauen .. Plündern;
   -- Für Tastenbelegung



   -- Für Rassen
   -- Unbelegt, Rasse 1 bis 18
   type RassenMitNullwert is range 0 .. 18;
   subtype Rassen is RassenMitNullwert range 1 .. 18;
   -- type Rassen_Enum is (Leer, Rasse_1, Rasse_2, Rasse_3, Rasse_4, Rasse_5, Rasse_6, Rasse_7, Rasse_8, Rasse_9, Rasse_10, Rasse_11, Rasse_12, Rasse_13, Rasse_14, Rasse_15, Rasse_16, Rasse_17, Rasse_18);
   -- for Rassen_Enum use (Leer => 0, Rasse_1 => 1, Rasse_2 => 2, Rasse_3 => 3, Rasse_4 => 4, Rasse_5 => 5, Rasse_6 => 6, Rasse_7 => 7, Rasse_8 => 8, Rasse_9 => 9, Rasse_10 => 10, Rasse_11 => 11, Rasse_12 => 12,
   -- Rasse_13 => 13, Rasse_14 => 14, Rasse_15 => 15, Rasse_16 => 16, Rasse_17 => 17, Rasse_18 => 18);
   -- subtype Rassen_Verwendet_Enum is Rassen_Enum range Rasse_1 .. Rasse_18;
   -- 0 = Nicht belegt, 1 = Menschlicher Spieler, 2 = KI
   type Spieler_Enum is (Leer, Spieler_Mensch, Spieler_KI);
   for Spieler_Enum use (Leer => 0, Spieler_Mensch => 1, Spieler_KI => 2);
   type RassenImSpielArray is array (Rassen'Range) of Spieler_Enum;
   -- Für Rassen



   -- Für Karte
   type Kartenfeld is range -1_000 .. 1_000;
   subtype KartenfeldPositivMitNullwert is Kartenfeld range 0 .. Kartenfeld'Last;
   subtype KartenfeldPositiv is Kartenfeld range 1 .. KartenfeldPositivMitNullwert'Last;
   subtype Stadtfeld is KartenfeldPositiv range 1 .. 20;
   subtype Sichtweite is Stadtfeld range 1 .. 10;
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

   type Kartenart_Enum is (Leer, Inseln, Kontinente, Pangäa, Nur_Land, Chaos);
   for Kartenart_Enum use (Leer => 0, Inseln => 1, Kontinente => 2, Pangäa => 3, Nur_Land => 4, Chaos => 5);
   subtype Kartenart_Verwendet_Enum is Kartenart_Enum range Inseln .. Chaos;

   type Kartentemperatur_Enum is (Leer, Kalt, Gemäßigt, Heiß, Eiszeit, Wüste);
   for Kartentemperatur_Enum use (Leer => 0, Kalt => 1, Gemäßigt => 2, Heiß => 3, Eiszeit => 4, Wüste => 5);
   subtype Kartentemperatur_Verwendet_Enum is Kartentemperatur_Enum range Kalt .. Wüste;

   type Kartenform_Enum is (Leer, X_Zylinder, Y_Zylinder, Torus, Kugel, Viereck, Kugel_Gedreht);
   for Kartenform_Enum use (Leer => 0, X_Zylinder => 1, Y_Zylinder => 2, Torus => 3, Kugel => 4, Viereck => 5, Kugel_Gedreht => 6);
   subtype Kartenform_Verwendet_Enum is Kartenform_Enum range X_Zylinder .. Kugel_Gedreht;

   type KartenGrund is range 0 .. 43;
   -- Muss aktuell immer so lange sein wie (EinheitenID + GebäudeID + 1), wegen TextBauenNeuArray und der Anzeige der Bauliste
   type KartenverbesserungEinheitenID is range 0 .. 78;
   subtype KartenVerbesserung is KartenverbesserungEinheitenID range 0 .. 24;
   subtype EbeneVorhanden is Ebene range -2 .. 2;
   type BelegterGrund is range 0 .. Rassen'Last * 1_000 + 100;

   type SichtbarkeitArray is array (GlobaleDatentypen.Rassen'Range) of Boolean;
   -- Für Karte



   -- Für Einheiten
   type Bewegung_Enum is (Leer, Keine_Bewegung_Möglich, Normale_Bewegung_Möglich, Beladen_Bewegung_Möglich, Entladen_Bewegung_Möglich, Gegner_Blockiert, Transporter_Stadt_Möglich);
   -- type Befehle_Enum is (Keine, Straße_Bauen, Mine_Bauen, Farm_Bauen, Festung_Bauen, Wald_Aufforsten, Roden_Trockenlegen, Heilen, Verschanzen, Runde_Aussetzen, Einheit_Auflösen, Plündern);

   type MaximaleEinheitenMitNullWert is range 0 .. 1_000;
   subtype MaximaleEinheiten is MaximaleEinheitenMitNullWert range 1 .. MaximaleEinheitenMitNullWert'Last;

   subtype EinheitenIDMitNullWert is KartenverbesserungEinheitenID range 0 .. 50;
   subtype EinheitenID is EinheitenIDMitNullWert range 1 .. EinheitenIDMitNullWert'Last;

   -- Passierbarkeit: 1 = Boden, 2 = Wasser, 3 = Luft, 4 = Weltraum, 5 = Unterwasser, 6 = Unterirdisch (Erde), 7 = Planeteninneres (Gestein), 8 = Lava
   type PassierbarkeitType is range 1 .. 8;

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
   -- Forschungsenum sinnvoll?
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
   subtype StadtID is KartenVerbesserung range 0 .. 2;

   type UmgebungBewirtschaftungArray is array (GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range, GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range) of Boolean;

   type StadtMeldung is (Keine, Produktion_Abgeschlossen, Einwohner_Wachstum, Einwohner_Reduktion, Einheit_Unplatzierbar, Stadt_Angegriffen);
   -- Für Stadt



   -- Für Diplomatie
   type StatusUntereinander is (Kein_Kontakt, Krieg, Neutral, Offene_Grenzen, Nichtangriffspakt, Defensivbündnis, Offensivbündnis);
   -- Für Diplomatie

end GlobaleDatentypen;
