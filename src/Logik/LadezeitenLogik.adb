pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with LadezeitenDatentypen; use LadezeitenDatentypen;

with Warnung;

package body LadezeitenLogik is
   
   procedure SpielweltNullsetzen
   is begin
      
      FortschrittSpielwelt := (others => 0);
      
   end SpielweltNullsetzen;
   
   
   
   procedure KINullsetzenFortschritt
   is begin
      
      FortschrittKI := (others => 0);
      
   end KINullsetzenFortschritt;
   
   
   
   procedure RundenendeNullsetzen
   is begin
      
      FortschrittRundenende := 0;
      
   end RundenendeNullsetzen;
   
   
   
   procedure SpeichernLadenNullsetzen
   is begin
      
      FortschrittSpeichernLaden := 0;
      
   end SpeichernLadenNullsetzen;
   
   
   
   procedure FortschrittSpielweltSchreiben
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.Spielwelt_Erstellen_Enum)
   is begin
      
      if
        FortschrittSpielwelt (WelcheBerechnungenExtern) + FortschrittSchritte (1) > LadezeitenDatentypen.Ladefortschritt'Last
      then
         FortschrittSpielwelt (WelcheBerechnungenExtern) := LadezeitenDatentypen.Ladefortschritt'Last;
         Warnung.LogikWarnung (WarnmeldungExtern => "Ladezeiten.FortschrittSpielweltSchreiben - " & WelcheBerechnungenExtern'Wide_Wide_Image & " über 100%.");
         
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
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.KI_Rechnet_Enum)
   is begin
      
      if
        FortschrittKI (WelcheBerechnungenExtern) + FortschrittSchritte (2) > LadezeitenDatentypen.Ladefortschritt'Last
      then
         FortschrittKI (WelcheBerechnungenExtern) := LadezeitenDatentypen.Ladefortschritt'Last;
         Warnung.LogikWarnung (WarnmeldungExtern => "Ladezeiten.FortschrittKISchreiben - " & WelcheBerechnungenExtern'Wide_Wide_Image & " über 100%.");
         
      else
         FortschrittKI (WelcheBerechnungenExtern) := FortschrittKI (WelcheBerechnungenExtern) + FortschrittSchritte (2);
      end if;
      
   end FortschrittKISchreiben;
   
   
   
   procedure FortschrittKIMaximum
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.KI_Rechnet_Enum)
   is begin
      
      FortschrittKI (WelcheBerechnungenExtern) := LadezeitenDatentypen.Ladefortschritt'Last;
      
   end FortschrittKIMaximum;
   
   
   
   -- Die folgenden Ladezeitanzeigen noch erweitern. äöü
   procedure RundenendeSchreiben
   is begin
      
      if
        FortschrittRundenende + FortschrittSchritte (3) > LadezeitenDatentypen.Ladefortschritt'Last
      then
         FortschrittRundenende := LadezeitenDatentypen.Ladefortschritt'Last;
         Warnung.LogikWarnung (WarnmeldungExtern => "Ladezeiten.RundenendeSchreiben - Fortschritt über 100%.");
         
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
               FortschrittSpeichernLaden := LadezeitenDatentypen.Ladefortschritt'Last;
               Warnung.LogikWarnung (WarnmeldungExtern => "Ladezeiten.SpeichernSchreiben - Fortschritt über 100%.");
         
            else
               FortschrittSpeichernLaden := FortschrittSpeichernLaden + FortschrittSchritte (4);
            end if;
            
         when False =>
            if
              FortschrittSpeichernLaden + FortschrittSchritte (5) > LadezeitenDatentypen.Ladefortschritt'Last
            then
               FortschrittSpeichernLaden := LadezeitenDatentypen.Ladefortschritt'Last;
               Warnung.LogikWarnung (WarnmeldungExtern => "Ladezeiten.LadenSchreiben - Fortschritt über 100%.");
         
            else
               FortschrittSpeichernLaden := FortschrittSpeichernLaden + FortschrittSchritte (5);
            end if;
      end case;
      
   end SpeichernLadenSchreiben;
   
   
   
   procedure SpeichernLadenMaximum
   is begin
      
      FortschrittSpeichernLaden := LadezeitenDatentypen.Ladefortschritt'Last;
      
   end SpeichernLadenMaximum;

end LadezeitenLogik;
