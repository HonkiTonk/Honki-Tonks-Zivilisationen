with MenueDatentypen;
with TextnummernKonstanten;
with TonKonstanten;

with SchreibeEinstellungenTon;
with SchreibenEinstellungenLogik;

with AuswahlaufteilungLogik;
with MeldungssystemHTSEB;
with ZahleneingabeLogik;
with StarteinstellungenSound;
with StarteinstellungenMusik;

package body OptionenSoundLogik is

   function OptionenSound
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      SoundSchleife:
      loop
         
         AuswahlWert := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Sound_Menü_Enum);
         
         case
           AuswahlWert
         is
            when RueckgabeDatentypen.Auswahl_Eins_Enum =>
               Soundlautstärke;
               
            when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
               Musiklautstärke;
               
            when RueckgabeDatentypen.Zurück_Beenden_Enum'Range =>
               SchreibenEinstellungenLogik.Toneinstellungen;
               return AuswahlWert;
               
            when others =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "OptionenSoundLogik.OptionenSound: Falsche Auswahl: " & AuswahlWert'Wide_Wide_Image);
         end case;
         
      end loop SoundSchleife;
      
   end OptionenSound;
   
   
   
   procedure Soundlautstärke
   is begin
      
      NeueLaustärke := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => Natural (TonKonstanten.MinimaleLautstärke),
                                                          ZahlenMaximumExtern => Positive (TonKonstanten.MaximaleLautstärke),
                                                          WelcheFrageExtern   => TextnummernKonstanten.FrageSoundlautstärke);
      
      case
        NeueLaustärke.ErfolgreichAbbruch
      is
         when False =>
            null;
            
         when True =>
            SchreibeEinstellungenTon.Soundlautstärke (LautstärkeExtern => Float (NeueLaustärke.EingegebeneZahl));
            StarteinstellungenSound.Lautstärke;
      end case;
      
   end Soundlautstärke;
   
   
   
   procedure Musiklautstärke
   is begin
      
      NeueLaustärke := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => Natural (TonKonstanten.MinimaleLautstärke),
                                                          ZahlenMaximumExtern => Positive (TonKonstanten.MaximaleLautstärke),
                                                          WelcheFrageExtern   => TextnummernKonstanten.FrageMusiklautstärke);
      
      case
        NeueLaustärke.ErfolgreichAbbruch
      is
         when False =>
            null;
            
         when True =>
            SchreibeEinstellungenTon.Musiklautstärke (LautstärkeExtern => Float (NeueLaustärke.EingegebeneZahl));
            StarteinstellungenMusik.Lautstärke;
      end case;
      
   end Musiklautstärke;

end OptionenSoundLogik;
