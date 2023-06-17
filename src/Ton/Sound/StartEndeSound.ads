with TonDatentypen;

package StartEndeSound is
   pragma Elaborate_Body;

   procedure Abspielen
     (SoundExtern : in TonDatentypen.Sound_Vorhanden_Enum);

   procedure Stoppen
     (SoundExtern : in TonDatentypen.Sound_Vorhanden_Enum);

   procedure TaskStoppen;
   procedure Entfernen;

end StartEndeSound;
