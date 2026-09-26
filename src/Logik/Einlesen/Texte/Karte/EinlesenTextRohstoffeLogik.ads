with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

private with Ada.Strings.Wide_Wide_Unbounded;

private with Kartentexte;

package EinlesenTextRohstoffeLogik is
   pragma Elaborate_Body;

   procedure Rohstoffe
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);
   
private
   use Ada.Strings.Wide_Wide_Unbounded;
   
   Rohstoffnamen : constant Positive := Kartentexte.Rohstoffe'Last;
   
   EinzulesendeZeile : Positive;
   AktuelleZeile : Positive;
   
   Zwischenspeicher : Unbounded_Wide_Wide_String;

end EinlesenTextRohstoffeLogik;
