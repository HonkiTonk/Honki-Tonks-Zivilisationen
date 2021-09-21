pragma SPARK_Mode (On);

with Ada.Calendar, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Calendar, Ada.Strings.Wide_Wide_Unbounded;

with GlobaleVariablen, GlobaleDatentypen, GlobaleKonstanten;

with Ladezeiten, Auswahl, EinlesenSprache, EinlesenText, EinlesenTastatur, EinlesenDatenbanken, EinlesenEinstellungen, SchreibenEinstellungen;

package body Einlesen is

   procedure Einlesen
   is begin
      
      Ladezeiten.EinzelneZeiten (Ladezeiten.Startzeit, GlobaleDatentypen.Anfangswert) := Clock;
      EinlesenEinstellungen.EinlesenEinstellungen;
      EinlesenDatenbanken.EinlesenAlleDatenbanken;
      EinlesenTastatur.EinlesenTastaturbelegung;
      
      if
        GlobaleVariablen.NutzerEinstellungen.Sprache = GlobaleKonstanten.LeerText
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
      
      Ladezeiten.EinzelneZeiten (Ladezeiten.Startzeit, GlobaleDatentypen.Endwert) := Clock;
      Ladezeiten.AnzeigeEinzelneZeit (WelcheZeitExtern => Ladezeiten.Startzeit);
      return;
      
   end Einlesen;

end Einlesen;
