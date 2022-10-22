pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with SystemDatentypen; use SystemDatentypen;

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
        FortschrittSpielwelt (WelcheBerechnungenExtern) + FortschrittSchritte (1) > SystemDatentypen.NullBisHundert'Last
      then
         FortschrittSpielwelt (WelcheBerechnungenExtern) := SystemDatentypen.NullBisHundert'Last;
         Warnung.LogikWarnung (WarnmeldungExtern => "Ladezeiten.FortschrittSpielweltSchreiben: " & WelcheBerechnungenExtern'Wide_Wide_Image & " > 100%.");
         
      else
         FortschrittSpielwelt (WelcheBerechnungenExtern) := FortschrittSpielwelt (WelcheBerechnungenExtern) + FortschrittSchritte (1);
      end if;
      
   end FortschrittSpielweltSchreiben;
   
   
   
   procedure FortschrittSpielweltMaximum
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.Spielwelt_Erstellen_Enum)
   is begin
   
      FortschrittSpielwelt (WelcheBerechnungenExtern) := SystemDatentypen.NullBisHundert'Last;
      
   end FortschrittSpielweltMaximum;
   
   
   
   procedure FortschrittKISchreiben
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.KI_Rechnet_Enum)
   is begin
      
      if
        FortschrittKI (WelcheBerechnungenExtern) + FortschrittSchritte (2) > SystemDatentypen.NullBisHundert'Last
      then
         FortschrittKI (WelcheBerechnungenExtern) := SystemDatentypen.NullBisHundert'Last;
         Warnung.LogikWarnung (WarnmeldungExtern => "Ladezeiten.FortschrittKISchreiben: " & WelcheBerechnungenExtern'Wide_Wide_Image & " > 100%.");
         
      else
         FortschrittKI (WelcheBerechnungenExtern) := FortschrittKI (WelcheBerechnungenExtern) + FortschrittSchritte (2);
      end if;
      
   end FortschrittKISchreiben;
   
   
   
   procedure FortschrittKIMaximum
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.KI_Rechnet_Enum)
   is begin
      
      FortschrittKI (WelcheBerechnungenExtern) := SystemDatentypen.NullBisHundert'Last;
      
   end FortschrittKIMaximum;
   
   
   
   -- Die folgenden Ladezeitanzeigen noch erweitern. äöü
   procedure RundenendeSchreiben
   is begin
      
      if
        FortschrittRundenende + FortschrittSchritte (3) > SystemDatentypen.NullBisHundert'Last
      then
         FortschrittRundenende := SystemDatentypen.NullBisHundert'Last;
         Warnung.LogikWarnung (WarnmeldungExtern => "Ladezeiten.RundenendeSchreiben: Fortschritt > 100%.");
         
      else
         FortschrittRundenende := FortschrittRundenende + FortschrittSchritte (3);
      end if;
      
   end RundenendeSchreiben;
   
   
   
   procedure RundenendeMaximum
   is begin
      
      FortschrittRundenende := SystemDatentypen.NullBisHundert'Last;
      
   end RundenendeMaximum;
   
   
   
   procedure SpeichernLadenSchreiben
     (SpeichernLadenExtern : in Boolean)
   is begin
      
      case
        SpeichernLadenExtern
      is
         when True =>
            if
              FortschrittSpeichernLaden + FortschrittSchritte (4) > SystemDatentypen.NullBisHundert'Last
            then
               FortschrittSpeichernLaden := SystemDatentypen.NullBisHundert'Last;
               Warnung.LogikWarnung (WarnmeldungExtern => "Ladezeiten.SpeichernSchreiben: Fortschritt > 100%.");
         
            else
               FortschrittSpeichernLaden := FortschrittSpeichernLaden + FortschrittSchritte (4);
            end if;
            
         when False =>
            if
              FortschrittSpeichernLaden + FortschrittSchritte (5) > SystemDatentypen.NullBisHundert'Last
            then
               FortschrittSpeichernLaden := SystemDatentypen.NullBisHundert'Last;
               Warnung.LogikWarnung (WarnmeldungExtern => "Ladezeiten.LadenSchreiben: Fortschritt > 100%.");
         
            else
               FortschrittSpeichernLaden := FortschrittSpeichernLaden + FortschrittSchritte (5);
            end if;
      end case;
      
   end SpeichernLadenSchreiben;
   
   
   
   procedure SpeichernLadenMaximum
   is begin
      
      FortschrittSpeichernLaden := SystemDatentypen.NullBisHundert'Last;
      
   end SpeichernLadenMaximum;

end LadezeitenLogik;
