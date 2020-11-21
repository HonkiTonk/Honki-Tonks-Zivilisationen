package GlobaleDatentypen is
   
   type ZahlenBoolean is range 0 .. 1;

   type KartenFelder is range 1 .. 1_000; -- Überall für Y/X einsetzen
   type KartenGrund is range -2 .. 36;
   type KartenVerbesserung is range 0 .. 22;

   type EinheitenID is range 0 .. 50;

   type GebäudeID is range 1 .. 24;

   type ForschungID is range 1 .. 6;

   type PassierbarkeitType is range 1 .. 15; -- 1 = Cursor kann passieren, 2 = Wassereinheiten können passieren, 4 = Landeinheiten können passieren, 8 = Lufteinheiten können passieren
                                             -- Addieren für genaue Passierbarkeit
   type GrundwerteNRGWVA is range 0 .. 100; -- NRGWVA = Grundwert für Nahrung, Ressourcen, Geld, Wissenschaft, Verteidigung, Angriff
   type GesamtproduktionStadt is range 0 .. 500;

   type RassenImSpielArray is array (1 .. 18) of Integer;   

   type RückgabewertFürSchleifenPrüfungRecord is record
      
      YWert : Integer;
      XWert : Integer;
      
   end record;

   type RasseUndPlatznummerRecord is record
      
      Rasse : Integer;
      Platznummer : Integer;
      
   end record;

end GlobaleDatentypen;
