with Ada.Wide_Wide_Text_IO; use Ada.Wide_Wide_Text_IO;

private with Ada.Strings.Wide_Wide_Unbounded;

private with Spieltexte;

package EinlesenTextAllgemeinesLogik is
   pragma Elaborate_Body;
   
   procedure AllgemeineTexte
     (DateiExtern : in File_Type;
      EinsprachigExtern : in Boolean);

private
   use Ada.Strings.Wide_Wide_Unbounded;
   
   Fragen : constant Positive := Spieltexte.Fragen'Last;
   Meldungen : constant Positive := Fragen + Spieltexte.Meldungen'Last;
   Würdigungen : constant Positive := Meldungen + Spieltexte.Würdigungen'Last;
   Zeug : constant Positive := Würdigungen + Spieltexte.Zeug'Last;
   Stadtbefehle : constant Positive := Zeug + Spieltexte.Stadtbefehle'Last;
   Ladezeiten : constant Positive := Stadtbefehle + Spieltexte.Ladezeiten'Last;
   Beschäftigungen : constant Positive := Ladezeiten + Spieltexte.Beschäftigungen'Last;
   
   EinzulesendeZeile : Positive;
   AktuelleZeile : Positive;
   
   Zwischenspeicher : Unbounded_Wide_Wide_String;

end EinlesenTextAllgemeinesLogik;
