with RassenDatentypen;
with SpielRecords;

package LeseRassenbelegung is
   pragma Elaborate_Body;

   function Belegung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return RassenDatentypen.Spieler_Enum;
   
   function Besiegt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return Boolean;
   
   function GanzerEintrag
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
      return SpielRecords.RassenRecords;
   
   function GanzesArray
     return SpielRecords.RassenbelegungArray;

end LeseRassenbelegung;
