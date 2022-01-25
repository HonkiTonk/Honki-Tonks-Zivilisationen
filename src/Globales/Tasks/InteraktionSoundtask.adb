pragma SPARK_Mode (On);

package body InteraktionSoundtask is

   procedure AktuellenSoundÄndern
     (SoundExtern : in SystemDatentypen.Sound_Aktuelle_Auswahl_Enum)
   is begin
      
      AktuellerSound := SoundExtern;
      
   end AktuellenSoundÄndern;
   
   
   
   function AktuellenSoundAbfragen
     return SystemDatentypen.Sound_Aktuelle_Auswahl_Enum
   is begin
      
      return AktuellerSound;
      
   end AktuellenSoundAbfragen;

end InteraktionSoundtask;
