package GlobaleDatentypen is

   type RassenImSpielarray is array (1 .. 18) of Integer;

   type RückgabewertFürSchleifenPrüfungRecord is record
      
      YWert : Integer;
      XWert : Integer;
      
   end record;

   type RasseUndPlatznummerRecord is record
      
      Rasse : Integer;
      Platznummer : Integer;
      
   end record;

end GlobaleDatentypen;
