pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

private with KartenDatentypen;
private with KartenRecords;

package CursorPlatzierenSFML is
   
   procedure CursorPlatzierenKarteSFML
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
   procedure CursorPlatzierenStadtSFML
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.RassenImSpiel (RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   YMultiplikator : Float;
   XMultiplikator : Float;
   
   Kartenänderung : KartenRecords.YXAchsenKartenfeldRecord;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   SichtbereichAnfangEnde : KartenDatentypen.SichtbereichAnfangEndeArray;
   
   Mausposition : Sf.System.Vector2.sfVector2f;

end CursorPlatzierenSFML;
