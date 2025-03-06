with Sf.Audio.Music;
with Sf.Audio.SoundStatus;

with ZeitKonstanten;

with SchreibeLogiktask;
with LeseMusiktask;
with LeseGesamttask;
with SchreibeMusiktask;

with StartEndeMusik;
with StarteinstellungenMusik;
with EingeleseneMusik;
with ZufallsgeneratorenHTSEB;

-- Musik muss immer gestoppt werden, sonst wird sie nicht erneut abgespielt!
-- Musik wird direkt parallel aufgerufen. Steht auch im SFML Tutorial, allerdings unter Sound, und der Beschreibung der ASFML.
package body Musik is

   procedure Musik
   is begin
      
      EinlesenAbwartenSchleife:
      while LeseGesamttask.EinstellungenEingelesen = False loop
         
         delay ZeitKonstanten.WartezeitMusik;
         
      end loop EinlesenAbwartenSchleife;
      
      StarteinstellungenMusik.Lautstärke;
      SchreibeLogiktask.WartenMusik (ZustandExtern => False);
      
      MusikSchleife:
      loop
         
         case
           LeseMusiktask.AktuelleMusikart
         is
            when TonDatentypen.Musik_Intro_Enum =>
               Intro;
               
            when TonDatentypen.Musik_Spiel_Enum =>
               Spiel;
               
            when TonDatentypen.Musik_Forschung_Enum =>
               Forschung;
               
            when TonDatentypen.Musik_Pause_Enum =>
               Pause;
               
            when TonDatentypen.Musik_Ende_Enum =>
               exit MusikSchleife;
         end case;
         
      end loop MusikSchleife;
      
      StartEndeMusik.Entfernen;
      
   end Musik;
      
      
      
   procedure Intro
   is
      use type Sf.Audio.SoundStatus.sfSoundStatus;
      use type TonDatentypen.Musikart_Enum;
   begin
      
      Musikart := LeseMusiktask.NeueMusikart;
                  
      if
        Musikart /= TonDatentypen.Musik_Intro_Enum
      then
         SchreibeMusiktask.AktuelleMusikart (MusikExtern => Musikart);
         StartEndeMusik.Stoppen (MusikExtern => EingeleseneMusik.Intromusik (1));
                  
      elsif
        Sf.Audio.Music.getStatus (music => EingeleseneMusik.Intromusik (1)) = Sf.Audio.SoundStatus.sfPlaying
      then
         delay ZeitKonstanten.WartezeitMusik;
                     
      else
         StartEndeMusik.Stoppen (MusikExtern => EingeleseneMusik.Intromusik (1));
         StartEndeMusik.Abspielen (MusikExtern => EingeleseneMusik.Intromusik (1));
      end if;
      
   end Intro;
   
   
   
   -- Einen kleinen Zeitabstand einbauen zwischen dem Wechsel der Lieder? äöü
   procedure Spiel
   is
      use type Sf.Audio.SoundStatus.sfSoundStatus;
      use type TonDatentypen.Musikart_Enum;
   begin
      
      Musikart := LeseMusiktask.NeueMusikart; 
      
      if
        Musikart /= TonDatentypen.Musik_Spiel_Enum
      then
         SchreibeMusiktask.AktuelleMusikart (MusikExtern => Musikart);
         StartEndeMusik.Stoppen (MusikExtern => EingeleseneMusik.Spielmusik (AktuelleMusik));
         
      elsif
        Sf.Audio.Music.getStatus (music => EingeleseneMusik.Spielmusik (AktuelleMusik)) = Sf.Audio.SoundStatus.sfPlaying
      then
         delay ZeitKonstanten.WartezeitMusik;
         
      else
         StartEndeMusik.Stoppen (MusikExtern => EingeleseneMusik.Spielmusik (AktuelleMusik));
         AktuelleMusik := ZufallsgeneratorenHTSEB.VorgegebenerZahlenbereich (AnfangExtern => EingeleseneMusik.Spielmusik'First,
                                                                             EndeExtern   => EingeleseneMusik.Spielmusik'Last);
         StartEndeMusik.Abspielen (MusikExtern => EingeleseneMusik.Spielmusik (AktuelleMusik));
      end if;
      
   end Spiel;
   
   
   
   procedure Forschung
   is
      use type Sf.Audio.SoundStatus.sfSoundStatus;
      use type TonDatentypen.Musikart_Enum;
   begin
      
      Musikart := LeseMusiktask.NeueMusikart;
      
      if
        Musikart /= TonDatentypen.Musik_Forschung_Enum
      then
         SchreibeMusiktask.AktuelleMusikart (MusikExtern => Musikart);
         StartEndeMusik.Stoppen (MusikExtern => EingeleseneMusik.Forschungsmusik (1));
                  
      elsif
        Sf.Audio.Music.getStatus (music => EingeleseneMusik.Forschungsmusik (1)) = Sf.Audio.SoundStatus.sfPlaying
      then
         delay ZeitKonstanten.WartezeitMusik;
                  
      else
         StartEndeMusik.Stoppen (MusikExtern => EingeleseneMusik.Forschungsmusik (1));
         StartEndeMusik.Abspielen (MusikExtern => EingeleseneMusik.Forschungsmusik (1));
      end if;
      
   end Forschung;
   
   
   
   procedure Pause
   is
      use type TonDatentypen.Musikart_Enum;
   begin
      
      Musikart := LeseMusiktask.NeueMusikart;
               
      if
        LeseMusiktask.AktuelleMusikart = TonDatentypen.Musik_Pause_Enum
        and
          Musikart /= TonDatentypen.Musik_Pause_Enum
      then
         SchreibeMusiktask.AktuelleMusikart (MusikExtern => Musikart);
                  
      else
         delay ZeitKonstanten.WartezeitMusik;
      end if;
      
   end Pause;

end Musik;
