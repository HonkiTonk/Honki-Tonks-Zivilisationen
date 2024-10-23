private with Ada.Streams.Stream_IO;

private with ZahlenDatentypen;

package EinlesenSpielendeEinstellungenLogik is
   pragma Elaborate_Body;

   procedure SpielendeEinstellungen;
   
private
   use Ada.Streams.Stream_IO;
   
   Nullwert : Boolean;
      
   DateiSonstigeEinstellungen : File_Type;
   
   Autospeichernwert : ZahlenDatentypen.EigenesPositive;
   
   
   
   function SpielendeEinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;

end EinlesenSpielendeEinstellungenLogik;
