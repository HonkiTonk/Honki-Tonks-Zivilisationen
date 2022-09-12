pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Sf.System.Vector2;

with RassenDatentypen; use RassenDatentypen;
with SpielVariablen;

private with KartenDatentypen;
private with KartenRecords;

package CursorplatzierungGrafik is
   
   procedure Weltkarte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 SpielVariablen.Rassenbelegung (RasseExtern).Belegung = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
      
   Kartenänderung : KartenRecords.YXAchsenKartenfeldRecord;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;
   
   SichtbereichAnfangEnde : KartenDatentypen.SichtbereichAnfangEndeArray;
   
   Mausposition : Sf.System.Vector2.sfVector2f;

end CursorplatzierungGrafik;
