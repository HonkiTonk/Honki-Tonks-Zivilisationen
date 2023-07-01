procedure Einheitensortierung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin

      Einheitengrenze := LeseGrenzen.Einheitengrenze (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies);

      if
        EinheitSpeziesNummerExtern.Nummer = Einheitengrenze
      then
         return;

      elsif
        EinheitSpeziesNummerExtern.Nummer > Einheitengrenze
      then
         Fehlermeldungssystem.Logik (FehlermeldungExtern => "EinheitenErzeugenEntfernenLogik.EinheitenSortieren - Platz außerhalb der Einheitengrenze");
         return;

      else
         Sortierungsnummer := EinheitenKonstanten.LeerNummer;
      end if;

      EinheitenSchleife:
      for EinheitenSchleifenwert in reverse EinheitSpeziesNummerExtern.Nummer + 1 .. Einheitengrenze loop

         case
           LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, EinheitenSchleifenwert))
         is
            when EinheitenKonstanten.LeerID =>
               null;

            when others =>
               Sortierungsnummer := EinheitenSchleifenwert;
               exit EinheitenSchleife;
         end case;

      end loop EinheitenSchleife;

      case
        Sortierungsnummer
      is
         when EinheitenKonstanten.LeerNummer =>
            return;

         when others =>
            SchreibeEinheitenGebaut.GanzerEintrag (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                   EintragExtern              => LeseEinheitenGebaut.GanzerEintrag (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, Sortierungsnummer)));

            Transporternummer := LeseEinheitenGebaut.WirdTransportiert (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, Sortierungsnummer));
      end case;

      -- Das hier (und vermutlich auch das Zeug darüber) bereitet Probleme, wenn man einen Transporter mit beladenen Transportern entfernt. äöü
      -- Oder überhaupt einen beladenen Transporter. äöü
      -- Erst alles entfernen und dann Sortieren? äöü
      case
        Transporternummer
      is
         when EinheitenKonstanten.LeerNummer =>
            null;

         when others =>
            EinheitentransporterLogik.LadungsnummerAnpassen (TransporterExtern      => (EinheitSpeziesNummerExtern.Spezies, Transporternummer),
                                                             LadungsnummerAltExtern => Sortierungsnummer,
                                                             LadungsnummerNeuExtern => EinheitSpeziesNummerExtern.Nummer);
      end case;

      EinheitentransporterLogik.LadungAnpassen (TransporterExtern => EinheitSpeziesNummerExtern);

      -- Das sollte nicht nötig sein, da SchreibeWeltkarte.EinheitSchreiben mit EinheitentauschExtern => True den Kartenwert überschreibt.
      -- SchreibeWeltkarte.EinheitEntfernen (KoordinatenExtern          => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, Sortierungsnummer)),
      --                                     EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, Sortierungsnummer));

      SchreibeEinheitenGebaut.GanzerEintrag (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, Sortierungsnummer),
                                             EintragExtern              => EinheitenRecordKonstanten.LeerEinheit);

      SchreibeWeltkarte.EinheitSchreiben (KoordinatenExtern          => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern),
                                          EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                          EinheitentauschExtern      => True);

   end Einheitensortierung;
