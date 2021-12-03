pragma SPARK_Mode (On);

-- with Ada.Calendar; use Ada.Calendar;

with GlobaleVariablen;
with SystemKonstanten;
-- with SystemDatentypen;

-- with Ladezeiten;
with EinlesenSprache;
with EinlesenText;
with EinlesenTastatur;
with EinlesenDatenbanken;
with SchreibenEinstellungen;
with AuswahlSprache;
with EinlesenTexturen;
with Fehler;

package body Einlesen is

   -- Ladezeiten später ändern und wieder einbauen, vor allem so dass die Nutzerauswahlzeit nicht berücksichtigt wird.
   -- Ladezeiten.EinzelneZeiten (Ladezeiten.Startzeit, SystemDatentypen.Anfangswert) := Clock;
   -- Ladezeiten.EinzelneZeiten (Ladezeiten.Startzeit, SystemDatentypen.Endwert) := Clock;
   -- Ladezeiten.AnzeigeEinzelneZeit (WelcheZeitExtern => Ladezeiten.Startzeit);
      
   procedure EinlesenOhneAnzeige
   is begin
      
      EinlesenDatenbanken.EinlesenAlleDatenbanken;
      EinlesenTastatur.EinlesenTastaturbelegung;
      EinlesenTexturen.EinlesenTexturen;
      
   end EinlesenOhneAnzeige;
   
   
   
   -- Die Anzeige wird nur für das Einlesen des Textes benötigt, später mal anpassen?
   procedure EinlesenMitAnzeige
   is begin
      
      if
        GlobaleVariablen.NutzerEinstellungen.Sprache = SystemKonstanten.LeerUnboundedString
      then
         case
           EinlesenSprache.EinlesenSprache
         is
            when True =>
               SpracheAuswählenSchleife:
               loop
                  
                  GewählteSprache := AuswahlSprache.AuswahlSprache;
                  
                  if
                    GewählteSprache = SystemKonstanten.LeerUnboundedString
                  then
                     null;
                     
                  else
                     exit SpracheAuswählenSchleife;
                  end if;
                  
               end loop SpracheAuswählenSchleife;
                  
               GlobaleVariablen.NutzerEinstellungen.Sprache := GewählteSprache;
               SchreibenEinstellungen.SchreibenEinstellungen;
                  
            when False =>
               Fehler.LogikStopp (FehlermeldungExtern => "Einlesen.EinlesenMitAnzeige - Sprachen wurden nicht gefunden.");
         end case;
               
      else
         null;
      end if;
      
      EinlesenText.EinlesenDateien;
      
   end EinlesenMitAnzeige;

end Einlesen;
