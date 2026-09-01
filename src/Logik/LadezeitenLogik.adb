with MeldungssystemHTSEB;

package body LadezeitenLogik is
   
   procedure SpielweltNullsetzen
   is begin
      
      FortschrittSpielwelt := (others => AnfangLadezeit);
      
   end SpielweltNullsetzen;
   
   
   
   procedure FortschrittSpielweltSchreiben
     (BerechnungszeitExtern : in LadezeitenDatentypen.Spielwelt_Erstellen_Enum)
   is
      use type SystemDatentypenHTSEB.NullBisHundert;
   begin
      
      if
        FortschrittSpielwelt (BerechnungszeitExtern) + FortschrittSchritte (1) > EndeLadezeit
      then
         MeldungssystemHTSEB.Logik (MeldungExtern => "LadezeitenLogik.FortschrittSpielweltSchreiben: " & BerechnungszeitExtern'Wide_Wide_Image & " > 100%");
         FortschrittSpielwelt (BerechnungszeitExtern) := EndeLadezeit;
         
      else
         FortschrittSpielwelt (BerechnungszeitExtern) := FortschrittSpielwelt (BerechnungszeitExtern) + FortschrittSchritte (1);
      end if;
      
   end FortschrittSpielweltSchreiben;
   
   
   
   procedure FortschrittSpielweltMaximum
     (BerechnungszeitExtern : in LadezeitenDatentypen.Spielwelt_Erstellen_Enum)
   is begin
   
      FortschrittSpielwelt (BerechnungszeitExtern) := EndeLadezeit;
      
   end FortschrittSpielweltMaximum;
   
   
   
   procedure KINullsetzenFortschritt
   is begin
      
      FortschrittKI := (others => AnfangLadezeit);
      
   end KINullsetzenFortschritt;
   
   
   
   procedure KISchreiben
     (BerechnungszeitExtern : in LadezeitenDatentypen.KI_Rechnet_Enum;
      ZeitExtern : in Float)
   is begin
      
      FortschrittKI (BerechnungszeitExtern) := SystemDatentypenHTSEB.NullBisHundert (ZeitExtern);
      
   end KISchreiben;
   
   
   
   procedure KIMaximum
     (BerechnungszeitExtern : in LadezeitenDatentypen.KI_Rechnet_Enum)
   is begin
      
      FortschrittKI (BerechnungszeitExtern) := EndeLadezeit;
      
   end KIMaximum;
   
      
   
   procedure RundenendeNullsetzen
   is begin
      
      FortschrittRundenende := AnfangLadezeit;
      
   end RundenendeNullsetzen;
   
   
   
   procedure RundenendeSchreiben
      (ZeitExtern : in Float)
   is begin
      
      FortschrittRundenende := SystemDatentypenHTSEB.NullBisHundert (ZeitExtern);
      
   end RundenendeSchreiben;
   
   
   
   procedure RundenendeMaximum
   is begin
      
      FortschrittRundenende := EndeLadezeit;
      
   end RundenendeMaximum;
   
   
   
   procedure SpeichernLadenNullsetzen
   is begin
      
      FortschrittSpeichernLaden := (others => AnfangLadezeit);
      
   end SpeichernLadenNullsetzen;
   
   
   
   procedure SpeichernLaden
     (BerechnungszeitExtern : in LadezeitenDatentypen.Speichern_Laden_Enum;
      ZeitExtern : in Float)
   is begin
      
      FortschrittSpeichernLaden (BerechnungszeitExtern) := SystemDatentypenHTSEB.NullBisHundert (ZeitExtern);
      
   end SpeichernLaden;
   
   
   
   procedure SpeichernLadenMaximum
     (BerechnungszeitExtern : in LadezeitenDatentypen.Speichern_Laden_Enum)
   is begin
      
      FortschrittSpeichernLaden (BerechnungszeitExtern) := EndeLadezeit;
      
   end SpeichernLadenMaximum;

end LadezeitenLogik;
