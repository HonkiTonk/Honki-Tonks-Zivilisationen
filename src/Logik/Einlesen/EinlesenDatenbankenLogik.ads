with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

package EinlesenDatenbankenLogik is
   pragma Elaborate_Body;
   
   procedure EinlesenAlleDatenbanken;
   procedure EinlesenEinheitenDatenbank;
   procedure EinlesenForschungenDatenbank;
   procedure EinlesenGebäudeDatenbank;
   procedure EinlesenKartengrundDatenbank;
   procedure EinlesenVerbesserungenDatenbank;
   procedure EinlesenSpeziesDatenbank;
   
private
   
   DatenbankEinlesen : File_Type;

end EinlesenDatenbankenLogik;
