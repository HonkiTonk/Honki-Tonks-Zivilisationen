pragma SPARK_Mode (On);

with Ada.Calendar;
use Ada.Calendar;

with GlobaleVariablen;

with Ladezeiten, Auswahl, EinlesenSprache, EinlesenText, EinlesenTastatur, EinlesenWerte;

package body Einlesen is

   function Einlesen
     return Boolean
   is begin
      
      Ladezeiten.EinzelneZeiten (1, 1) := Clock;
      Erfolgreich := EinlesenSprache.EinlesenSprache;
      
      case
        Erfolgreich
      is
         when True =>
            GlobaleVariablen.GewählteSprache := Auswahl.AuswahlSprache;
            
         when False =>
            return Erfolgreich;
      end case;
      
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
      Ladezeiten.EinzelneZeiten (1, 2) := Clock;
      Ladezeiten.AnzeigeEinzelneZeit (WelcheZeitExtern => 1);
      return Erfolgreich;
      
   end Einlesen;

end Einlesen;
