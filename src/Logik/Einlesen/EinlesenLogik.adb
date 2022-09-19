pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with TextKonstanten;
with OptionenVariablen;

with EinlesenSpracheLogik;
with EinlesenTextLogik;
with EinlesenTastaturLogik;
with EinlesenDatenbankenLogik;
with SchreibenEinstellungenLogik;
with SprachauswahlLogik;
with EinlesenTexturenLogik;
with Fehler;
with EinlesenMusikLogik;
with EinlesenSoundsLogik;
with EinlesenRassentexteLogik;

package body EinlesenLogik is

   procedure EinlesenOhneAnzeige
   is begin
      
      EinlesenDatenbankenLogik.EinlesenAlleDatenbanken;
      EinlesenTastaturLogik.EinlesenTastaturbelegung;
      EinlesenTexturenLogik.EinlesenTexturen;
      EinlesenMusikLogik.EinlesenMusik;
      EinlesenSoundsLogik.EinlesenSounds;
      
   end EinlesenOhneAnzeige;
   
   
   
   -- Die Anzeige wird nur für das Einlesen des Textes benötigt, später mal anpassen? äöü
   procedure EinlesenMitAnzeige
   is begin
      
      if
        OptionenVariablen.NutzerEinstellungen.Sprache = TextKonstanten.LeerUnboundedString
      then
         case
           EinlesenSpracheLogik.EinlesenSprache
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
               SchreibenEinstellungenLogik.Nutzereinstellungen;
                  
            when False =>
               Fehler.LogikFehler (FehlermeldungExtern => "Einlesen.EinlesenMitAnzeige: Sprachen nicht gefunden.");
         end case;
               
      else
         null;
      end if;
      
      EinlesenTextLogik.EinlesenDateien;
      EinlesenRassentexteLogik.RassentexteEinlesen;
      
   end EinlesenMitAnzeige;

end EinlesenLogik;
