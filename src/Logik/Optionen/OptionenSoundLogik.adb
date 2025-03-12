with MeldungssystemHTSEB;

with MenueDatentypen;
with TextnummernKonstanten;
with TonKonstanten;
with VerzeichnisKonstanten;
with TextKonstanten;
with TonDatentypen;

with SchreibeEinstellungenTon;
with SchreibenEinstellungenLogik;
with SchreibeOptionen;
with SchreibeMusiktask;

with AuswahlaufteilungLogik;
with ZahleneingabeLogik;
with EinstellungenSound;
with EinstellungenMusik;
with EinlesenSetsLogik;
with SetauswahlLogik;
with EinlesenMusikLogik;
with EinlesenSoundsLogik;

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
               
            when RueckgabeDatentypen.Auswahl_Drei_Enum =>
               MusikWechseln;
               
            when RueckgabeDatentypen.Auswahl_Vier_Enum =>
               SoundWechseln;
               
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
            EinstellungenSound.Lautstärke;
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
            EinstellungenMusik.Lautstärke;
      end case;
      
   end Musiklautstärke;
   
   
   
   procedure MusikWechseln
   is begin
      
      SchreibeMusiktask.NeueMusikart (MusikExtern => TonDatentypen.Musik_Pause_Enum);
      
      case
        EinlesenSetsLogik.EinlesenSets (OrdnerExtern => VerzeichnisKonstanten.MusikOhneStrich)
      is
         when True =>
            GewählterTon := SetauswahlLogik.Setauswahl (SpracheExtern => False);
            
            if
              GewählterTon = TextKonstanten.LeerUnboundedString
            then
               null;
               
            else
               SchreibeOptionen.Musik (MusikExtern => GewählterTon);
               EinlesenMusikLogik.EinlesenMusik;
               SchreibenEinstellungenLogik.Nutzereinstellungen;
            end if;
            
         when False =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "OptionenSoundLogik.MusikWechseln: Musik nicht gefunden.");
      end case;
      
      SchreibeMusiktask.NeueMusikart (MusikExtern => TonDatentypen.Musik_Spiel_Enum);
      
   end MusikWechseln;
   
   
   
   procedure SoundWechseln
   is begin
      
      case
        EinlesenSetsLogik.EinlesenSets (OrdnerExtern => VerzeichnisKonstanten.SoundOhneStrich)
      is
         when True =>
            GewählterTon := SetauswahlLogik.Setauswahl (SpracheExtern => False);
            
            if
              GewählterTon = TextKonstanten.LeerUnboundedString
            then
               null;
               
            else
               -- Das hier als Funktion aufrufen um bei Fehlern nicht den falschen Wert zu schreiben? äöü
               -- Würde eher nein sagen aktuell. äöü
               SchreibeOptionen.Sound (SoundExtern => GewählterTon);
               EinlesenSoundsLogik.EinlesenSounds;
               SchreibenEinstellungenLogik.Nutzereinstellungen;
            end if;
            
         when False =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "OptionenSoundLogik.SoundWechseln: Sound nicht gefunden.");
      end case;
      
   end SoundWechseln;

end OptionenSoundLogik;
