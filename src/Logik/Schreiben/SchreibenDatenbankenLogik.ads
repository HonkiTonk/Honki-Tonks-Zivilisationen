private with Ada.Streams.Stream_IO;

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
   use Ada.Streams.Stream_IO;

   DateiEinheitendatenbank : File_Type;
   DateiForschungendatenbank : File_Type;
   DateiGebäudedatenbank : File_Type;
   DateiKartendatenbank : File_Type;
   DateiVerbesserungendatenbank : File_Type;
   DateiSpeziesdatenbank : File_Type;
   DateiEffektedatenbank : File_Type;

end SchreibenDatenbankenLogik;
