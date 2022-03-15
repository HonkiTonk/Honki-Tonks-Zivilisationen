pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen;

package InteraktionSoundtask is
   
   procedure AktuellenSoundÄndern
     (SoundExtern : in SystemDatentypen.Sound_Aktuelle_Auswahl_Enum);
   
   
   
   function AktuellenSoundAbfragen
     return SystemDatentypen.Sound_Aktuelle_Auswahl_Enum;
   
private

   AktuellerSound : SystemDatentypen.Sound_Aktuelle_Auswahl_Enum := SystemDatentypen.Sound_SFML;

end InteraktionSoundtask;
