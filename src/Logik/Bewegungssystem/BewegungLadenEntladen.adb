pragma SPARK_Mode (On);

pragma Warnings (Off, "*array aggregate*");
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with EinheitenKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;
with LeseEinheitenDatenbank;

with UmgebungErreichbarTesten;

package body BewegungLadenEntladen is

   procedure TransporterBeladen
     (TransporterExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      LadungExtern : in EinheitStadtDatentypen.MaximaleEinheiten)
   is begin
      
      FreierPlatzNummer := FreienPlatzErmitteln (TransporterExtern => TransporterExtern);
      
      case
        FreierPlatzNummer
      is
         when EinheitStadtDatentypen.Transportwerte'First =>
            null;
            
         when others =>
            if
              LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern)) /= EinheitenKonstanten.LeerWirdTransportiert
            then
               EinheitAusTransporterEntfernen (TransporterExtern => (TransporterExtern.Rasse, LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern))),
                                               LadungExtern      => LadungExtern);
         
            else
               null;
            end if;
            SchreibeEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => TransporterExtern,
                                                   LadungExtern             => LadungExtern,
                                                   LadungsplatzExtern       => FreierPlatzNummer);
            SchreibeEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern),
                                                     BewegungspunkteExtern    => EinheitenKonstanten.LeerEinheit.Bewegungspunkte,
                                                     RechnenSetzenExtern      => 0);
            SchreibeEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern),
                                                 KoordinatenExtern        => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => TransporterExtern));
            SchreibeEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern),
                                                       TransporterExtern        => TransporterExtern.Platznummer);
            GlobaleVariablen.CursorImSpiel (TransporterExtern.Rasse).KoordinatenAktuell := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => (TransporterExtern.Rasse, LadungExtern));
      end case;
      
   end TransporterBeladen;
   
   
   
   -- Ist das nicht identisch mit dem Zeug in TransporterSuchen?
   function FreienPlatzErmitteln
     (TransporterExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return EinheitStadtDatentypen.Transportwerte
   is begin
      
      TransporterSchleife:
      for FreierPlatzSchleifenwert in EinheitStadtRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => TransporterExtern.Rasse,
                                                                                                                                IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => TransporterExtern)) loop
        
         case
           LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => TransporterExtern,
                                              PlatzExtern              => FreierPlatzSchleifenwert)
         is
            when EinheitenKonstanten.LeerTransportiert =>
               return FreierPlatzSchleifenwert;
               
            when others =>
               null;
         end case;
         
      end loop TransporterSchleife;
      
      return EinheitStadtDatentypen.Transportwerte'First;
      
   end FreienPlatzErmitteln;
     
      
   
   procedure EinheitAusTransporterEntfernen
     (TransporterExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      LadungExtern : in EinheitStadtDatentypen.MaximaleEinheiten)
   is begin
      
      TransporterLeerenSchleife:
      for
        TransporterLeerenSchleifenwert
      in
        EinheitStadtRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => TransporterExtern.Rasse,
                                                                                                  IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => TransporterExtern)) loop

         if
           LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => TransporterExtern,
                                              PlatzExtern              => TransporterLeerenSchleifenwert)
           = LadungExtern
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
      
   end EinheitAusTransporterEntfernen;
   
   
   
   procedure TransporterladungVerschieben
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      TransporterUmladenSchleife:
      for TransporterUmladenSchleifenwert in EinheitStadtRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                                       IDExtern    =>
                                                                                                                                         LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) loop
               
         case
           LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              PlatzExtern              => TransporterUmladenSchleifenwert)
         is
            when EinheitenKonstanten.LeerTransportiert =>
               null;
                     
            when others =>
               SchreibeEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                                    PlatzExtern              => TransporterUmladenSchleifenwert)),
                                                    KoordinatenExtern        => NeueKoordinatenExtern);
         end case;
               
      end loop TransporterUmladenSchleife;
      
   end TransporterladungVerschieben;
   
   
   
   procedure TransporterStadtEntladen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
            
      BelegterPlatzSchleife:
      for BelegterPlatzSchleifenwert in EinheitStadtRecords.TransporterArray'First .. LeseEinheitenDatenbank.Transportkapazität (RasseExtern => EinheitRasseNummerExtern.Rasse,
                                                                                                                                  IDExtern    =>
                                                                                                                                    LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern)) loop
         
         case
           LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              PlatzExtern              => BelegterPlatzSchleifenwert)
         is
            when EinheitenKonstanten.LeerTransportiert =>
               null;
               
            when others => -- -----------------
               SchreibeEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                                    PlatzExtern              => BelegterPlatzSchleifenwert)),
                                                    KoordinatenExtern        =>
                                                       UmgebungErreichbarTesten.UmgebungErreichbarTesten (AktuelleKoordinatenExtern => NeueKoordinatenExtern,
                                                                                                          RasseExtern               => EinheitRasseNummerExtern.Rasse,
                                                                                                          IDExtern                  =>
                                                                                                             LeseEinheitenGebaut.ID (EinheitRasseNummerExtern =>
                                                                                                                                       (EinheitRasseNummerExtern.Rasse,
                                                                                                                                        LeseEinheitenGebaut.Transportiert
                                                                                                                                          (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                           PlatzExtern              => BelegterPlatzSchleifenwert))),
                                                                                                          NotwendigeFelderExtern    => 1));
               SchreibeEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                                          PlatzExtern              => BelegterPlatzSchleifenwert)),
                                                          TransporterExtern        => EinheitenKonstanten.LeerWirdTransportiert);
         end case;
         
      end loop BelegterPlatzSchleife;
      
      GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Transportiert := (others => EinheitenKonstanten.LeerTransportiert);
      
   end TransporterStadtEntladen;

end BewegungLadenEntladen;
