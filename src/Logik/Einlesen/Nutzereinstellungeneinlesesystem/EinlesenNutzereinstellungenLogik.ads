with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with ZahlenDatentypen;

package EinlesenNutzereinstellungenLogik is
   pragma Elaborate_Body;

   procedure Nutzereinstellungen;
   
private
   
   Nullwert : Boolean;
   
   SicherheitsfragenAnzeigen : Boolean;
   
   Dezimaltrennzeichen : Wide_Wide_Character;
   
   AnzahlAutospeichern : ZahlenDatentypen.EigenesNatural;
   
   RundenAutospeichern : ZahlenDatentypen.EigenesPositive;
   
   Sprache : Unbounded_Wide_Wide_String;
   Texturen : Unbounded_Wide_Wide_String;
   
   DateiNutzereinstellungen : File_Type;
   
   
   
   function NutzereinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;

end EinlesenNutzereinstellungenLogik;
