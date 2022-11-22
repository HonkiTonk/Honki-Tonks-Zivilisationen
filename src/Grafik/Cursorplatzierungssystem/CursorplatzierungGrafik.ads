private with Sf.System.Vector2;

with RassenDatentypen;

private with KartenDatentypen;
private with KartenRecords;

with LeseRassenbelegung;

package CursorplatzierungGrafik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;
   
   procedure Weltkarte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   Sichtbereich : KartenDatentypen.KartenfeldPositiv;
      
   Kartenänderung : KartenRecords.YXAchsenKartenfeldRecord;
   
   Mausposition : Sf.System.Vector2.sfVector2f;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;

end CursorplatzierungGrafik;
