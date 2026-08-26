



   procedure Speichern
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
