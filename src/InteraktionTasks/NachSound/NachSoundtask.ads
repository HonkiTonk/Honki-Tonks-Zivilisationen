pragma Warnings (Off, "*array aggregate*");

with TonDatentypen;

package NachSoundtask is
   pragma Preelaborate;

   AktuellerSound : TonDatentypen.Sound_Aktuelle_Auswahl_Enum := TonDatentypen.Sound_Pause_Enum;

end NachSoundtask;
