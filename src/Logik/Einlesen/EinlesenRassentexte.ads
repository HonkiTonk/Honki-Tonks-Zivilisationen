pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

private with Ada.Wide_Wide_Text_IO;
private with Ada.Strings.Wide_Wide_Unbounded;

private with ZahlenDatentypen;
private with RassenDatentypen;

package EinlesenRassentexte is

   procedure RassentexteEinlesen;

private

   AktuelleZeile : ZahlenDatentypen.EigenesPositive;

   DateiNull : Ada.Wide_Wide_Text_IO.File_Type;
   DateiUnternull : Ada.Wide_Wide_Text_IO.File_Type;
   DateiNameBeschreibung : Ada.Wide_Wide_Text_IO.File_Type;
   DateiStädtenamen : Ada.Wide_Wide_Text_IO.File_Type;
   DateiForschungen : Ada.Wide_Wide_Text_IO.File_Type;
   DateiEinheiten : Ada.Wide_Wide_Text_IO.File_Type;
   DateiGebäude : Ada.Wide_Wide_Text_IO.File_Type;

   type HauptdateiArray is array (RassenDatentypen.Rassen_Verwendet_Enum'Range) of Ada.Strings.Wide_Wide_Unbounded.Unbounded_Wide_Wide_String;
   Hauptdatei : HauptdateiArray;

   type RassendateienArray is array (1 .. 5) of Ada.Strings.Wide_Wide_Unbounded.Unbounded_Wide_Wide_String;
   Rassendateien : RassendateienArray;


   procedure NameBeschreibung
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

   procedure Städtenamen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

   procedure Forschungen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

   procedure Einheiten
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

   procedure Gebäude
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum);

end EinlesenRassentexte;
