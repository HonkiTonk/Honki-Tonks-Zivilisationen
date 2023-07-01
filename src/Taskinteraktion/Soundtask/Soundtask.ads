with TonDatentypen;
with TaskRecords;

package Soundtask is
   pragma Elaborate_Body;

   Sound : TaskRecords.SoundRecord := (
                                       Starten => TonDatentypen.Sound_Pause_Enum,
                                       Stoppen => TonDatentypen.Sound_Pause_Enum
                                      );

end Soundtask;
