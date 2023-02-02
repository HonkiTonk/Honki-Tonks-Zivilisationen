private with Sf.System.Vector2;

with SpeziesDatentypen;

private with GrafikRecordKonstanten;
private with ForschungenDatentypen;

with LeseSpeziesbelegung;

package ForschungserfolgGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure Forschungserfolg
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      AuswahlExtern : in Natural)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 AuswahlExtern in 1 .. 2
              );
   
private
   
   Forschungprojekt : ForschungenDatentypen.ForschungID;
   
   Textbreite : Float;
   
   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Textposition : Sf.System.Vector2.sfVector2f;
   
   
   
   function Forschung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      TechnologieExtern : in ForschungenDatentypen.ForschungID;
      ViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 ViewbreiteExtern >= 0.00
              );
   
   function Infotext
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      TechnologieExtern : in ForschungenDatentypen.ForschungID;
      ViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
               and
                 ViewbreiteExtern >= 0.00
              );

end ForschungserfolgGrafik;
