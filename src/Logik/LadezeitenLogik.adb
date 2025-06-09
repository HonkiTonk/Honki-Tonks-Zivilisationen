with MeldungssystemHTSEB;

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
      use type SystemDatentypenHTSEB.NullBisHundert;
   begin
      
      if
        FortschrittSpielwelt (WelcheBerechnungenExtern) + FortschrittSchritte (1) > EndeLadezeit
      then
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadezeitenLogik.FortschrittSpielweltSchreiben: " & WelcheBerechnungenExtern'Wide_Wide_Image & " > 100%");
         FortschrittSpielwelt (WelcheBerechnungenExtern) := EndeLadezeit;
         
      else
         FortschrittSpielwelt (WelcheBerechnungenExtern) := FortschrittSpielwelt (WelcheBerechnungenExtern) + FortschrittSchritte (1);
      end if;
      
   end FortschrittSpielweltSchreiben;
   
   
   
   procedure FortschrittSpielweltMaximum
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.Spielwelt_Erstellen_Enum)
   is begin
   
      FortschrittSpielwelt (WelcheBerechnungenExtern) := EndeLadezeit;
      
   end FortschrittSpielweltMaximum;
   
   
   
   procedure FortschrittKISchreiben
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.KI_Rechnet_Enum)
   is
      use type SystemDatentypenHTSEB.NullBisHundert;
   begin
      
      if
        FortschrittKI (WelcheBerechnungenExtern) + FortschrittSchritte (2) > EndeLadezeit
      then
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadezeitenLogik.FortschrittKISchreiben: " & WelcheBerechnungenExtern'Wide_Wide_Image & " > 100%");
         FortschrittKI (WelcheBerechnungenExtern) := EndeLadezeit;
         
      else
         FortschrittKI (WelcheBerechnungenExtern) := FortschrittKI (WelcheBerechnungenExtern) + FortschrittSchritte (2);
      end if;
      
   end FortschrittKISchreiben;
   
   
   
   procedure FortschrittKIMaximum
     (WelcheBerechnungenExtern : in LadezeitenDatentypen.KI_Rechnet_Enum)
   is begin
      
      FortschrittKI (WelcheBerechnungenExtern) := EndeLadezeit;
      
   end FortschrittKIMaximum;
   
   
   
   -- Die folgenden Ladezeitanzeigen noch erweitern. äöü
   procedure RundenendeSchreiben
   is
      use type SystemDatentypenHTSEB.NullBisHundert;
   begin
      
      if
        FortschrittRundenende + FortschrittSchritte (3) > EndeLadezeit
      then
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadezeitenLogik.RundenendeSchreiben: Fortschritt > 100%");
         FortschrittRundenende := EndeLadezeit;
         
      else
         FortschrittRundenende := FortschrittRundenende + FortschrittSchritte (3);
      end if;
      
   end RundenendeSchreiben;
   
   
   
   procedure RundenendeMaximum
   is begin
      
      FortschrittRundenende := EndeLadezeit;
      
   end RundenendeMaximum;
   
   
   
   procedure SpeichernLadenSchreiben
     (SpeichernLadenExtern : in Boolean)
   is
      use type SystemDatentypenHTSEB.NullBisHundert;
   begin
      
      case
        SpeichernLadenExtern
      is
         when True =>
            if
              FortschrittSpeichernLaden + FortschrittSchritte (4) > EndeLadezeit
            then
               MeldungssystemHTSEB.Logik (MeldungExtern => "LadezeitenLogik.SpeichernSchreiben: Fortschritt > 100%");
               FortschrittSpeichernLaden := EndeLadezeit;
         
            else
               FortschrittSpeichernLaden := FortschrittSpeichernLaden + FortschrittSchritte (4);
            end if;
            
         when False =>
            if
              FortschrittSpeichernLaden + FortschrittSchritte (5) > EndeLadezeit
            then
               MeldungssystemHTSEB.Logik (MeldungExtern => "LadezeitenLogik.LadenSchreiben: Fortschritt > 100%");
               FortschrittSpeichernLaden := EndeLadezeit;
         
            else
               FortschrittSpeichernLaden := FortschrittSpeichernLaden + FortschrittSchritte (5);
            end if;
      end case;
      
   end SpeichernLadenSchreiben;
   
   
   
   procedure SpeichernLadenMaximum
   is begin
      
      FortschrittSpeichernLaden := EndeLadezeit;
      
   end SpeichernLadenMaximum;
   
   
   
   procedure SpeichernNullsetzen
   is begin
      
      FortschrittSpeichern := (others => AnfangLadezeit);
      
   end SpeichernNullsetzen;
   
   
   
   procedure Speichern
     (WelcheBerechnungszeitExtern : in LadezeitenDatentypen.Speichern_Neu_Enum;
      ErhöhungExtern : in SystemDatentypenHTSEB.NullBisHundert)
   is
      use type SystemDatentypenHTSEB.NullBisHundert;
   begin
      
      if
        FortschrittSpeichern (WelcheBerechnungszeitExtern) + ErhöhungExtern > EndeLadezeit
      then
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadezeitenLogik.Speichern: Fortschritt > 100%");
         FortschrittSpeichern (WelcheBerechnungszeitExtern) := EndeLadezeit;
         
      else
         FortschrittSpeichern (WelcheBerechnungszeitExtern) := FortschrittSpeichern (WelcheBerechnungszeitExtern) + ErhöhungExtern;
      end if;
      
   end Speichern;
   
   
   
   procedure SpeichernMaximum
     (WelcheBerechnungszeitExtern : in LadezeitenDatentypen.Speichern_Neu_Enum)
   is begin
      
      FortschrittSpeichern (WelcheBerechnungszeitExtern) := EndeLadezeit;
      
   end SpeichernMaximum;

end LadezeitenLogik;
