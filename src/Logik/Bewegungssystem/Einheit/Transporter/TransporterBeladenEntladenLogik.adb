with LeseEinheitenGebaut;
with SchreibeEinheitenGebaut;
with LeseEinheitenDatenbank;

with TransporterSuchenLogik;
with TransporterLadungsverschiebungLogik;

-- Das Verschachteln mehrerer Transporter ineinander sollte keine Probleme mit regulären Einheiten machen.
-- Es muss nur darauf geachtet werden dass in der EinheitenDatenbank das KannTransportieren immer kleiner ist als KannTransportiertWerden.
package body TransporterBeladenEntladenLogik is
   
   function IstTransporterBeladbar
     (TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
      
      case
        TransporterSuchenLogik.FreierPlatz (TransporterExtern => TransporterExtern)
      is
         when EinheitenDatentypen.Transportplätze'First =>
            return False;
            
         when others =>
            return True;
      end case;
      
   end IstTransporterBeladbar;
   
   

   function TransporterBeladen
     (TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
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
            AlterTransporter := LeseEinheitenGebaut.WirdTransportiert (EinheitSpeziesNummerExtern => (TransporterExtern.Spezies, LadungExtern));
      end case;
            
      case
        AlterTransporter
      is
         when EinheitenKonstanten.LeerWirdTransportiert =>
            null;
               
         when others =>
            EinheitAusladen (TransporterExtern => (TransporterExtern.Spezies, AlterTransporter),
                             LadungExtern      => LadungExtern);
      end case;
            
      SchreibeEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => TransporterExtern,
                                             LadungExtern               => LadungExtern,
                                             LadungsplatzExtern         => FreierPlatzNummer);
      SchreibeEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => (TransporterExtern.Spezies, LadungExtern),
                                               BewegungspunkteExtern      => EinheitenKonstanten.LeerBewegungspunkte,
                                               RechnenSetzenExtern        => False);
      SchreibeEinheitenGebaut.WirdTransportiert (EinheitSpeziesNummerExtern => (TransporterExtern.Spezies, LadungExtern),
                                                 TransporterExtern          => TransporterExtern.Nummer);
            
      NeueKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => TransporterExtern);
      SchreibeEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => (TransporterExtern.Spezies, LadungExtern),
                                           KoordinatenExtern          => NeueKoordinaten,
                                           EinheitentauschExtern      => False);
            
      TransporterLadungsverschiebungLogik.LadungVerschieben (EinheitSpeziesNummerExtern => (TransporterExtern.Spezies, LadungExtern),
                                                             NeueKoordinatenExtern      => NeueKoordinaten);
      
      return True;
      
   end TransporterBeladen;
   
   
   
   procedure EinheitAusladen
     (TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      LadungExtern : in EinheitenDatentypen.MaximaleEinheiten)
   is
      use type EinheitenDatentypen.MaximaleEinheitenMitNullWert;
   begin
      
      Transporterkapazität := LeseEinheitenDatenbank.Transportkapazität (SpeziesExtern => TransporterExtern.Spezies,
                                                                           IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => TransporterExtern));
      
      TransporterLeerenSchleife:
      for TransporterLeerenSchleifenwert in EinheitenRecords.TransporterArray'First .. Transporterkapazität loop

         if
           LadungExtern = LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => TransporterExtern,
                                                             PlatzExtern                => TransporterLeerenSchleifenwert)
         then
            SchreibeEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => TransporterExtern,
                                                   LadungExtern               => EinheitenKonstanten.LeerTransportiert,
                                                   LadungsplatzExtern         => TransporterLeerenSchleifenwert);
            SchreibeEinheitenGebaut.WirdTransportiert (EinheitSpeziesNummerExtern => (TransporterExtern.Spezies, LadungExtern),
                                                       TransporterExtern          => EinheitenKonstanten.LeerWirdTransportiert);
            exit TransporterLeerenSchleife;
            
         else
            null;
         end if;
               
      end loop TransporterLeerenSchleife;
      
   end EinheitAusladen;

end TransporterBeladenEntladenLogik;
