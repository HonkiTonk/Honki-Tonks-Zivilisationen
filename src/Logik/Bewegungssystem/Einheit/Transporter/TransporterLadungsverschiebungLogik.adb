with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

package body TransporterLadungsverschiebungLogik is
   
   procedure LadungVerschieben
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      Transporterkapazität := LeseEinheitenDatenbank.Transportkapazität (SpeziesExtern => EinheitSpeziesNummerExtern.Spezies,
                                                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern));
      
      TransporterUmladenSchleife:
      for TransporterUmladenSchleifenwert in EinheitenRecords.TransporterArray'First .. Transporterkapazität loop
         
         Ladungsnummer := LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                             PlatzExtern                => TransporterUmladenSchleifenwert);
         
         case
           Ladungsnummer
         is
            when EinheitenKonstanten.LeerTransportiert =>
               null;
                     
            when others =>
               SchreibeEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, Ladungsnummer),
                                                    KoordinatenExtern          => NeueKoordinatenExtern,
                                                    EinheitentauschExtern      => False);
               
               -- Ruft sich hier selbst auf um Ladungen von Transportern die gerade transportiert werden ebenfalls zu verschieben.
               LadungVerschieben (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, Ladungsnummer),
                                  NeueKoordinatenExtern      => NeueKoordinatenExtern);
         end case;
         
      end loop TransporterUmladenSchleife;
      
   end LadungVerschieben;

end TransporterLadungsverschiebungLogik;
