pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TextKonstanten;
with OptionenVariablen;

with EinlesenSprache;
with EinlesenText;
with EinlesenTastatur;
with EinlesenDatenbanken;
with SchreibenEinstellungen;
with SprachauswahlLogik;
with EinlesenTexturen;
with Fehler;
with EinlesenMusik;
with EinlesenSounds;
with EinlesenRassentexte;

package body Einlesen is

   procedure EinlesenOhneAnzeige
   is begin
      
      EinlesenDatenbanken.EinlesenAlleDatenbanken;
      EinlesenTastatur.EinlesenTastaturbelegung;
      EinlesenTexturen.EinlesenTexturen;
      EinlesenMusik.EinlesenMusik;
      EinlesenSounds.EinlesenSounds;
      
   end EinlesenOhneAnzeige;
   
   
   
   -- Die Anzeige wird nur für das Einlesen des Textes benötigt, später mal anpassen? äöü
   procedure EinlesenMitAnzeige
   is begin
      
      if
        OptionenVariablen.NutzerEinstellungen.Sprache = TextKonstanten.LeerUnboundedString
      then
         case
           EinlesenSprache.EinlesenSprache
         is
            when True =>
               SpracheAuswählenSchleife:
               loop
                  
                  GewählteSprache := SprachauswahlLogik.AuswahlSprache;
                  
                  if
                    GewählteSprache = TextKonstanten.LeerUnboundedString
                  then
                     null;
                     
                  else
                     exit SpracheAuswählenSchleife;
                  end if;
                  
               end loop SpracheAuswählenSchleife;
                  
               OptionenVariablen.NutzerEinstellungen.Sprache := GewählteSprache;
               SchreibenEinstellungen.SchreibenEinstellungen;
                  
            when False =>
               Fehler.LogikFehler (FehlermeldungExtern => "Einlesen.EinlesenMitAnzeige: Sprachen nicht gefunden.");
         end case;
               
      else
         null;
      end if;
      
      EinlesenText.EinlesenDateien;
      EinlesenRassentexte.RassentexteEinlesen;
      
   end EinlesenMitAnzeige;

end Einlesen;
