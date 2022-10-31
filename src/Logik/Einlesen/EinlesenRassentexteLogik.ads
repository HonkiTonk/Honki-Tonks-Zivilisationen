pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with RassenDatentypen;

package EinlesenRassentexteLogik is
   pragma Elaborate_Body;

   procedure RassentexteEinlesen;

private

   AktuelleZeile : Positive;

   DateiNull : File_Type;
   DateiUnternull : File_Type;
   DateiNameBeschreibung : File_Type;
   DateiStädtenamen : File_Type;
   DateiForschungen : File_Type;
   DateiEinheiten : File_Type;
   DateiGebäude : File_Type;

   type HauptdateiArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of Unbounded_Wide_Wide_String;
   Hauptdatei : HauptdateiArray;

   type RassendateienArray is array (1 .. 5) of Unbounded_Wide_Wide_String;
   Rassendateien : RassendateienArray;

   procedure NameBeschreibung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      DateinameExtern : in Wide_Wide_String);

   procedure Städtenamen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      DateinameExtern : in Wide_Wide_String);

   procedure Forschungen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      DateinameExtern : in Wide_Wide_String);

   procedure Einheiten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      DateinameExtern : in Wide_Wide_String);

   procedure Gebäude
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      DateinameExtern : in Wide_Wide_String);

end EinlesenRassentexteLogik;
