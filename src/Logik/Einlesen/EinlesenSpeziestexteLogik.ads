with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with SpeziesDatentypen;

package EinlesenSpeziestexteLogik is
   pragma Elaborate_Body;

   procedure SpeziestexteEinlesen;

private

   AktuelleZeile : Positive;

   DateiNull : File_Type;
   DateiUnternull : File_Type;
   DateiNameBeschreibung : File_Type;
   DateiStädtenamen : File_Type;
   DateiForschungen : File_Type;
   DateiEinheiten : File_Type;
   DateiGebäude : File_Type;

   Sprache : Unbounded_Wide_Wide_String;

   type HauptdateiArray is array (SpeziesDatentypen.Spezies_Verwendet_Enum'Range) of Unbounded_Wide_Wide_String;
   Hauptdatei : HauptdateiArray;

   type SpeziesdateienArray is array (1 .. 5) of Unbounded_Wide_Wide_String;
   Speziesdateien : SpeziesdateienArray;

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
