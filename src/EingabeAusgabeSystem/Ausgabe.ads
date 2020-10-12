with Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded, GlobaleVariablen;
use Ada.Wide_Wide_Text_IO, Ada.Strings.Wide_Wide_Unbounded;

package Ausgabe is

   procedure RassenBeschreibung (WelcheRasse : in Integer);
   procedure Zeug (WelchesZeug : in Integer);
   procedure Fehlermeldungen (WelcheFehlermeldung : in Integer);
   procedure WelcheAuswahl (WasWurdeGewählt : in Integer);
   procedure TexteEinlesenAusgabe (WelcheDatei, WelcherText : in Integer);
   
end Ausgabe;
