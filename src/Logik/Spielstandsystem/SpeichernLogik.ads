with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

private with RassenDatentypen;

private with LeseRassenbelegung;

package SpeichernLogik is
   pragma Elaborate_Body;

   procedure Speichern
     (AutospeichernExtern : in Boolean);

   procedure AutoSpeichern;

private
   use type RassenDatentypen.Spieler_Enum;

   AutospeichernWert : Positive := 1;

   DateiSpeichern : File_Type;

   Spielstandname : Unbounded_Wide_Wide_String;
   Autospeichernname : Unbounded_Wide_Wide_String;

   procedure Karte
     (DateiSpeichernExtern : in File_Type;
      AutospeichernExtern : in Boolean);

   procedure Allgemeines
     (DateiSpeichernExtern : in File_Type);

   procedure RassenwerteSpeichern
     (DateiSpeichernExtern : in File_Type);

   procedure FortschrittErhöhen
     (AutospeichernExtern : in Boolean);

   procedure Rassenwerte
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      DateiSpeichernExtern : in File_Type)
     with
       Pre => (
                 LeseRassenbelegung.Belegung (RasseExtern => RasseExtern) /= RassenDatentypen.Leer_Spieler_Enum
              );



   function NameAutoSpeichern
     return Unbounded_Wide_Wide_String;

end SpeichernLogik;
