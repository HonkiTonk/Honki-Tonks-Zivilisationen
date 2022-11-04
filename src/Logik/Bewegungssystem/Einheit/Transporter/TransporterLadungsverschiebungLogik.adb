pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with EinheitenKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

package body TransporterLadungsverschiebungLogik is
   
   procedure LadungVerschieben
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      Transporterkapazität := LeseEinheitenDatenbank.Transportkapazität (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern));
      
      TransporterUmladenSchleife:
      for TransporterUmladenSchleifenwert in EinheitenRecords.TransporterArray'First .. Transporterkapazität loop
         
         Ladungsnummer := LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             PlatzExtern              => TransporterUmladenSchleifenwert);
         
         case
           Ladungsnummer
         is
            when EinheitenKonstanten.LeerTransportiert =>
               null;
                     
            when others =>
               SchreibeEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Ladungsnummer),
                                                    KoordinatenExtern        => NeueKoordinatenExtern,
                                                    EinheitentauschExtern    => False);
               
               -- Ruft sich hier selbst auf um Ladungen von Transportern die gerade transportiert werden ebenfalls zu verschieben.
               LadungVerschieben (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Ladungsnummer),
                                  NeueKoordinatenExtern    => NeueKoordinatenExtern);
         end case;
         
      end loop TransporterUmladenSchleife;
      
   end LadungVerschieben;

end TransporterLadungsverschiebungLogik;
