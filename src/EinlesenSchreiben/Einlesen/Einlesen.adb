pragma SPARK_Mode (On);

with Ada.Calendar; use Ada.Calendar;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with GlobaleVariablen;
with SystemKonstanten;
with SystemDatentypen;

with Ladezeiten;
with EinlesenSprache;
with EinlesenText;
with EinlesenTastatur;
with EinlesenDatenbanken;
with EinlesenEinstellungen;
with SchreibenEinstellungen;
with AuswahlSprache;

package body Einlesen is

   procedure Einlesen
   is begin
      
      Ladezeiten.EinzelneZeiten (Ladezeiten.Startzeit, SystemDatentypen.Anfangswert) := Clock;
      
      EinlesenOhneAnzeige;
      EinlesenMitAnzeige;
      
      Ladezeiten.EinzelneZeiten (Ladezeiten.Startzeit, SystemDatentypen.Endwert) := Clock;
      Ladezeiten.AnzeigeEinzelneZeit (WelcheZeitExtern => Ladezeiten.Startzeit);
      
   end Einlesen;
   
   
   
   procedure EinlesenOhneAnzeige
   is begin
      
      EinlesenEinstellungen.EinlesenEinstellungen;
      EinlesenDatenbanken.EinlesenAlleDatenbanken;
      EinlesenTastatur.EinlesenTastaturbelegung;
      
   end EinlesenOhneAnzeige;
   
   
   
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
