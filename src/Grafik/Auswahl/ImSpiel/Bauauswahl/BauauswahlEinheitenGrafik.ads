private with Sf.System.Vector2;

with SpeziesDatentypen;
with EinheitenDatentypen;

private with GrafikRecordKonstanten;
private with TextArrays;

with LeseSpeziesbelegung;

package BauauswahlEinheitenGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure Einheiteninformationen
     (AuswahlExtern : in EinheitenDatentypen.EinheitenID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   Transportgröße : EinheitenDatentypen.Transport_Enum;

   Transportkapazität : EinheitenDatentypen.Transportplätze;
   
   Einheitentexte : TextArrays.AllgemeinesTextArray (1 .. 11);

   Textbreite : Float;
   
   ViewflächeInformationen : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   ViewflächeBeschreibung : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   Textposition : Sf.System.Vector2.sfVector2f;

   procedure Einheitenbeschreibung
     (AuswahlExtern : in EinheitenDatentypen.EinheitenID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

end BauauswahlEinheitenGrafik;
