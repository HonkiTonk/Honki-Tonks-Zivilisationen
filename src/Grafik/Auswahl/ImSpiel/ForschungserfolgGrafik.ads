private with Sf.System.Vector2;

with RassenDatentypen;

private with GrafikRecordKonstanten;
private with ForschungenDatentypen;

with LeseRassenbelegung;

package ForschungserfolgGrafik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure Forschungserfolg
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      AuswahlExtern : in Natural)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
               and
                 AuswahlExtern in 1 .. 2
              );
   
private
   
   Forschungprojekt : ForschungenDatentypen.ForschungID;
   
   Textbreite : Float;
   
   Viewfläche : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   Textposition : Sf.System.Vector2.sfVector2f;
   
   
   
   function Forschung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      TechnologieExtern : in ForschungenDatentypen.ForschungID;
      ViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
               and
                 ViewbreiteExtern >= 0.00
              );
   
   function Infotext
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      TechnologieExtern : in ForschungenDatentypen.ForschungID;
      ViewbreiteExtern : in Float)
      return Sf.System.Vector2.sfVector2f
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
               and
                 ViewbreiteExtern >= 0.00
              );

end ForschungserfolgGrafik;
