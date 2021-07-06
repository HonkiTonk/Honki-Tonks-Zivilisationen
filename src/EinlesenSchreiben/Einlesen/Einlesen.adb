pragma SPARK_Mode (On);

with Ada.Calendar, Ada.Strings.Wide_Wide_Unbounded;
use Ada.Calendar, Ada.Strings.Wide_Wide_Unbounded;

with GlobaleVariablen;

with Ladezeiten, Auswahl, EinlesenSprache, EinlesenText, EinlesenTastatur, EinlesenWerte, EinlesenEinstellungen, SchreibenEinstellungen;

package body Einlesen is

   function Einlesen
     return Boolean
   is begin
      
      Ladezeiten.EinzelneZeiten (1, 1) := Clock;
      EinlesenEinstellungen.EinlesenEinstellungen;
      
      if
        GlobaleVariablen.NutzerEinstellungen.Sprache = "|"
      then
         case
           EinlesenSprache.EinlesenSprache
         is
            when True =>
               GlobaleVariablen.NutzerEinstellungen.Sprache := Auswahl.AuswahlSprache;
               SchreibenEinstellungen.SchreibenEinstellungen;
            
            when False =>
               return False;
         end case;
         
      else
         null;
      end if;
      
      case
        EinlesenText.EinlesenText
      is
         when True =>
            null;

         when False =>
            return False;
      end case;
      
      EinlesenWerte.EinlesenAlleDatenbanken;
      EinlesenTastatur.EinlesenTastaturbelegung;
      Ladezeiten.EinzelneZeiten (1, 2) := Clock;
      Ladezeiten.AnzeigeEinzelneZeit (WelcheZeitExtern => 1);
      return Erfolgreich;
      
   end Einlesen;

end Einlesen;
