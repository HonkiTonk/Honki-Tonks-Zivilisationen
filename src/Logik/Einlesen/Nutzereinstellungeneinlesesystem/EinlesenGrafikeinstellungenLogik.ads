with Ada.Streams.Stream_IO; use Ada.Streams.Stream_IO;

package EinlesenGrafikeinstellungenLogik is
   pragma Elaborate_Body;

   procedure Grafikeinstellungen;
   
private
   
   Nullwert : Boolean;
   
   DateiGrafikeinstellungen : File_Type;
   
   function GrafikeinstellungenDurchgehen
     (LadenPrüfenExtern : in Boolean;
      DateiLadenExtern : in File_Type)
      return Boolean;

end EinlesenGrafikeinstellungenLogik;
