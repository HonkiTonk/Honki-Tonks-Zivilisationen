private with Ada.Streams.Stream_IO;
private with Ada.Strings.Wide_Wide_Unbounded;

private with SystemDatentypenHTSEB;

private with SpeziesDatentypen;
private with ZahlenDatentypen;

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
   use type SpeziesDatentypen.Spieler_Enum;

   Spielstandart : SystemDatentypenHTSEB.Spielstand_Enum;

   AktuellerAutospeichernwert : ZahlenDatentypen.EigenesPositive;


   MaximalerAutospeichernwert : Natural;

   DateiSpeichern : File_Type;

   Spielstandname : Unbounded_Wide_Wide_String;
   Autospeichernname : Unbounded_Wide_Wide_String;



   function Spezieswerte
     (DateiSpeichernExtern : in File_Type)
      return Boolean;

   function NameAutoSpeichern
     return Unbounded_Wide_Wide_String;

end SpeichernLogik;
