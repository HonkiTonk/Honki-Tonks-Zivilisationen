pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TextKonstanten;
with MenueDatentypen;
with OptionenVariablen;

with SchreibenEinstellungen;
with EinlesenSprache;
with EinlesenText;
with EinlesenRassentexte;

with AuswahlSprache;
with EingabeSFML;
with Auswahlaufteilungen;
with Fehler;
with NachGrafiktask;

package body OptionenSonstiges is

   function Sonstiges
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      SonstigesSchleife:
      loop

         AuswahlWert := Auswahlaufteilungen.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Sonstiges_Menü_Enum);

         case
           AuswahlWert
         is
            when RueckgabeDatentypen.Anzahl_Speicherstände_Enum =>
               AnzahlAutomatischerSpielstände;
               
            when RueckgabeDatentypen.Runden_Bis_Autospeichern_Enum =>
               RundenBisAutospeichern;
               
            when RueckgabeDatentypen.Sprache_Enum =>
               SpracheWechseln;
               
            when RueckgabeDatentypen.Zurück_Beenden_Enum'Range =>
               SchreibenEinstellungen.SchreibenEinstellungen;
               return AuswahlWert;
               
            when others =>
               Fehler.LogikFehler (FehlermeldungExtern => "OptionenSonstiges.Sonstiges - Falsche Menüauswahl.");
         end case;
         
      end loop SonstigesSchleife;
      
   end Sonstiges;
   
   
   
   procedure AnzahlAutomatischerSpielstände
   is begin
      
      EingegebeneZahl := EingabeSFML.GanzeZahl (ZahlenMinimumExtern => 0,
                                                ZahlenMaximumExtern => 999_999_999,
                                                WelcheFrageExtern   => 2);
      case
        EingegebeneZahl.EingabeAbbruch
      is
         when True =>
            OptionenVariablen.NutzerEinstellungen.AnzahlAutosave := EingegebeneZahl.EingegebeneZahl;
            
         when False =>
            null;
      end case;
      
   end AnzahlAutomatischerSpielstände;
   
   
   
   procedure RundenBisAutospeichern
   is begin
      
      EingegebeneZahl := EingabeSFML.GanzeZahl (ZahlenMinimumExtern => 0,
                                                ZahlenMaximumExtern => 999_999_999,
                                                WelcheFrageExtern   => 3);

      case
        EingegebeneZahl.EingabeAbbruch
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
            GewählteSprache := AuswahlSprache.AuswahlSprache;
            
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
