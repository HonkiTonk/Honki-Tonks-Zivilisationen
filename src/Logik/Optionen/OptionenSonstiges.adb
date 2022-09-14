pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TextKonstanten;
with MenueDatentypen;
with OptionenVariablen;
with TextnummernKonstanten;

with SchreibenEinstellungen;
with EinlesenSprache;
with EinlesenText;
with EinlesenRassentexte;

with SprachauswahlLogik;
with ZahleneingabeLogik;
with AuswahlaufteilungLogik;
with Fehler;
with NachGrafiktask;

package body OptionenSonstiges is

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
               -- Bei allen Optionen speichern wenn zurückgegangen wird? äöü
               SchreibenEinstellungen.SchreibenEinstellungen;
               return AuswahlWert;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "OptionenSonstiges.Sonstiges: Falsche Auswahl: " & AuswahlWert'Wide_Wide_Image);
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
            OptionenVariablen.NutzerEinstellungen.AnzahlAutosave := EingegebeneZahl.EingegebeneZahl;
            
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
              EingegebeneZahl.EingegebeneZahl in 1 .. 999_999_999
            then
               OptionenVariablen.NutzerEinstellungen.RundenBisAutosave := EingegebeneZahl.EingegebeneZahl;
               
            elsif
              EingegebeneZahl.EingegebeneZahl = 0
            then
               OptionenVariablen.NutzerEinstellungen.AnzahlAutosave := EingegebeneZahl.EingegebeneZahl;
               
            else
               Fehler.LogikFehler (FehlermeldungExtern => "OptionenSonstiges.RundenBisAutospeichern - Falsche Zahl wurde eingegeben.");
            end if;
            
         when False =>
            null;
      end case;
      
   end RundenBisAutospeichern;
   
   
   
   procedure SpracheWechseln
   is begin
      
      -- Das hier mit dem Einlesen.Einlesen zusammenführen? Geht das überhaupt sinnvoll? äöü
      case
        EinlesenSprache.EinlesenSprache
      is
         when True =>
            GewählteSprache := SprachauswahlLogik.AuswahlSprache;
            
            if
              GewählteSprache = TextKonstanten.LeerUnboundedString
            then
               null;
               
            else
               OptionenVariablen.NutzerEinstellungen.Sprache := GewählteSprache;
               EinlesenText.EinlesenDateien;
               EinlesenRassentexte.RassentexteEinlesen;
               NachGrafiktask.AccesseSetzen := True;
            end if;
            
         when False =>
            Fehler.LogikFehler (FehlermeldungExtern => "OptionenSonstiges.SpracheWechseln - Sprachen nicht gefunden.");
      end case;
      
   end SpracheWechseln;
   
   
   
   -- Hier später noch eine Option für den Wechsel der Schriftart einbauen. äöü

end OptionenSonstiges;
