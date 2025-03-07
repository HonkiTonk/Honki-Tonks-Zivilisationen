private with Sf.System.Vector2;

private with ArraysHTSEB;

with SpeziesDatentypen;
with EinheitenDatentypen;

private with GrafikRecordKonstanten;

with LeseSpeziesbelegung;

package BauauswahlEinheitenGrafik is
   pragma Elaborate_Body;
   use type SpeziesDatentypen.Spieler_Enum;

   procedure Einheiteninformationen
     (AuswahlExtern : in EinheitenDatentypen.EinheitenID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   Transportgröße : EinheitenDatentypen.Transport_Enum;

   Transportkapazität : EinheitenDatentypen.Transportplätze;
   
   Einheitentexte : ArraysHTSEB.AllgemeinesTextArray (1 .. 11);

   YPosition : Float;
   
   ViewflächeInformationen : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   ViewflächeBeschreibung : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartView;
   
   procedure Einheitenbeschreibung
     (AuswahlExtern : in EinheitenDatentypen.EinheitenID;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
     with
       Pre => (
                 LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesExtern) = SpeziesDatentypen.Mensch_Spieler_Enum
              );

end BauauswahlEinheitenGrafik;
