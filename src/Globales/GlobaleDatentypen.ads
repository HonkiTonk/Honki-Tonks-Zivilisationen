pragma SPARK_Mode (On);

package GlobaleDatentypen is

   -- Für Anzeige
   type TextDateien is range 0 .. 25;
   type TextZeilen is range 0 .. 93;
   subtype TextZeilenOhneNull is TextZeilen range 1 .. TextZeilen'Last;

   type Welche_Datei_Enum is (Leer, Start, Feste_Abfragen, Spiel_Einstellungen, Rassen_Beschreibung_Lang, Menü_Auswahl, Beschreibungen_Kartenfelder_Kurz, Beschreibungen_Kartenfelder_Lang, Fehlermeldungen, Zeug,
                              Fragen, Ladezeiten, Beschreibungen_Einheiten_Kurz, Beschreibungen_Einheiten_Lang, Beschreibungen_Verbesserungen_Kurz, Beschreibungen_Verbesserungen_Lang, Beschreibungen_Gebäude_Kurz,
                              Beschreibungen_Gebäude_Lang, Beschreibungen_Forschung_Kurz, Beschreibungen_Forschung_Lang, Beschreibungen_Beschäftigung_Kurz, Beschreibungen_Beschäftigung_Lang, Städtenamen_KI, Cheat_Menü,
                              Rassen_Beschreibung_Kurz, Beschreibung_Forschung_Ermöglicht);

   type Welcher_Abstand_Enum is (Keiner, Kleiner_Abstand, Großer_Abstand, Neue_Zeile);
   -- Für Anzeige



   -- Für Rassen
   type RassenMitNullwert is range 0 .. 18; -- Unbelegt, Rasse 1 bis 18
   subtype Rassen is RassenMitNullwert range 1 .. 18;
   type RassenImSpielArray is array (Rassen'Range) of RassenMitNullwert; -- 0 = Nicht belegt, 1 = Menschlicher Spieler, 2 = KI
   -- Für Rassen


   
   -- Für Karte
   type Kartenfeld is range -1_000 .. 1_000;
   subtype KartenfeldPositiv is Kartenfeld range 1 .. Kartenfeld'Last;
   subtype Stadtfeld is KartenfeldPositiv range 1 .. 20;
   subtype Sichtweite is Stadtfeld range 1 .. 10;
   subtype LoopRangeMinusEinsZuEins is Kartenfeld range -1 .. 1;
   subtype LoopRangeMinusZweiZuZwei is Kartenfeld range -2 .. 2;
   subtype LoopRangeMinusDreiZuDrei is Kartenfeld range -3 .. 3;
   subtype LoopRangeNullZuEins is Kartenfeld range 0 .. 1;

   type KartenGrund is range 0 .. 42;
   type KartenverbesserungEinheitenID is range 0 .. 78; -- Muss aktuell immer so lange sein wie (EinheitenID + GebäudeID + 1), wegen TextBauenNeuArray und der Anzeige der Bauliste
   subtype KartenVerbesserung is KartenverbesserungEinheitenID range 0 .. 23;
   type Ebene is range -3 .. 2; -- Rückgabewert, Tiefenbohrung, Unterirdisch/Unterwasser, Oberfläche, Himmel, Weltraum/Orbit
   subtype EbeneVorhanden is Ebene range -2 .. 2;
   type BelegterGrund is range 0 .. Rassen'Last * 1_000 + 100;

   type SichtbarkeitArray is array (GlobaleDatentypen.Rassen'Range) of Boolean;
   -- Für Karte



   -- Für Einheiten
   type Bewegung_Enum is (Leer, Keine_Bewegung_Möglich, Normale_Bewegung_Möglich, Beladen_Bewegung_Möglich, Entladen_Bewegung_Möglich, Gegner_Blockiert, Transporter_Stadt_Möglich);
   type Befehle_Enum is (Keine, Straße_Bauen, Mine_Bauen, Farm_Bauen, Festung_Bauen, Wald_Aufforsten, Roden_Trockenlegen, Heilen, Verschanzen, Runde_Aussetzen, Einheit_Auflösen, Plündern);

   type MaximaleEinheitenMitNullWert is range 0 .. 1_000;
   subtype MaximaleEinheiten is MaximaleEinheitenMitNullWert range 1 .. MaximaleEinheitenMitNullWert'Last;

   subtype EinheitenIDMitNullWert is KartenverbesserungEinheitenID range 0 .. 50;
   subtype EinheitenID is EinheitenIDMitNullWert range 1 .. EinheitenIDMitNullWert'Last;

   type PassierbarkeitType is range 1 .. 7; -- 1 = Boden, 2 = Wasser, 3 = Luft, 4 = Weltraum, 5 = Unterwasser, 6 = Unterirdisch, 7 = Planeteninneres

   type EinheitenTyp is range 1 .. 12;
   subtype UnbewaffneterTyp is EinheitenTyp range 1 .. 2; -- Für später merken, jetzt aber noch nicht einbauen/nutzen, da sonst ständig Zeug verschoben werden muss
   subtype NahkämpferTyp is EinheitenTyp range 3 .. 4;
   subtype FernkampfTyp is EinheitenTyp range 5 .. 6;
   -- Für Einheiten



   -- Für Gebäude
   subtype GebäudeID is KartenverbesserungEinheitenID range 1 .. 27;
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
   subtype GrundwerteNRGWVA is GesamtproduktionStadt range -100 .. 100; -- NRGWVA = Grundwert für Nahrung, Ressourcen, Geld, Wissenschaft, Verteidigung, Angriff
   subtype StadtID is KartenVerbesserung range 0 .. 2;

   type UmgebungBewirtschaftungArray is array (GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range, GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range) of Boolean;
   -- Für Stadt



   -- Für Diplomatie
   type StatusUntereinander is (Kein_Kontakt, Krieg, Neutral, Offene_Grenzen, Nichtangriffspakt, Defensivbündnis, Offensivbündnis);
   -- Für Diplomatie

end GlobaleDatentypen;
