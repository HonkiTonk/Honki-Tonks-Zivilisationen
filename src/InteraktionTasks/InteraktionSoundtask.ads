pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TonDatentypen;

package InteraktionSoundtask is

   AktuellerSound : TonDatentypen.Sound_Aktuelle_Auswahl_Enum := TonDatentypen.Sound_SFML_Enum;

end InteraktionSoundtask;
