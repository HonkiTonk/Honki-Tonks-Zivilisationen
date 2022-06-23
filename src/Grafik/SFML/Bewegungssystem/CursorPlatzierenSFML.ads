pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Sf.System.Vector2;

with RassenDatentypen; use RassenDatentypen;
with SonstigeVariablen;
with KartenDatentypen;
with KartenRecords;

package CursorPlatzierenSFML is
   
   procedure CursorPlatzierenKarteSFML
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   procedure CursorPlatzierenStadtSFML
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SonstigeVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   SichtbereichAnfangEnde : KartenDatentypen.SichtbereichAnfangEndeArray;
   
   YMultiplikator : Float;
   XMultiplikator : Float;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   MausPosition : Sf.System.Vector2.sfVector2i;

end CursorPlatzierenSFML;
