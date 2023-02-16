with TextKonstanten;
with MenueDatentypen;
with TextnummernKonstanten;

with SchreibenEinstellungenLogik;
with EinlesenSpracheLogik;
with EinlesenTextLogik;
with EinlesenSpeziestexteLogik;
with SchreibeOptionen;

with SprachauswahlLogik;
with ZahleneingabeLogik;
with AuswahlaufteilungLogik;
with Fehlermeldungssystem;
with NachGrafiktask;

package body OptionenSonstigesLogik is

   function Sonstiges
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      SonstigesSchleife:
      loop

         AuswahlWert := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Sonstiges_Menü_Enum);

         case
           AuswahlWert
         is
            when RueckgabeDatentypen.Auswahl_Eins_Enum =>
               AnzahlAutomatischerSpielstände;
               
            when RueckgabeDatentypen.Auswahl_Zwei_Enum =>
               RundenBisAutospeichern;
               
            when RueckgabeDatentypen.Auswahl_Drei_Enum =>
               SpracheWechseln;
               
            when RueckgabeDatentypen.Zurück_Beenden_Enum'Range =>
               SchreibenEinstellungenLogik.Nutzereinstellungen;
               return AuswahlWert;
               
            when others =>
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "OptionenSonstigesLogik.Sonstiges: Falsche Auswahl: " & AuswahlWert'Wide_Wide_Image);
         end case;
         
      end loop SonstigesSchleife;
      
   end Sonstiges;
   
   
   
   procedure AnzahlAutomatischerSpielstände
   is begin
      
      EingegebeneZahl := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => 0,
                                                           ZahlenMaximumExtern => 999_999_999,
                                                           WelcheFrageExtern   => TextnummernKonstanten.FrageWievieleAutospielstände);
      case
        EingegebeneZahl.ErfolgreichAbbruch
      is
         when True =>
            SchreibeOptionen.AnzahlAutospeichern (AutospeicheranzahlExtern => EingegebeneZahl.EingegebeneZahl);
            
         when False =>
            null;
      end case;
      
   end AnzahlAutomatischerSpielstände;
   
   
   
   procedure RundenBisAutospeichern
   is begin
      
      EingegebeneZahl := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => 0,
                                                           ZahlenMaximumExtern => 999_999_999,
                                                           WelcheFrageExtern   => TextnummernKonstanten.FrageRundenAutomatischSpeichern);

      case
        EingegebeneZahl.ErfolgreichAbbruch
      is
         when True =>
            if
              EingegebeneZahl.EingegebeneZahl > 0
            then
              SchreibeOptionen.RundenAutospeichern (RundenanzahlExtern => EingegebeneZahl.EingegebeneZahl);
               
            else
               SchreibeOptionen.AnzahlAutospeichern (AutospeicheranzahlExtern => EingegebeneZahl.EingegebeneZahl);
            end if;
            
         when False =>
            null;
      end case;
      
   end RundenBisAutospeichern;
   
   
   
   procedure SpracheWechseln
   is begin
      
      -- Das hier mit dem Einlesen.Einlesen zusammenführen? Geht das überhaupt sinnvoll? äöü
      case
        EinlesenSpracheLogik.EinlesenSprache
      is
         when True =>
            GewählteSprache := SprachauswahlLogik.AuswahlSprache;
            
            if
              GewählteSprache = TextKonstanten.LeerUnboundedString
            then
               null;
               
            else
               SchreibeOptionen.Sprache (SpracheExtern => GewählteSprache);
               EinlesenTextLogik.EinlesenDateien;
               EinlesenSpeziestexteLogik.SpeziestexteEinlesen;
               NachGrafiktask.AccesseSetzen := True;
            end if;
            
         when False =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "OptionenSonstigesLogik.SpracheWechseln: Sprachen nicht gefunden.");
      end case;
      
   end SpracheWechseln;
   
   
   
   -- Hier später noch eine Option für den Wechsel der Schriftart einbauen. äöü

end OptionenSonstigesLogik;
