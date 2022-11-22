with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with Sf.System.Vector2;

with RassenDatentypen;
with EinheitenDatentypen;

private with GrafikRecordKonstanten;

with LeseRassenbelegung;

package BauauswahlEinheitenGrafik is
   pragma Elaborate_Body;
   use type RassenDatentypen.Spieler_Enum;

   procedure Einheiteninformationen
     (AuswahlExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );
   
private
   
   Transportgröße : EinheitenDatentypen.Transport_Enum;

   Transportkapazität : EinheitenDatentypen.Transportplätze;
   
   type EinheitentexteArray is array (1 .. 11) of Unbounded_Wide_Wide_String;
   Einheitentexte : EinheitentexteArray;

   Textbreite : Float;
   
   ViewflächeInformationen : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   ViewflächeBeschreibung : Sf.System.Vector2.sfVector2f := GrafikRecordKonstanten.StartgrößeView;
   Textposition : Sf.System.Vector2.sfVector2f;

   procedure Einheitenbeschreibung
     (AuswahlExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      ViewnummerExtern : in Positive;
      RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) = RassenDatentypen.Mensch_Spieler_Enum
              );

end BauauswahlEinheitenGrafik;
