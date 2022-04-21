pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TextKonstanten;
with MenueDatentypen;
with OptionenVariablen;

with SchreibenEinstellungen;
with EinlesenSprache;
with EinlesenText;

with AuswahlSprache;
with Eingabe;
with AuswahlMenues;
with Fehler;
with AuswahlMenuesEinfachSFML;

package body OptionenSonstiges is

   function Sonstiges
     return RueckgabeDatentypen.Rückgabe_Werte_Enum
   is begin
      
      SonstigesSchleife:
      loop

         AuswahlWert := AuswahlMenues.AuswahlMenüsAufteilung (WelchesMenüExtern => MenueDatentypen.Sonstiges_Menü_Enum);

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
               Fehler.LogikFehler (FehlermeldungExtern => "OptionenSonstiges.Sonstiges - Ungültige Menüauswahl.");
         end case;
         
      end loop SonstigesSchleife;
      
   end Sonstiges;
   
   
   
   procedure AnzahlAutomatischerSpielstände
   is begin
      
      EingegebeneZahl := Eingabe.GanzeZahl (ZeileExtern         => 2,
                                            ZahlenMinimumExtern => 0,
                                            ZahlenMaximumExtern => 999_999_999);
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
      
      EingegebeneZahl := Eingabe.GanzeZahl (ZeileExtern         => 3,
                                            ZahlenMinimumExtern => 0,
                                            ZahlenMaximumExtern => 999_999_999);

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
               Fehler.LogikFehler (FehlermeldungExtern => "OptionenSonstiges.RundenBisAutospeichern - Ungültige Zahl wurd eingegeben.");
            end if;
            
         when False =>
            null;
      end case;
      
   end RundenBisAutospeichern;
   
   
   
   procedure SpracheWechseln
   is begin
      
      -- Das hier mit dem Einlesen.Einlesen zusammenführen? Geht das überhaupt sinnvoll?
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
               AuswahlMenuesEinfachSFML.TextZurücksetzen;
            end if;
            
         when False =>
            Fehler.LogikFehler (FehlermeldungExtern => "OptionenSonstiges.SpracheWechseln - Sprachen wurden nicht gefunden.");
      end case;
      
   end SpracheWechseln;
   
   
   
   -------------------- Hier später noch eine Option für den Wechsel der Schriftart einbauen.

end OptionenSonstiges;
