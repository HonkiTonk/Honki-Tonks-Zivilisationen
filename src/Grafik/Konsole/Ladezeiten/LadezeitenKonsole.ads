pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Ada.Wide_Wide_Text_IO;

with SystemDatentypen;

with LadezeitenDatentypen;

package LadezeitenKonsole is

   procedure LadezeitenSpielweltErstellen
     (WelcheZeitExtern : in LadezeitenDatentypen.Spielwelt_Erstellen_Zeit_Verwendet_Enum);
   
   procedure AnzeigeEinzelneZeit
     (WelcheZeitExtern : in LadezeitenDatentypen.Einzelne_Zeiten_Enum);
   
   procedure AnzeigeKIZeit
     (WelcheZeitExtern : in SystemDatentypen.Rassen_Enum);
   
   procedure AnzeigeEinzelneZeitOhneWarten
     (WelcheZeitExtern : in LadezeitenDatentypen.Einzelne_Zeiten_Enum);

private

   GesamtzeitSpielweltErstellen : Float;
   GesamtzeitKI : Float;
   
   package AnzeigeFloat is new Ada.Wide_Wide_Text_IO.Float_IO (Float);

end LadezeitenKonsole;
