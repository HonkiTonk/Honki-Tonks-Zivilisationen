private with Ada.Strings.Wide_Wide_Unbounded;
private with Ada.Streams.Stream_IO;

private with ZahlenDatentypen;

package EinlesenNutzereinstellungenLogik is
   pragma Elaborate_Body;

   procedure Nutzereinstellungen;
   
private
   use Ada.Strings.Wide_Wide_Unbounded;
   use Ada.Streams.Stream_IO;
   
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
