pragma SPARK_Mode (On);

with Ada.Wide_Wide_Text_IO;
use Ada.Wide_Wide_Text_IO;

package Schreiben is

   procedure SchreibenStartAufruf;
   
private
   
   Korrekt : Boolean;

   EinstellungenDatei : Ada.Wide_Wide_Text_IO.File_Type;

   type StandardZeug is (Einstellungen, Werte, Sprachen);

   procedure WerteSchreiben;
   procedure EinstellungenSchreiben;

   function EinstellungenPrüfen return Boolean;
   function WertePrüfen return Boolean;

   -- Hier Standard Zeug zum Schreiben in die Einstellungsdatei beim Erzeugen hinschreiben
   
   -- Hier Standard Zeug zum Schreiben in die Einstellungsdatei beim Erzeugen hinschreiben

end Schreiben;
