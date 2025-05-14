function Sichtbarkeit
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      DateiSpeichernExtern : in File_Type)
      return Boolean
   is
      use type SystemDatentypenHTSEB.EinByte;
   begin

      GesamteSichtbarkeit := LeseWeltkarte.GesamteSichtbarkeit (KoordinatenExtern => KoordinatenExtern);

      BereichSchleife:
      for BereichSchleifenwert in SpeziesKonstanten.SpeziesanfangLadenSpeichernArray'Range loop

         SichtbarkeitVorhanden := 0;
         AktuelleSichtbarkeit := 1;

         SichtbarkeitSchleife:
         for SichtbarkeitSchleifenwert in SpeziesKonstanten.SpeziesanfangSpeichernLaden (BereichSchleifenwert) .. SpeziesKonstanten.SpeziesendeSpeichernLaden (BereichSchleifenwert) loop

            case
              GesamteSichtbarkeit (SichtbarkeitSchleifenwert)
            is
               when True =>
                  SichtbarkeitVorhanden := SichtbarkeitVorhanden + AktuelleSichtbarkeit;

               when False =>
                  null;
            end case;

            AktuelleSichtbarkeit := AktuelleSichtbarkeit * 2;

         end loop SichtbarkeitSchleife;

         SystemDatentypenHTSEB.EinByte'Write (Stream (File => DateiSpeichernExtern),
                                              SichtbarkeitVorhanden);

      end loop BereichSchleife;

      return True;

   exception
      when StandardAdaFehler : others =>
         MeldungssystemHTSEB.Logik (MeldungExtern => "SpeichernSichtbarkeitLogik.Sichtbarkeit: Konnte nicht gespeichert werden: "
                                    & UmwandlungssystemHTSEB.Decode (TextExtern => Exception_Information (X => StandardAdaFehler)));
         return False;

   end Sichtbarkeit;
