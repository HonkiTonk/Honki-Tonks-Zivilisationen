pragma SPARK_Mode (On);

with Ada.Calendar, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Calendar, Ada.Strings.Wide_Wide_Unbounded;

with GlobaleVariablen, GlobaleDatentypen;

with Ladezeiten, Auswahl, EinlesenSprache, EinlesenText, EinlesenTastatur, EinlesenDatenbanken, EinlesenEinstellungen, SchreibenEinstellungen;

package body Einlesen is

   function Einlesen
     return Boolean
   is begin
      
      Ladezeiten.EinzelneZeiten (Ladezeiten.Startzeit, GlobaleDatentypen.Anfangswert) := Clock;
      EinlesenEinstellungen.EinlesenEinstellungen;
      
      if
        GlobaleVariablen.NutzerEinstellungen.Sprache = "|"
      then
         Erfolgreich := EinlesenSprache.EinlesenSprache;
         case
           Erfolgreich
         is
            when True =>
               GlobaleVariablen.NutzerEinstellungen.Sprache := Auswahl.AuswahlSprache;
               SchreibenEinstellungen.SchreibenEinstellungen;
            
            when False =>
               return Erfolgreich;
         end case;
         
      else
         null;
      end if;
      
      Erfolgreich := EinlesenText.EinlesenTextNeu;

      case
        Erfolgreich
      is
         when True =>
            null;

         when False =>
            return Erfolgreich;
      end case;
      
      EinlesenDatenbanken.EinlesenAlleDatenbanken;
      EinlesenTastatur.EinlesenTastaturbelegung;
      Ladezeiten.EinzelneZeiten (Ladezeiten.Startzeit, GlobaleDatentypen.Endwert) := Clock;
      Ladezeiten.AnzeigeEinzelneZeit (WelcheZeitExtern => Ladezeiten.Startzeit);
      return Erfolgreich;
      
   end Einlesen;

end Einlesen;
