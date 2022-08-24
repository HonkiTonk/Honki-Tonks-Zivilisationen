pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with StadtDatentypen;

package GebaeudebeschreibungenSFML is

   function BeschreibungKurz
     (IDExtern : in StadtDatentypen.GebäudeIDMitNullwert)
      return Wide_Wide_String;
   
   function BeschreibungLang
     (IDExtern : in StadtDatentypen.GebäudeIDMitNullwert)
      return Wide_Wide_String;
   
private
      
   BeschreibungText : Unbounded_Wide_Wide_String;

end GebaeudebeschreibungenSFML;
