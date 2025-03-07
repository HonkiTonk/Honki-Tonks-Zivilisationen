private with Ada.Strings.Wide_Wide_Unbounded;

private with SystemRecordsHTSEB;

with RueckgabeDatentypen;

package OptionenSoundLogik is
   pragma Elaborate_Body;

   function OptionenSound
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private
   use Ada.Strings.Wide_Wide_Unbounded;

   AuswahlWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   GewählterTon : Unbounded_Wide_Wide_String;

   NeueLaustärke : SystemRecordsHTSEB.ZahlenEingabeRecord;

   procedure Soundlautstärke;
   procedure Musiklautstärke;
   procedure MusikWechseln;
   procedure SoundWechseln;

end OptionenSoundLogik;
