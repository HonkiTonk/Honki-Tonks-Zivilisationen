package GlobaleDatentypen is

   -- Für Anzeige
   type TextDateien is range 0 .. 21;
   type TextZeilen is range 0 .. 84;
   subtype TextZeilenOhneNull is TextZeilen range 1 .. 84;
   -- Für Anzeige
   
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
   type KartenVerbesserung is range 0 .. 22;
   type Ebene is range -3 .. 2; -- Rückgabewert, Tiefenbohrung, Unterirdisch/Unterwasser, Oberfläche, Himmel, Weltraum/Orbit
   type BelegterGrund is range 0 .. 18_100;
   -- Für Karte



   -- Für Einheiten
   type EinheitenIDMitNullWert is range 0 .. 50;
   subtype EinheitenID is EinheitenIDMitNullWert range 1 .. 50;

   type PassierbarkeitType is range 1 .. 15; -- 1 = Cursor kann passieren, 2 = Wassereinheiten können passieren, 4 = Landeinheiten können passieren, 8 = Lufteinheiten können passieren
                                             -- Addieren für genaue Passierbarkeit
   -- Für Einheiten



   -- Für Gebäude
   type GebäudeID is range 1 .. 24;
   -- Für Gebäude



   -- Für Forschung
   type ForschungIDMitNullWert is range 0 .. 6;
   subtype ForschungID is ForschungIDMitNullWert range 1 .. ForschungIDMitNullWert'Last;

   type ErforschtArray is array (1 .. 6) of Integer;
   -- Für Forschung


   
    -- Für Stadt
   type GesamtproduktionStadt is range -500 .. 500;
   subtype GrundwerteNRGWVA is GesamtproduktionStadt range -100 .. 100; -- NRGWVA = Grundwert für Nahrung, Ressourcen, Geld, Wissenschaft, Verteidigung, Angriff
   type KostenLager is range 0 .. 10_000;

   type UmgebungBewirtschaftungArray is array (GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range, GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range) of Boolean;
   -- Für Stadt



   -- Für Rassen
   type RassenMitNullwert is range 0 .. 18; -- Unbelegt, Rasse 1 bis 18
   subtype Rassen is RassenMitNullwert range 1 .. 18;
   type RassenImSpielArray is array (Rassen'Range) of RassenMitNullwert;
   -- Für Rassen

end GlobaleDatentypen;
