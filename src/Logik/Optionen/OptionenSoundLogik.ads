private with Ada.Strings.Wide_Wide_Unbounded;

private with SystemRecordsHTSEB;

with RueckgabeDatentypen;

package OptionenSoundLogik is
   pragma Elaborate_Body;

   function OptionenSound
     return RueckgabeDatentypen.Rückgabe_Werte_Enum;

private
   use Ada.Strings.Wide_Wide_Unbounded;

   EinstellungenSchreiben : Boolean;
   EinstellungenGeändert : Boolean;

   AuswahlWert : RueckgabeDatentypen.Rückgabe_Werte_Enum;

   GewählterTon : Unbounded_Wide_Wide_String;

   NeueLaustärke : SystemRecordsHTSEB.ZahlenEingabeRecord;



   function Soundlautstärke
     return Boolean;

   function Musiklautstärke
     return Boolean;

   function MusikWechseln
     return Boolean;

   function SoundWechseln
     return Boolean;

end OptionenSoundLogik;
