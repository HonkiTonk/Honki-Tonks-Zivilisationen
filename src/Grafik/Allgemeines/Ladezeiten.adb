pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with LadezeitenDatentypen; use LadezeitenDatentypen;

with Warnung;

package body Ladezeiten is
   
   procedure SpielweltNullsetzen
   is begin
      
      SpielweltErstellen := (others => (others => Clock));
      FortschrittSpielwelt := (others => 0);
      
   end SpielweltNullsetzen;
   
   
   
   procedure KINullsetzen
   is begin
      
      KIZeiten := (others => (others => Clock));
      FortschrittKI := (others => 0);
      
   end KINullsetzen;
   
   
   procedure FortschrittSpielweltSchreiben
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.Spielwelt_Erstellen_Enum)
   is begin
      
      if
        FortschrittSpielwelt (WelcheBerechnungenExtern) + 1 > LadezeitenDatentypen.Ladefortschritt'Last
      then
         Warnung.LogikWarnung (WarnmeldungExtern => "Ladezeiten.FortschrittSpielweltSchreiben - " & WelcheBerechnungenExtern'Wide_Wide_Image & " ist über 100.");
         
      else
         FortschrittSpielwelt (WelcheBerechnungenExtern) := FortschrittSpielwelt (WelcheBerechnungenExtern) + 1;
      end if;
      
   end FortschrittSpielweltSchreiben;
   
   
   
   procedure FortschrittSpielweltMaximum
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.Spielwelt_Erstellen_Enum)
   is begin
   
      FortschrittSpielwelt (WelcheBerechnungenExtern) := LadezeitenDatentypen.Ladefortschritt'Last;
      
   end FortschrittSpielweltMaximum;
   
   
   
   procedure FortschrittKISchreiben
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      if
        FortschrittKI (RasseExtern) + 25 > LadezeitenDatentypen.Ladefortschritt'Last
      then
         Warnung.LogikWarnung (WarnmeldungExtern => "Ladezeiten.FortschrittKISchreiben - " & RasseExtern'Wide_Wide_Image & " ist über 100.");
         
      else
         FortschrittKI (RasseExtern) := FortschrittKI (RasseExtern) + 25;
      end if;
      
   end FortschrittKISchreiben;

end Ladezeiten;
