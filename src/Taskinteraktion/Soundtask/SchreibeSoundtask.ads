with TonDatentypen;

package SchreibeSoundtask is

   procedure SoundStarten
     (SoundExtern : in TonDatentypen.Sound_Aktuelle_Auswahl_Enum);
   
   procedure SoundStoppen
     (SoundExtern : in TonDatentypen.Sound_Aktuelle_Auswahl_Enum);

end SchreibeSoundtask;
