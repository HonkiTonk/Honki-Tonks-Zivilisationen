with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

private with ZahlenDatentypen;

package EinlesenSonstigeEinstellungenLogik is
   pragma Elaborate_Body;

   procedure SonstigeEinstellungen;
   
private
   
   Nullwert : Boolean;
      
   DateiSonstigeEinstellungen : File_Type;
   
   Autospeichernwert : ZahlenDatentypen.EigenesPositive;
   
   
   
   function SonstigeEinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;

end EinlesenSonstigeEinstellungenLogik;
