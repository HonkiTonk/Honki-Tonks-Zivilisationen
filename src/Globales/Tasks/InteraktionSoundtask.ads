pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TonDatentypen;

package InteraktionSoundtask is
   
   procedure AktuellenSoundÄndern
     (SoundExtern : in TonDatentypen.Sound_Aktuelle_Auswahl_Enum);
   
   
   
   function AktuellenSoundAbfragen
     return TonDatentypen.Sound_Aktuelle_Auswahl_Enum;
   
private

   AktuellerSound : TonDatentypen.Sound_Aktuelle_Auswahl_Enum := TonDatentypen.Sound_SFML_Enum;

end InteraktionSoundtask;
