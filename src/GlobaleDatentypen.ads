package GlobaleDatentypen is
   
   type ZahlenBoolean is range 0 .. 1;

   type KartenGröße is range 1 .. 1_000;
   type KartenGrund is range -2 .. 36;
   type KartenVerbesserung is range 0 .. 22;

   type PassierbarkeitType is range 1 .. 15;

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
