private with SystemRecordsHTSEB;

with RueckgabeDatentypen;

package OptionenSoundLogik is
   pragma Elaborate_Body;

   function OptionenSound
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private

   AuswahlWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   NeueLaustärke : SystemRecordsHTSEB.ZahlenEingabeRecord;

   procedure Soundlautstärke;
   procedure Musiklautstärke;

end OptionenSoundLogik;
