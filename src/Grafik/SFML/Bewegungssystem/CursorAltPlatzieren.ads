pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with RassenDatentypen; use RassenDatentypen;
with KartenRecords;
with SonstigeVariablen;

package CursorAltPlatzieren is

   procedure CursorAltPlatzieren
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Spieler_Mensch_Enum);
   
private
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;

   procedure AlteEAchseFestlegen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

   procedure AlteYAchseFestlegenKonsole
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

   procedure AlteXAchseFestlegenKonsole
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

   procedure AlteYAchseFestlegenSFML
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

   procedure AlteXAchseFestlegenSFML
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

end CursorAltPlatzieren;
