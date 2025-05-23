with MeldungssystemHTSEB;
with TextKonstantenHTSEB;

with MenueDatentypen;
with TextnummernKonstanten;
with TonKonstanten;
with VerzeichnisKonstanten;
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
      
      EinstellungenSchreiben := False;
      EinstellungenGeändert := False;
      
      SoundSchleife:
      loop
         
         AuswahlWert := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Sound_Menü_Enum);
         
         case
           AuswahlWert
         is
            when RueckgabeDatentypen.Auswahl_Eins_Enum =>
               EinstellungenGeändert := Soundlautstärke;
               
            when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
               EinstellungenGeändert := Musiklautstärke;
               
            when RueckgabeDatentypen.Auswahl_Drei_Enum =>
               EinstellungenGeändert := MusikWechseln;
               
            when RueckgabeDatentypen.Auswahl_Vier_Enum =>
               EinstellungenGeändert := SoundWechseln;
               
            when RueckgabeDatentypen.Zurück_Beenden_Enum'Range =>
               exit SoundSchleife;
               
            when others =>
               MeldungssystemHTSEB.Logik (MeldungExtern => "OptionenSoundLogik.OptionenSound: Falsche Auswahl: " & AuswahlWert'Wide_Wide_Image);
         end case;
         
         case
           EinstellungenGeändert
         is
            when True =>
               EinstellungenSchreiben := True;
               
            when False =>
               null;
         end case;
         
      end loop SoundSchleife;
      
      case
        EinstellungenSchreiben
      is
         when True =>
            SchreibenEinstellungenLogik.Toneinstellungen;
            
         when False =>
            null;
      end case;
      
      return AuswahlWert;
      
   end OptionenSound;
   
   
   
   function Soundlautstärke
     return Boolean
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
      
      return NeueLaustärke.ErfolgreichAbbruch;
      
   end Soundlautstärke;
   
   
   
   function Musiklautstärke
     return Boolean
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
      
      return NeueLaustärke.ErfolgreichAbbruch;
      
   end Musiklautstärke;
   
   
   
   function MusikWechseln
     return Boolean
   is begin
      
      SchreibeMusiktask.NeueMusikart (MusikExtern => TonDatentypen.Musik_Pause_Enum);
      
      case
        EinlesenSetsLogik.EinlesenSets (OrdnerExtern => VerzeichnisKonstanten.MusikOhneStrich)
      is
         when True =>
            GewählterTon := SetauswahlLogik.Setauswahl (SpracheExtern => False);
            
            if
              GewählterTon = TextKonstantenHTSEB.LeerUnboundedString
            then
               null;
               
            else
               -- Das hier als Funktion aufrufen um bei Fehlern nicht den falschen Wert zu schreiben? äöü
               SchreibeOptionen.Musik (MusikExtern => GewählterTon);
               EinlesenMusikLogik.EinlesenMusik;
               SchreibenEinstellungenLogik.Nutzereinstellungen;
               SchreibeMusiktask.NeueMusikart (MusikExtern => TonDatentypen.Musik_Spiel_Enum);
               return True;
            end if;
            
         when False =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "OptionenSoundLogik.MusikWechseln: Musik nicht gefunden.");
      end case;
      
      -- In dem Fall einfach versuchen Standard zu verwenden? äöü
      -- Auch bei Sounds und Texturen? äöü
      SchreibeMusiktask.NeueMusikart (MusikExtern => TonDatentypen.Musik_Spiel_Enum);
      
      return False;
      
   end MusikWechseln;
   
   
   
   function SoundWechseln
     return Boolean
   is begin
      
      case
        EinlesenSetsLogik.EinlesenSets (OrdnerExtern => VerzeichnisKonstanten.SoundOhneStrich)
      is
         when True =>
            GewählterTon := SetauswahlLogik.Setauswahl (SpracheExtern => False);
            
            if
              GewählterTon = TextKonstantenHTSEB.LeerUnboundedString
            then
               null;
               
            else
               -- Das hier als Funktion aufrufen um bei Fehlern nicht den falschen Wert zu schreiben? äöü
               SchreibeOptionen.Sound (SoundExtern => GewählterTon);
               EinlesenSoundsLogik.EinlesenSounds;
               SchreibenEinstellungenLogik.Nutzereinstellungen;
               return True;
            end if;
            
         when False =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "OptionenSoundLogik.SoundWechseln: Sound nicht gefunden.");
      end case;
      
      return False;
      
   end SoundWechseln;

end OptionenSoundLogik;
