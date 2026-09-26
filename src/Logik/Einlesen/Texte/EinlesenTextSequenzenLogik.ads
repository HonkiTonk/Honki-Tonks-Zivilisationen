with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

private with Ada.Strings.Wide_Wide_Unbounded;

private with Sequenzentexte;

package EinlesenTextSequenzenLogik is
   pragma Elaborate_Body;
   
   procedure Sequenzen
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);

private
   use Ada.Strings.Wide_Wide_Unbounded;
   
   Intro : constant Positive := Sequenzentexte.Intro'Last;
   Outro : constant Positive := Intro + Sequenzentexte.Outro'Last;
   
   EinzulesendeZeile : Positive;
   AktuelleZeile : Positive;
   
   Zwischenspeicher : Unbounded_Wide_Wide_String;

end EinlesenTextSequenzenLogik;
