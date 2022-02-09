pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with KartenRecords;
with GlobaleVariablen;
with SystemKonstanten;

package CursorAltPlatzieren is

   procedure CursorAltPlatzieren
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemKonstanten.SpielerMenschKonstante);
   
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

end CursorAltPlatzieren;
