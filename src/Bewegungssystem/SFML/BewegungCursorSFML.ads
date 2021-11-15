pragma SPARK_Mode (On);

with SystemDatentypen; use SystemDatentypen;
with GlobaleVariablen;
with KartenDatentypen;
with KartenRecords;

package BewegungCursorSFML is
   
   procedure CursorPlatzierenSFML
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
     with
       Pre =>
         (GlobaleVariablen.RassenImSpiel (RasseExtern) = SystemDatentypen.Spieler_Mensch);
   
private
   
   YSichtAnfang : KartenDatentypen.Kartenfeld;
   YSichtEnde : KartenDatentypen.Kartenfeld;
   XSichtAnfang : KartenDatentypen.Kartenfeld;
   XSichtEnde : KartenDatentypen.Kartenfeld;
   
   YMultiplikator : Float;
   XMultiplikator : Float;
   
   KartenWert : KartenRecords.AchsenKartenfeldPositivRecord;
   
   procedure SichtbereichFestlegen
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum);

end BewegungCursorSFML;
