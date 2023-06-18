with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

package SchreibenEinstellungenLogik is
   pragma Elaborate_Body;

   procedure Nutzereinstellungen;
   procedure Grafikeinstellungen;
   procedure Toneinstellungen;
   procedure Tastatureinstellungen;
   procedure SonstigeEinstellungen;

private

   DateiNutzereinstellungen : File_Type;
   DateiGrafikeinstellungen : File_Type;
   DateiToneinstellungen : File_Type;
   DateiTastatureinstellungen : File_Type;
   DateiSonstigeEinstellungen : File_Type;

end SchreibenEinstellungenLogik;
