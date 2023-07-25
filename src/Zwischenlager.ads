procedure EinlesenDateien
is begin

   case
     Projekteinstellungen.Debug.NormalerText
   is
      when True =>
         Einlesen (VerzeichnisExtern => (VerzeichnisKonstanten.Sprachenordner & To_Wide_Wide_String (Source => LeseOptionen.Sprache) & "/"));

      when False =>
         null;
   end case;

   Nullpfad := VerzeichnisKonstanten.Sprachenordner & LeseOptionen.Sprache & "/0";

   case
     Exists (Name => Encode (Item => To_Wide_Wide_String (Source => Nullpfad)))
   is
      when False =>
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.EinlesenDateien: Es fehlt: " & To_Wide_Wide_String (Source => Nullpfad));
         return;

      when True =>
         Dateienpfad := VerzeichnisKonstanten.Sprachenordner & LeseOptionen.Sprache & "/";

         Open (File => DateiVerzeichnisse,
               Mode => In_File,
               Name => Encode (Item => To_Wide_Wide_String (Source => Nullpfad)),
               Form => "WCEM=8");
   end case;

   EinlesenSchleife:
   for WelcheDateienSchleifenwert in 1 .. AnzahlTextdateien loop

      case
        EinlesenAllgemeinesLogik.VorzeitigesZeilenende (AktuelleDateiExtern => DateiVerzeichnisse,
                                                        AktuelleZeileExtern => WelcheDateienSchleifenwert)
      is
         when True =>
            Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinlesenTextLogik.EinlesenDateien: Fehlende Zeilen, aktuelle Zeile: " & WelcheDateienSchleifenwert'Wide_Wide_Image);
            exit EinlesenSchleife;

         when False =>
            EinlesenAufteilen (WelcheDateiExtern => WelcheDateienSchleifenwert,
                               VerzeichnisExtern => To_Wide_Wide_String (Source => Dateienpfad) & Get_Line (File => DateiVerzeichnisse));
      end case;

   end loop EinlesenSchleife;

   Close (File => DateiVerzeichnisse);
