with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with ZahlenDatentypen;

package EinlesenNutzereinstellungenLogik is
   pragma Elaborate_Body;

   procedure Nutzereinstellungen;
   
private
   
   DateiNutzereinstellungen : File_Type;
   
   Nullwert : Boolean;
   
   SicherheitsfragenAnzeigen : Boolean;
   
   Sprache : Unbounded_Wide_Wide_String;
   
   AnzahlAutospeichern : ZahlenDatentypen.EigenesNatural;
   
   RundenAutospeichern : ZahlenDatentypen.EigenesPositive;
   
   Dezimaltrennzeichen : Wide_Wide_Character;
   
   
   
   function NutzereinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;

end EinlesenNutzereinstellungenLogik;
