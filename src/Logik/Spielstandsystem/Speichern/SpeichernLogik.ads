private with Ada.Streams.Stream_IO;
private with Ada.Strings.Wide_Wide_Unbounded;

private with SystemDatentypenHTSEB;

package SpeichernLogik is
   pragma Elaborate_Body;

   procedure Speichern
     (AutospeichernExtern : in Boolean;
      NotfallspeichernExtern : in Boolean)
     with
       Pre => (
                 if NotfallspeichernExtern then AutospeichernExtern
              );

   procedure AutoSpeichern;

private
   use Ada.Streams.Stream_IO;
   use Ada.Strings.Wide_Wide_Unbounded;

   FehlerAufgetreten : Boolean;

   Spielstandart : SystemDatentypenHTSEB.Spielstand_Enum;

   AktuellerAutospeichernwert : SystemDatentypenHTSEB.EigenesPositive;

   MaximalerAutospeichernwert : Natural;

   DateiSpeichern : File_Type;

   Spielstandname : Unbounded_Wide_Wide_String;
   Autospeichernname : Unbounded_Wide_Wide_String;



   function NameAutoSpeichern
     return Unbounded_Wide_Wide_String;

end SpeichernLogik;
