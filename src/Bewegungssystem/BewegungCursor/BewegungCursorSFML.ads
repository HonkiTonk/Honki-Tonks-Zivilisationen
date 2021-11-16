pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with KartenDatentypen;
with KartenRecords;

package BewegungCursorSFML is
   
   procedure CursorPlatzierenKarteSFML
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Spieler_Mensch);
   
   procedure CursorPlatzierenStadtSFML
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Spieler_Mensch);
   
private
   
   SichtbereichAnfangEnde : KartenDatentypen.SichtbereichAnfangEndeArray;
   
   YMultiplikator : Float;
   XMultiplikator : Float;
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;

end BewegungCursorSFML;
