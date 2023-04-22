with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with SpeziesDatentypen;

package EinlesenSpeziestexteLogik is
   pragma Elaborate_Body;

   procedure SpeziestexteEinlesen;

private

   AktuelleZeile : Positive;
   Teilerrest : Natural;

   AktuelleSpezies : SpeziesDatentypen.Spezies_Verwendet_Enum;

   DateiEins : File_Type;
   DateiNameBeschreibung : File_Type;
   DateiStädtenamen : File_Type;
   DateiForschungen : File_Type;
   DateiEinheiten : File_Type;
   DateiGebäude : File_Type;

   Einspfad : Unbounded_Wide_Wide_String;
   Dateienpfad : Unbounded_Wide_Wide_String;

   procedure NameBeschreibung
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      DateinameExtern : in Wide_Wide_String);

   procedure Städtenamen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      DateinameExtern : in Wide_Wide_String);

   procedure Forschungen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      DateinameExtern : in Wide_Wide_String);

   procedure Einheiten
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      DateinameExtern : in Wide_Wide_String);

   procedure Gebäude
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      DateinameExtern : in Wide_Wide_String);

end EinlesenSpeziestexteLogik;
