package GlobaleDatentypen is
   
   type ZahlenBoolean is range 0 .. 1;

   type Kartenfeld is range -11 .. 1_000; -- Überall für Y/X einsetzen, Linke Seite muss stehts eins kleiner sein als maximale Sichtweite!
   subtype Stadtfeld is Kartenfeld range 1 .. 20;
   subtype Sichtweite is Kartenfeld range 1 .. 10;
   type KartenGrund is range -2 .. 36;
   type KartenVerbesserung is range 0 .. 22;

   type EinheitenID is range 0 .. 50;

   type GebäudeID is range 1 .. 24;

   type ForschungID is range 1 .. 6;

   type PassierbarkeitType is range 1 .. 15; -- 1 = Cursor kann passieren, 2 = Wassereinheiten können passieren, 4 = Landeinheiten können passieren, 8 = Lufteinheiten können passieren
                                             -- Addieren für genaue Passierbarkeit
    
   type GesamtproduktionStadt is range 0 .. 500;
   subtype GrundwerteNRGWVA is GesamtproduktionStadt range 0 .. 100; -- NRGWVA = Grundwert für Nahrung, Ressourcen, Geld, Wissenschaft, Verteidigung, Angriff
   type KostenLager is range 0 .. 10_000;

   type RassenImSpielArray is array (1 .. 18) of Integer;   

   type RückgabewertFürSchleifenPrüfungRecord is record
      
      YWert : Kartenfeld;
      XWert : Kartenfeld;
      
   end record;

   type RasseUndPlatznummerRecord is record
      
      Rasse : Integer;
      Platznummer : Integer;
      
   end record;

end GlobaleDatentypen;
