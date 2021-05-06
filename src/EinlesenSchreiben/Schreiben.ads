pragma SPARK_Mode (On);

with Ada.Streams.Stream_IO;
use Ada.Streams.Stream_IO;

package Schreiben is

   procedure SchreibenStartAufruf;

   procedure TastenbelegungSchreiben;
   
private
   
   Korrekt : Boolean;

   EinstellungenDatei : File_Type;
   
   TastenbelegungSpeichern : File_Type;

   type StandardZeug is (Einstellungen, Werte, Sprachen);

   procedure WerteSchreiben;

   procedure EinstellungenSchreiben;

   function EinstellungenPrüfen
     return Boolean;

   function WertePrüfen
     return Boolean;

end Schreiben;
