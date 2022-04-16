pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

package body InteraktionSoundtask is

   procedure AktuellenSoundÄndern
     (SoundExtern : in TonDatentypen.Sound_Aktuelle_Auswahl_Enum)
   is begin
      
      AktuellerSound := SoundExtern;
      
   end AktuellenSoundÄndern;
   
   
   
   function AktuellenSoundAbfragen
     return TonDatentypen.Sound_Aktuelle_Auswahl_Enum
   is begin
      
      return AktuellerSound;
      
   end AktuellenSoundAbfragen;

end InteraktionSoundtask;
