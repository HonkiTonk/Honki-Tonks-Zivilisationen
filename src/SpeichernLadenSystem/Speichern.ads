pragma SPARK_Mode (On);

with Ada.Streams.Stream_IO;
use Ada.Streams.Stream_IO;

package Speichern is

   procedure SpeichernNeu
     (AutospeichernExtern : in Boolean);

   procedure AutoSpeichern;

private

   AutospeichernWert : Positive := 1;

   DateiSpeichernNeu : File_Type;

   procedure SonstigesSpeichern;
   procedure KarteSpeichern;
   procedure RassenGrenzenSpeichern;
   procedure EinheitenSpeichern;
   procedure StädteSpeichern;
   procedure WichtigesSpeichern;
   procedure DiplomatieSpeichern;
   procedure CursorSpeichern;
   procedure NameAutoSpeichern;



   function SpielstandNameFestlegen
     (AutospeichernExtern : in Boolean)
      return Boolean;

   function NameNutzer
     return Boolean;

end Speichern;
