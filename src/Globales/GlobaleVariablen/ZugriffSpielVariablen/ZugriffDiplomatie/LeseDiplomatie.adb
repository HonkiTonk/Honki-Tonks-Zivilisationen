with SpielVariablen;

package body LeseDiplomatie is

   function AktuellerZustand
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return DiplomatieDatentypen.Status_Untereinander_Enum
   is begin
      
      return SpielVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).AktuellerZustand;
      
   end AktuellerZustand;
   
   
   
   function AktuelleSympathie
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return DiplomatieDatentypen.Meinung
   is begin
      
      return SpielVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).AktuelleSympathieBewertung;
      
   end AktuelleSympathie;
   
   
   
   function ZeitSeitÄnderung
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return ZahlenDatentypen.EigenesNatural
   is begin
      
      return SpielVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern).ZeitSeitLetzterÄnderung;
      
   end ZeitSeitÄnderung;
   
   
   
   function GanzerEintrag
     (RasseEinsExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      RasseZweiExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return SpielRecords.DiplomatieRecord
   is begin
      
      return SpielVariablen.Diplomatie (RasseEinsExtern, RasseZweiExtern);
      
   end GanzerEintrag;

end LeseDiplomatie;
