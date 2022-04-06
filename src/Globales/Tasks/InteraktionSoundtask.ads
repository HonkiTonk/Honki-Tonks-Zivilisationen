pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with GrafikTonDatentypen;

package InteraktionSoundtask is
   
   procedure AktuellenSoundÄndern
     (SoundExtern : in GrafikTonDatentypen.Sound_Aktuelle_Auswahl_Enum);
   
   
   
   function AktuellenSoundAbfragen
     return GrafikTonDatentypen.Sound_Aktuelle_Auswahl_Enum;
   
private

   AktuellerSound : GrafikTonDatentypen.Sound_Aktuelle_Auswahl_Enum := GrafikTonDatentypen.Sound_SFML_Enum;

end InteraktionSoundtask;
