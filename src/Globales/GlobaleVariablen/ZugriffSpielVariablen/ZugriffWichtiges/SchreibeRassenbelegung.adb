with WichtigesRecordKonstanten;
with SpielVariablen;

package body SchreibeRassenbelegung is

   procedure Belegung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      BelegungExtern : in RassenDatentypen.Spieler_Enum)
   is begin
      
      SpielVariablen.Rassenbelegung (RasseExtern).Belegung := BelegungExtern;
      
   end Belegung;
   
   
   
   procedure Besiegt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      SpielVariablen.Rassenbelegung (RasseExtern).Besiegt := True;
      
   end Besiegt;
   
   
   
   procedure Standardeinstellungen
   is begin
      
      SpielVariablen.Rassenbelegung := (others => WichtigesRecordKonstanten.LeerRassenbelegung);
      
   end Standardeinstellungen;
   
   
   
   procedure GanzerEintrag
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EintragExtern : in SpielRecords.RassenRecords)
   is begin
      
      SpielVariablen.Rassenbelegung (RasseExtern) := EintragExtern;
      
   end GanzerEintrag;

end SchreibeRassenbelegung;
