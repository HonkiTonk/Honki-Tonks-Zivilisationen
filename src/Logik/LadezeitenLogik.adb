with Fehlermeldungssystem;

package body LadezeitenLogik is
   
   procedure SpielweltNullsetzen
   is begin
      
      FortschrittSpielwelt := (others => AnfangLadezeit);
      
   end SpielweltNullsetzen;
   
   
   
   procedure KINullsetzenFortschritt
   is begin
      
      FortschrittKI := (others => AnfangLadezeit);
      
   end KINullsetzenFortschritt;
   
   
   
   procedure RundenendeNullsetzen
   is begin
      
      FortschrittRundenende := AnfangLadezeit;
      
   end RundenendeNullsetzen;
   
   
   
   procedure SpeichernLadenNullsetzen
   is begin
      
      FortschrittSpeichernLaden := AnfangLadezeit;
      
   end SpeichernLadenNullsetzen;
   
   
   
   procedure FortschrittSpielweltSchreiben
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.Spielwelt_Erstellen_Enum)
   is
      use type SystemDatentypen.NullBisHundert;
   begin
      
      if
        FortschrittSpielwelt (WelcheBerechnungenExtern) + FortschrittSchritte (1) > SystemDatentypen.NullBisHundert'Last
      then
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "LadezeitenLogik.FortschrittSpielweltSchreiben: " & WelcheBerechnungenExtern'Wide_Wide_Image & " > 100%");
         FortschrittSpielwelt (WelcheBerechnungenExtern) := SystemDatentypen.NullBisHundert'Last;
         
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
   is
      use type SystemDatentypen.NullBisHundert;
   begin
      
      if
        FortschrittKI (WelcheBerechnungenExtern) + FortschrittSchritte (2) > SystemDatentypen.NullBisHundert'Last
      then
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "LadezeitenLogik.FortschrittKISchreiben: " & WelcheBerechnungenExtern'Wide_Wide_Image & " > 100%");
         FortschrittKI (WelcheBerechnungenExtern) := SystemDatentypen.NullBisHundert'Last;
         
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
   is
      use type SystemDatentypen.NullBisHundert;
   begin
      
      if
        FortschrittRundenende + FortschrittSchritte (3) > SystemDatentypen.NullBisHundert'Last
      then
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "LadezeitenLogik.RundenendeSchreiben: Fortschritt > 100%");
         FortschrittRundenende := SystemDatentypen.NullBisHundert'Last;
         
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
   is
      use type SystemDatentypen.NullBisHundert;
   begin
      
      case
        SpeichernLadenExtern
      is
         when True =>
            if
              FortschrittSpeichernLaden + FortschrittSchritte (4) > SystemDatentypen.NullBisHundert'Last
            then
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "LadezeitenLogik.SpeichernSchreiben: Fortschritt > 100%");
               FortschrittSpeichernLaden := SystemDatentypen.NullBisHundert'Last;
         
            else
               FortschrittSpeichernLaden := FortschrittSpeichernLaden + FortschrittSchritte (4);
            end if;
            
         when False =>
            if
              FortschrittSpeichernLaden + FortschrittSchritte (5) > SystemDatentypen.NullBisHundert'Last
            then
               Fehlermeldungssystem.Logik (FehlermeldungExtern => "LadezeitenLogik.LadenSchreiben: Fortschritt > 100%");
               FortschrittSpeichernLaden := SystemDatentypen.NullBisHundert'Last;
         
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
