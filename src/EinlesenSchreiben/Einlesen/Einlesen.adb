pragma SPARK_Mode (On);

with Ada.Calendar, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Text_IO;
use Ada.Calendar, Ada.Strings.Wide_Wide_Unbounded, Ada.Wide_Wide_Text_IO;

with GlobaleVariablen;

with Ladezeiten, Auswahl, EinlesenSprache, EinlesenText, EinlesenTastatur, EinlesenWerte, EinlesenEinstellungen, SchreibenEinstellungen;

package body Einlesen is

   function Einlesen
     return Boolean
   is begin
      
      Ladezeiten.EinzelneZeiten (1, 1) := Clock;
      EinlesenEinstellungen.EinlesenEinstellungen;
      Put_Line ("3");
      
      if
        GlobaleVariablen.EinstellungenEingelesen (1) = "/"
      then
         Erfolgreich := EinlesenSprache.EinlesenSprache;
         Put_Line ("1");
         case
           Erfolgreich
         is
            when True =>
               Put_Line ("2");
               GlobaleVariablen.EinstellungenEingelesen (1) := Auswahl.AuswahlSprache;
               SchreibenEinstellungen.SchreibenSprache;
            
            when False =>
               Put_Line ("4");
               return Erfolgreich;
         end case;
         
      else
         Put_Line ("5");
         null;
      end if;
      
      Erfolgreich := EinlesenText.EinlesenTextNeu;

      case
        Erfolgreich
      is
         when True =>
            null;

         when False =>
            Put_Line ("6");
            return Erfolgreich;
      end case;      
      
      EinlesenWerte.EinlesenAlleDatenbanken;
      EinlesenTastatur.EinlesenTastaturbelegung;
      Ladezeiten.EinzelneZeiten (1, 2) := Clock;
      Ladezeiten.AnzeigeEinzelneZeit (WelcheZeitExtern => 1);
      return Erfolgreich;
      
   end Einlesen;

end Einlesen;
