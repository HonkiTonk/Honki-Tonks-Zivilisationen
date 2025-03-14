with TextKonstantenHTSEB;

with MenueDatentypen;
with TextnummernKonstanten;
with SystemKonstanten;
with VerzeichnisKonstanten;

with SchreibenEinstellungenLogik;
with EinlesenTextLogik;
with SchreibeOptionen;
with SchreibeGrafiktask;

with SetauswahlLogik;
with ZahleneingabeLogik;
with AuswahlaufteilungLogik;
with MeldungssystemHTSEB;
with EinlesenSetsLogik;

package body OptionenSonstigesLogik is

   function Sonstiges
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      SonstigesSchleife:
      loop

         AuswahlWert := AuswahlaufteilungLogik.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Spieleinstellungen_Menü_Enum);

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
               MeldungssystemHTSEB.Logik (MeldungExtern => "OptionenSonstigesLogik.Sonstiges: Falsche Auswahl: " & AuswahlWert'Wide_Wide_Image);
         end case;
         
      end loop SonstigesSchleife;
      
   end Sonstiges;
   
   
   
   procedure AnzahlAutomatischerSpielstände
   is begin
      
      EingegebeneZahl := ZahleneingabeLogik.Zahleneingabe (ZahlenMinimumExtern => 0,
                                                           ZahlenMaximumExtern => SystemKonstanten.MaximaleEingabe,
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
                                                           ZahlenMaximumExtern => SystemKonstanten.MaximaleEingabe,
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
   
   
   
   -- Das nicht mit dem Startsystem zum Auswählen der Sprache zusammenführen, da hier unter anderem ein Abbruch der Auswahl möglich ist.
   procedure SpracheWechseln
   is begin
      
      case
        EinlesenSetsLogik.EinlesenSets (OrdnerExtern => VerzeichnisKonstanten.Sprachen)
      is
         when True =>
            GewählteSprache := SetauswahlLogik.Setauswahl (SpracheExtern => True);
            
            if
              GewählteSprache = TextKonstantenHTSEB.LeerUnboundedString
            then
               null;
               
            else
               SchreibeOptionen.Sprache (SpracheExtern => GewählteSprache);
               SchreibeGrafiktask.SchriftartSetzen (JaNeinExtern => True);
               EinlesenTextLogik.EinlesenDateien (EinsprachigExtern => True);
               SchreibeGrafiktask.TextSetzen (JaNeinExtern => True);
            end if;
            
         when False =>
            MeldungssystemHTSEB.Logik (MeldungExtern => "OptionenSonstigesLogik.SpracheWechseln: Sprachen nicht gefunden.");
      end case;
      
   end SpracheWechseln;

end OptionenSonstigesLogik;
