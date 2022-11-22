with SpielVariablen;

package body LeseRassenbelegung is

   function Belegung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RassenDatentypen.Spieler_Enum
   is begin
      
      return SpielVariablen.Rassenbelegung (RasseExtern).Belegung;
      
   end Belegung;
   
   
   
   function Besiegt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      return SpielVariablen.Rassenbelegung (RasseExtern).Besiegt;
      
   end Besiegt;
   
   
   
   function GanzerEintrag
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return SpielRecords.RassenRecords
   is begin
      
      return SpielVariablen.Rassenbelegung (RasseExtern);
      
   end GanzerEintrag;
     

end LeseRassenbelegung;
