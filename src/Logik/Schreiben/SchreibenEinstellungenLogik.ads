with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

package SchreibenEinstellungenLogik is
   pragma Elaborate_Body;

   procedure Nutzereinstellungen;
   procedure Grafikeinstellungen;
   procedure Soundeinstellungen;
   procedure TastenbelegungSchreiben;
   procedure SonstigeEinstellungenSpeichern;

private

   DateiNutzereinstellungen : File_Type;
   DateiGrafikeinstellungen : File_Type;
   DateiSoundeinstellungen : File_Type;
   DateiTastenbelegung : File_Type;
   DateiSonstigeEinstellungen : File_Type;

end SchreibenEinstellungenLogik;
