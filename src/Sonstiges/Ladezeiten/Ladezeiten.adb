pragma SPARK_Mode (On);
with GlobaleVariablen;

with LadezeitenKonsole;
with LadezeitenSFML;

package body Ladezeiten is

   procedure LadezeitenSpielweltErstellen
     (WelcheZeitExtern : in LadezeitenDatentypen.Spielwelt_Erstellen_Zeit_Verwendet_Enum)
   is begin

      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Grafik_Konsole =>
            LadezeitenKonsole.LadezeitenSpielweltErstellen (WelcheZeitExtern => WelcheZeitExtern);
            
         when SystemDatentypen.Grafik_SFML =>
            LadezeitenSFML.LadezeitenSpielweltErstellen (WelcheZeitExtern => WelcheZeitExtern);
      end case;
                        
   end LadezeitenSpielweltErstellen;
   
   
   
   procedure AnzeigeEinzelneZeit
     (WelcheZeitExtern : in LadezeitenDatentypen.Einzelne_Zeiten_Enum)
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Grafik_Konsole =>
            LadezeitenKonsole.AnzeigeEinzelneZeit (WelcheZeitExtern => WelcheZeitExtern);
            
         when SystemDatentypen.Grafik_SFML =>
            LadezeitenSFML.AnzeigeEinzelneZeit (WelcheZeitExtern => WelcheZeitExtern);
      end case;
      
   end AnzeigeEinzelneZeit;
   
   
   
   procedure AnzeigeEinzelneZeitOhneWarten
     (WelcheZeitExtern : in LadezeitenDatentypen.Einzelne_Zeiten_Enum)
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Grafik_Konsole =>
            LadezeitenKonsole.AnzeigeEinzelneZeitOhneWarten (WelcheZeitExtern => WelcheZeitExtern);
            
         when SystemDatentypen.Grafik_SFML =>
            LadezeitenSFML.AnzeigeEinzelneZeitOhneWarten (WelcheZeitExtern => WelcheZeitExtern);
      end case;
      
   end AnzeigeEinzelneZeitOhneWarten;
   
   
   
   procedure AnzeigeKIZeit
     (WelcheZeitExtern : in SystemDatentypen.Rassen_Enum)
   is begin
      
      case
        GlobaleVariablen.AnzeigeArt
      is
         when SystemDatentypen.Grafik_Konsole =>
            LadezeitenKonsole.AnzeigeKIZeit (WelcheZeitExtern => WelcheZeitExtern);
            
         when SystemDatentypen.Grafik_SFML =>
            LadezeitenSFML.AnzeigeKIZeit (WelcheZeitExtern => WelcheZeitExtern);
      end case;
      
   end AnzeigeKIZeit;

end Ladezeiten;
