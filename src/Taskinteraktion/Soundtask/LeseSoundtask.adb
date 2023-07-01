with Soundtask;

package body LeseSoundtask is

   function SoundStarten
     return TonDatentypen.Sound_Aktuelle_Auswahl_Enum
   is begin
      
      return Soundtask.Sound.Starten;
      
   end SoundStarten;
   
   
   
   function SoundStoppen
     return TonDatentypen.Sound_Aktuelle_Auswahl_Enum
   is begin
      
      return Soundtask.Sound.Stoppen;
      
   end SoundStoppen;

end LeseSoundtask;
