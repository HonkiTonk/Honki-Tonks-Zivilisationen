with LeseEinheitenGebaut;
with SchreibeEinheitenGebaut;
with LeseEinheitenDatenbank;

with TransporterSuchenLogik;
with TransporterLadungsverschiebungLogik;

-- Das Verschachteln mehrerer Transporter ineinander sollte keine Probleme mit regulären Einheiten machen.
-- Es muss nur darauf geachtet werden dass in der EinheitenDatenbank das KannTransportieren immer kleiner ist als KannTransportiertWerden.
-- Das vielleicht mal mit EinheitentransporterLogik/TransporterLadungsverschiebungLogik zusammenführen? äöü
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
      LadungExtern : in EinheitenDatentypen.EinheitenbereichVorhanden)
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
      LadungExtern : in EinheitenDatentypen.EinheitenbereichVorhanden)
   is
      use type EinheitenDatentypen.Einheitenbereich;
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
      
      LadungSortieren (TransporterExtern => TransporterExtern);
      
   end EinheitAusladen;
   
   
   
   procedure LadungSortieren
     (TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is
      use type EinheitenDatentypen.Transportplätze;
      use type EinheitenDatentypen.Einheitenbereich;
   begin
            
      LadungSchleife:
      for LadungSchleifenwert in EinheitenRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (SpeziesExtern => TransporterExtern.Spezies,
                                                                                                                        IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => TransporterExtern)) loop
         
         case
           LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => TransporterExtern,
                                              PlatzExtern                => LadungSchleifenwert)
         is
            when EinheitenKonstanten.LeerNummer =>
               NeueLadungSchleife:
               for NeueLadungSchleifenwert in reverse EinheitenRecords.TransporterArray'First
                 .. LeseEinheitenDatenbank.Transportkapazität (SpeziesExtern => TransporterExtern.Spezies,
                                                                IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => TransporterExtern)) loop
                                    
                  if
                    LadungSchleifenwert = NeueLadungSchleifenwert
                  then
                     exit LadungSchleife;
                     
                  elsif
                    EinheitenKonstanten.LeerNummer = LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => TransporterExtern,
                                                                                        PlatzExtern                => NeueLadungSchleifenwert)
                  then
                     null;
                     
                  else
                     SchreibeEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => TransporterExtern,
                                                            LadungExtern               => LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => TransporterExtern,
                                                                                                                             PlatzExtern                => NeueLadungSchleifenwert),
                                                            LadungsplatzExtern         => LadungSchleifenwert);
                     
                     SchreibeEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => TransporterExtern,
                                                            LadungExtern               => EinheitenKonstanten.LeerNummer,
                                                            LadungsplatzExtern         => NeueLadungSchleifenwert);
                     
                     exit NeueLadungSchleife;
                  end if;
                  
               end loop NeueLadungSchleife;
               
            when others =>
               null;
         end case;
         
      end loop LadungSchleife;
      
   end LadungSortieren;

end TransporterBeladenEntladenLogik;
