pragma SPARK_Mode (On);

with Ada.Calendar, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Calendar, Ada.Strings.Wide_Wide_Unbounded;

with GlobaleVariablen, GlobaleDatentypen, SystemKonstanten;

with Ladezeiten, Auswahl, EinlesenSprache, EinlesenText, EinlesenTastatur, EinlesenDatenbanken, EinlesenEinstellungen, SchreibenEinstellungen;

package body Einlesen is

   procedure Einlesen
   is begin
      
      Ladezeiten.EinzelneZeiten (Ladezeiten.Startzeit, GlobaleDatentypen.Anfangswert) := Clock;
      
      EinlesenOhneAnzeige;
      EinlesenMitAnzeige;
      
      Ladezeiten.EinzelneZeiten (Ladezeiten.Startzeit, GlobaleDatentypen.Endwert) := Clock;
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
        GlobaleVariablen.NutzerEinstellungen.Sprache = SystemKonstanten.LeerText
      then
         case
           EinlesenSprache.EinlesenSprache
         is
            when True =>
               GlobaleVariablen.NutzerEinstellungen.Sprache := Auswahl.AuswahlSprache;
               SchreibenEinstellungen.SchreibenEinstellungen;
            
            when False =>
               return;
         end case;
         
      else
         null;
      end if;
      
      case
        EinlesenText.EinlesenTextNeu
      is
         when True =>
            null;

         when False =>
            return;
      end case;
      
   end EinlesenMitAnzeige;

end Einlesen;
