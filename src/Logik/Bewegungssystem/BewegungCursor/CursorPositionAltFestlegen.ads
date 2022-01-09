pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with KartenRecords;
with GlobaleVariablen;

package CursorPositionAltFestlegen is

   procedure CursorPositionAltFestlegen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Spieler_Mensch);
   
private
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;

   procedure AlteEAchseFestlegen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure AlteYAchseFestlegenKonsole
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure AlteXAchseFestlegenKonsole
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure AlteYAchseFestlegenSFML
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

   procedure AlteXAchseFestlegenSFML
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

end CursorPositionAltFestlegen;
