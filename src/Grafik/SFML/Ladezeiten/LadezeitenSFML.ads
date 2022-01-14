pragma SPARK_Mode (On);

with SystemDatentypen;

with LadezeitenDatentypen;

package LadezeitenSFML is

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

end LadezeitenSFML;
