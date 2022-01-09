pragma SPARK_Mode (On);

package body InteraktionSoundtask is

   procedure AktuelleMusikÄndern
     (MusikExtern : in SystemDatentypen.Musik_Aktuelle_Auswahl_Enum)
   is begin
      
      AktuelleMusik := MusikExtern;
      
   end AktuelleMusikÄndern;
   
   
   
   function AktuelleMusikAbfragen
     return SystemDatentypen.Musik_Aktuelle_Auswahl_Enum
   is begin
      
      return AktuelleMusik;
      
   end AktuelleMusikAbfragen;

end InteraktionSoundtask;
