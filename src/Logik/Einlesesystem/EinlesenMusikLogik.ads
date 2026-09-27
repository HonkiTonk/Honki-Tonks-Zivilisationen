private with Ada.Wide_Wide_Text_IO;
private with Ada.Strings.Wide_Wide_Unbounded;

private with Sf.Audio;

private with EingeleseneMusik;

package EinlesenMusikLogik is
   pragma Elaborate_Body;
   
   procedure EinlesenMusik;
   
private
   use Ada.Wide_Wide_Text_IO;
   use Ada.Strings.Wide_Wide_Unbounded;
   
   IntromusikAnfang : constant Positive := 1;
   IntromusikEnde : constant Positive := EingeleseneMusik.Intromusik'Length;
   SpielmusikAnfang : constant Positive := IntromusikEnde + 1;
   SpielmusikEnde : constant Positive := IntromusikEnde + EingeleseneMusik.Spielmusik'Length;
   ForschungsmusikAnfang : constant Positive := SpielmusikEnde + 1;
   ForschungsmusikEnde : constant Positive := SpielmusikEnde + EingeleseneMusik.Forschungsmusik'Length;
   
   AktuelleZeile : Positive;
   EinzulesendeZeile : Positive;
   
   Dateiname : Unbounded_Wide_Wide_String;
   GesamterPfad : Unbounded_Wide_Wide_String;
   
   DateiMusik : File_Type;
   
   
   
   function MusikFestlegen
     (MusicAccessExtern : in Sf.Audio.sfMusic_Ptr;
      MusikpfadExtern : in String)
      return Sf.Audio.sfMusic_Ptr
     with
       Pre => (
                 MusikpfadExtern'Length > 0
              );
      
end EinlesenMusikLogik;
