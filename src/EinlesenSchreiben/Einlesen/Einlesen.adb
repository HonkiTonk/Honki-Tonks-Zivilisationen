pragma SPARK_Mode (On);

with Ada.Calendar, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Calendar, Ada.Strings.Wide_Wide_Unbounded;

with GlobaleVariablen, GlobaleDatentypen;

with Ladezeiten, Auswahl, EinlesenSprache, EinlesenText, EinlesenTastatur, EinlesenWerte, EinlesenEinstellungen, SchreibenEinstellungen;

package body Einlesen is

   function Einlesen
     return Boolean
   is begin
      
      Ladezeiten.EinzelneZeiten (1, GlobaleDatentypen.Anfangswert) := Clock;
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
      
      EinlesenWerte.EinlesenAlleDatenbanken;
      EinlesenTastatur.EinlesenTastaturbelegung;
      Ladezeiten.EinzelneZeiten (1, GlobaleDatentypen.Endwert) := Clock;
      Ladezeiten.AnzeigeEinzelneZeit (WelcheZeitExtern => 1);
      return Erfolgreich;
      
   end Einlesen;

end Einlesen;
