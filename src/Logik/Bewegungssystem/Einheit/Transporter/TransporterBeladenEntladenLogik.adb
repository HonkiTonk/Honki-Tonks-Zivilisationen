pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with EinheitenKonstanten;

with LeseEinheitenGebaut;
with SchreibeEinheitenGebaut;
with LeseEinheitenDatenbank;

with TransporterSuchenLogik;
with TransporterLadungsverschiebungLogik;

-- Das Verschachteln mehrerer Transporter ineinander sollte keine Probleme mit regulären Einheiten machen.
-- Es muss nur darauf geachtet werden dass in der EinheitenDatenbank das KannTransportieren immer kleiner ist als KannTransportiertWerden.
package body TransporterBeladenEntladenLogik is

   function TransporterBeladen
     (TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      LadungExtern : in EinheitenDatentypen.MaximaleEinheiten)
      return Boolean
   is begin
      
      FreierPlatzNummer := TransporterSuchenLogik.FreierPlatz (TransporterExtern => TransporterExtern);
      
      case
        FreierPlatzNummer
      is
         when EinheitenDatentypen.Transportplätze'First =>
            return False;
            
         when others =>
            AlterTransporter := LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern));
      end case;
            
      case
        AlterTransporter
      is
         when EinheitenKonstanten.LeerWirdTransportiert =>
            null;
               
         when others =>
            EinheitAusladen (TransporterExtern => (TransporterExtern.Rasse, AlterTransporter),
                             LadungExtern      => LadungExtern);
      end case;
            
      SchreibeEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => TransporterExtern,
                                             LadungExtern             => LadungExtern,
                                             LadungsplatzExtern       => FreierPlatzNummer);
      SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern),
                                               BewegungspunkteExtern    => EinheitenKonstanten.LeerBewegungspunkte,
                                               RechnenSetzenExtern      => False);
      SchreibeEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern),
                                                 TransporterExtern        => TransporterExtern.Nummer);
            
      NeueKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => TransporterExtern);
      SchreibeEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern),
                                           KoordinatenExtern        => NeueKoordinaten,
                                           EinheitentauschExtern    => False);
            
      TransporterLadungsverschiebungLogik.LadungVerschieben (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern),
                                                             NeueKoordinatenExtern    => NeueKoordinaten);
      
      return True;
      
   end TransporterBeladen;
   
   
   
   procedure EinheitAusladen
     (TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      LadungExtern : in EinheitenDatentypen.MaximaleEinheiten)
   is begin
      
      Transporterkapazität := LeseEinheitenDatenbank.Transportkapazität (RasseExtern => TransporterExtern.Rasse,
                                                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => TransporterExtern));
      
      TransporterLeerenSchleife:
      for TransporterLeerenSchleifenwert in EinheitenRecords.TransporterArray'First .. Transporterkapazität loop

         if
           LadungExtern = LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => TransporterExtern,
                                                             PlatzExtern              => TransporterLeerenSchleifenwert)
         then
            SchreibeEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => TransporterExtern,
                                                   LadungExtern             => EinheitenKonstanten.LeerTransportiert,
                                                   LadungsplatzExtern       => TransporterLeerenSchleifenwert);
            SchreibeEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern),
                                                       TransporterExtern        => EinheitenKonstanten.LeerWirdTransportiert);
            exit TransporterLeerenSchleife;
            
         else
            null;
         end if;
               
      end loop TransporterLeerenSchleife;
      
   end EinheitAusladen;

end TransporterBeladenEntladenLogik;
