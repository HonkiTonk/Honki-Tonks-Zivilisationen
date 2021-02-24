pragma SPARK_Mode (On);

package GlobaleDatentypen is

   -- Für Anzeige
   type TextDateien is range 0 .. 22;
   type TextZeilen is range 0 .. 84;
   subtype TextZeilenOhneNull is TextZeilen range 1 .. 84;

   type WelcheDatei_Enum is (Leer, Start, Feste_Abfragen, Spiel_Einstellungen, RassenBeschreibung, Menü_Auswahl, Beschreibungen_Kartenfelder_Kurz, Beschreibungen_Kartenfelder_Lang, Fehlermeldungen, Zeug,
                             Fragen, Ladezeiten, Beschreibungen_Einheiten_Kurz, Beschreibungen_Einheiten_Lang, Beschreibungen_Verbesserungen_Kurz, Beschreibungen_Verbesserungen_Lang, Beschreibungen_Gebäude_Kurz,
                            Beschreibungen_Gebäude_Lang, Beschreibungen_Forschung_Kurz, Beschreibungen_Forschung_Lang, Beschreibungen_Beschäftigung_Kurz, Beschreibungen_Beschäftigung_Lang, Städtenamen_KI);
   type WelcherAbstand_Enum is (Keiner, Kleiner_Abstand, Großer_Abstand, Neue_Zeile); 
   -- Für Anzeige



   -- Für Rassen
   type RassenMitNullwert is range 0 .. 18; -- Unbelegt, Rasse 1 bis 18
   subtype Rassen is RassenMitNullwert range 1 .. 18;
   type RassenImSpielArray is array (Rassen'Range) of RassenMitNullwert;
   -- Für Rassen


   
   -- Für Karte
   type Kartenfeld is range -1_001 .. 1_000; -- Linke Seite muss stehts eins kleiner sein als die rechte Seite, aufgrund des aktuellen Kartengenerators (Kartengenerator.adb 181, Übergabe geht sonst nicht)!
   subtype KartenfeldPositiv is Kartenfeld range 1 .. 1_000;
   subtype Stadtfeld is KartenfeldPositiv range 1 .. 20;
   subtype Sichtweite is KartenfeldPositiv range 1 .. 10;
   subtype LoopRangeMinusEinsZuEins is Kartenfeld range -1 .. 1;
   subtype LoopRangeMinusZweiZuZwei is Kartenfeld range -2 .. 2;
   subtype LoopRangeMinusDreiZuDrei is Kartenfeld range -3 .. 3;
   subtype LoopRangeNullZuEins is Kartenfeld range 0 .. 1;

   type KartenGrund is range -2 .. 40;
   type KartenverbesserungEinheitenID is range 0 .. 50;
   subtype KartenVerbesserung is KartenverbesserungEinheitenID range 0 .. 23;
   type Ebene is range -3 .. 2; -- Rückgabewert, Tiefenbohrung, Unterirdisch/Unterwasser, Oberfläche, Himmel, Weltraum/Orbit
   subtype EbeneVorhanden is Ebene range -2 .. 2;
   type BelegterGrund is range 0 .. Rassen'Last * 1_000 + 100;

   type SichtbarkeitArray is array (GlobaleDatentypen.Rassen'Range) of Boolean;
   -- Für Karte



   -- Für Einheiten
   subtype EinheitenID is KartenverbesserungEinheitenID range 1 .. 50;

   type PassierbarkeitType is range 1 .. 15; -- 1 = Cursor kann passieren, 2 = Wassereinheiten können passieren, 4 = Landeinheiten können passieren, 8 = Lufteinheiten können passieren
                                             -- Addieren für genaue Passierbarkeit

   type EinheitenTyp is range 1 .. 12;
   subtype UnbewaffneterTyp is EinheitenTyp range 1 .. 2; -- Für später merken, jetzt aber noch nicht einbauen/nutzen, da sonst ständig Zeug verschoben werden muss
   subtype NahkämpferTyp is EinheitenTyp range 3 .. 4;
   subtype FernkampfTyp is EinheitenTyp range 5 .. 6;
   -- Für Einheiten



   -- Für Gebäude
   type GebäudeID is range 1 .. 27;
   -- Für Gebäude



   -- Für Forschung
   type AnforderungForschungArray is array (1 .. 4) of Integer;

   type ForschungIDMitNullWert is range 0 .. 6;
   subtype ForschungID is ForschungIDMitNullWert range 1 .. ForschungIDMitNullWert'Last;

   type ErforschtArray is array (1 .. 7) of Natural;
   -- Für Forschung


   
   -- Für Stadt
   type GesamtproduktionStadt is range -500 .. 500;
   subtype GrundwerteNRGWVA is GesamtproduktionStadt range -100 .. 100; -- NRGWVA = Grundwert für Nahrung, Ressourcen, Geld, Wissenschaft, Verteidigung, Angriff
   type KostenLager is range -10_000 .. 10_000;
   subtype StadtID is KartenVerbesserung range 0 .. 2;

   type UmgebungBewirtschaftungArray is array (GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range, GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range) of Boolean;
   -- Für Stadt



   -- Enums hierher verschieben?

   -- Enums hierher verschieben?

end GlobaleDatentypen;
