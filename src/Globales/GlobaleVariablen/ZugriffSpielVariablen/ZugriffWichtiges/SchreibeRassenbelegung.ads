with RassenDatentypen;
with SpielRecords;

package SchreibeRassenbelegung is

   procedure Belegung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      BelegungExtern : in RassenDatentypen.Spieler_Enum);
   
   procedure Besiegt
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);
   
   procedure Standardeinstellungen;
   
   procedure GanzerEintrag
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      EintragExtern : in SpielRecords.RassenRecords);

end SchreibeRassenbelegung;
