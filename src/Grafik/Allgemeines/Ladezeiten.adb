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
   
   
   
   procedure RundenendeNullsetzen
   is begin
      
      RundenendeZeit := (others => Clock);
      FortschrittRundenende := 0;
      
   end RundenendeNullsetzen;
   
   
   
   procedure SpeichernLadenNullsetzen
   is begin
      
      SpeichernLaden := (others => Clock);
      FortschrittSpeichernLaden := 0;
      
   end SpeichernLadenNullsetzen;
   
   
   
   procedure FortschrittSpielweltSchreiben
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.Spielwelt_Erstellen_Enum)
   is begin
      
      if
        FortschrittSpielwelt (WelcheBerechnungenExtern) + FortschrittSchritte (1) > LadezeitenDatentypen.Ladefortschritt'Last
      then
         Warnung.LogikWarnung (WarnmeldungExtern => "Ladezeiten.FortschrittSpielweltSchreiben - " & WelcheBerechnungenExtern'Wide_Wide_Image & " ist über 100.");
         
      else
         FortschrittSpielwelt (WelcheBerechnungenExtern) := FortschrittSpielwelt (WelcheBerechnungenExtern) + FortschrittSchritte (1);
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
        FortschrittKI (RasseExtern) + FortschrittSchritte (2) > LadezeitenDatentypen.Ladefortschritt'Last
      then
         Warnung.LogikWarnung (WarnmeldungExtern => "Ladezeiten.FortschrittKISchreiben - " & RasseExtern'Wide_Wide_Image & " ist über 100.");
         
      else
         FortschrittKI (RasseExtern) := FortschrittKI (RasseExtern) + FortschrittSchritte (2);
      end if;
      
   end FortschrittKISchreiben;
   
   
   
   procedure FortschrittKIMaximum
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      FortschrittKI (RasseExtern) := LadezeitenDatentypen.Ladefortschritt'Last;
      
   end FortschrittKIMaximum;
   
   
   
   procedure RundenendeSchreiben
   is begin
      
      if
        FortschrittRundenende + FortschrittSchritte (3) > LadezeitenDatentypen.Ladefortschritt'Last
      then
         Warnung.LogikWarnung (WarnmeldungExtern => "Ladezeiten.RundenendeSchreiben - Fortschritt ist über 100.");
         
      else
         FortschrittRundenende := FortschrittRundenende + FortschrittSchritte (3);
      end if;
      
   end RundenendeSchreiben;
   
   
   
   procedure RundenendeMaximum
   is begin
      
      FortschrittRundenende := LadezeitenDatentypen.Ladefortschritt'Last;
      
   end RundenendeMaximum;
   
   
   
   procedure SpeichernLadenSchreiben
     (SpeichernLadenExtern : in Boolean)
   is begin
      
      case
        SpeichernLadenExtern
      is
         when True =>
            if
              FortschrittSpeichernLaden + FortschrittSchritte (4) > LadezeitenDatentypen.Ladefortschritt'Last
            then
               Warnung.LogikWarnung (WarnmeldungExtern => "Ladezeiten.SpeichernSchreiben - Fortschritt ist über 100.");
         
            else
               FortschrittSpeichernLaden := FortschrittSpeichernLaden + FortschrittSchritte (4);
            end if;
            
         when False =>
            if
              FortschrittSpeichernLaden + FortschrittSchritte (5) > LadezeitenDatentypen.Ladefortschritt'Last
            then
               Warnung.LogikWarnung (WarnmeldungExtern => "Ladezeiten.LadenSchreiben - Fortschritt ist über 100.");
         
            else
               FortschrittSpeichernLaden := FortschrittSpeichernLaden + FortschrittSchritte (5);
            end if;
      end case;
      
   end SpeichernLadenSchreiben;
   
   
   
   procedure SpeichernLadenMaximum
   is begin
      
      FortschrittSpeichernLaden := LadezeitenDatentypen.Ladefortschritt'Last;
      
   end SpeichernLadenMaximum;

end Ladezeiten;
