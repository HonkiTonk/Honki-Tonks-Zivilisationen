pragma SPARK_Mode (On);

-- with Ada.Calendar; use Ada.Calendar;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

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
               GlobaleVariablen.NutzerEinstellungen.Sprache := AuswahlSprache.AuswahlSprache;
               SchreibenEinstellungen.SchreibenEinstellungen;
            
            when False =>
               raise Program_Error;
         end case;
         
      else
         null;
      end if;
      
      EinlesenText.EinlesenDateien;
      
   end EinlesenMitAnzeige;

end Einlesen;
