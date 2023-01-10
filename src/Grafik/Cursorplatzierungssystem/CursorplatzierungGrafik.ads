private with Sf.System.Vector2;

with SpeziesDatentypen;

private with KartenDatentypen;
private with KartenRecords;

with LeseSpeziesbelegung;

package CursorplatzierungGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;
   
   procedure Weltkarte
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   Sichtbereich : KartenDatentypen.KartenfeldPositiv;
      
   Kartenänderung : KartenRecords.YXAchsenKartenfeldRecord;
   
   Mausposition : Sf.System.Vector2.sfVector2f;
   
   KartenWert : KartenRecords.AchsenKartenfeldNaturalRecord;

end CursorplatzierungGrafik;
