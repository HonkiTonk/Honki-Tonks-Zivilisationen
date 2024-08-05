with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

package SchreibenDatenbankenLogik is
   pragma Elaborate_Body;

   procedure SchreibenAlleDatenbanken;
   procedure SchreibenEinheitenDatenbank;
   procedure SchreibenForschungenDatenbank;
   procedure SchreibenGebäudeDatenbank;
   procedure SchreibenKartenDatenbanken;
   procedure SchreibenVerbesserungenDatenbank;
   procedure SchreibenSpeziesDatenbank;
   procedure SchreibenEffekteDatenbank;

private

   -- Hier habe ich nur eine Variablen für die verschiedenen Datenbanken, beim Schreiben der Einstellungen aber nicht. Mal vereinheitlichen. äöü
   DatenbankSpeichern : File_Type;

end SchreibenDatenbankenLogik;
