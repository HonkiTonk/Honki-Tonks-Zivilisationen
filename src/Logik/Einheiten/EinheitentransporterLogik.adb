with EinheitenDatentypen; use EinheitenDatentypen;
with EinheitenKonstanten;
with KartenKonstanten;

with LeseEinheitenDatenbank;
with LeseEinheitenGebaut;

with TransporterSuchenLogik;
with KartenkoordinatenberechnungssystemLogik;
with EinheitSuchenLogik;
with PassierbarkeitspruefungLogik;
with BewegungspunkteBerechnenLogik;
with BewegungsberechnungEinheitenLogik;

package body EinheitentransporterLogik is   
   
   function KannTransportiertWerden
     (LadungExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      TransporterID := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => TransporterExtern);
      
      case
        TransporterID
      is
         when EinheitenKonstanten.LeerID =>
            return False;
            
         when others =>
            LadungID := LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => LadungExtern);
      end case;
            
      if
        EinheitenKonstanten.LeerKannTransportiertWerden = LeseEinheitenDatenbank.KannTransportiertWerden (RasseExtern => LadungExtern.Rasse,
                                                                                                          IDExtern    => LadungID)
        or
          LeseEinheitenDatenbank.KannTransportieren (RasseExtern => TransporterExtern.Rasse,
                                                     IDExtern    => TransporterID)
        < LeseEinheitenDatenbank.KannTransportiertWerden (RasseExtern => LadungExtern.Rasse,
                                                          IDExtern    => LadungID)
      then
         return False;
         
      else
         null;
      end if;
      
      case
        TransporterSuchenLogik.FreierPlatz (TransporterExtern => TransporterExtern)
      is
         when EinheitenKonstanten.LeerTransportkapazität =>
            return False;

         when others =>
            return True;
      end case;
      
   end KannTransportiertWerden;
   
   
   
   procedure TransporterEntladen
     (TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      Transporterkapazität := LeseEinheitenDatenbank.Transportkapazität (RasseExtern => TransporterExtern.Rasse,
                                                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => TransporterExtern));
      TransporterKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => TransporterExtern);
      
      TransporterAusladenSchleife:
      for TransporterAusladenSchleifenwert in EinheitenRecords.TransporterArray'First .. Transporterkapazität loop

         AktuelleLadung := LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => TransporterExtern,
                                                              PlatzExtern              => TransporterAusladenSchleifenwert);
         
         case
           AktuelleLadung
         is
            when EinheitenKonstanten.LeerTransportiert =>
               null;
               
            when others =>
               TransporterUmgebung (TranspoterKoordinatenExtern => TransporterKoordinaten,
                                    LadungExtern                => (TransporterExtern.Rasse, AktuelleLadung));
         end case;
               
      end loop TransporterAusladenSchleife;
      
   end TransporterEntladen;
   
   
   
   procedure TransporterUmgebung
     (TranspoterKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadungExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => TranspoterKoordinatenExtern,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              YAchseSchleifenwert = 0
              and
                XAchseSchleifenwert = 0
            then
               null;
               
            else
               case
                 Entladung (KoordinatenExtern => KartenWert,
                            LadungExtern      => LadungExtern)
               is
                  when True =>
                     BewegungsberechnungEinheitenLogik.Bewegungsberechnung (EinheitRasseNummerExtern => LadungExtern,
                                                                            NeueKoordinatenExtern    => KartenWert,
                                                                            EinheitentauschExtern    => False);
                     return;
                     
                  when False =>
                     null;
               end case;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end TransporterUmgebung;
   
   
   
   function Entladung
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadungExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
      
      EinheitVorhanden := EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => KoordinatenExtern,
                                                                                LogikGrafikExtern => True);
      
      case
        EinheitVorhanden.Nummer
      is
         when EinheitenKonstanten.LeerNummer =>
            null;
            
         when others =>
            return False;
      end case;
      
      case
        PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => LadungExtern,
                                                                  NeueKoordinatenExtern    => KoordinatenExtern)
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      if
        LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => LadungExtern) < BewegungspunkteBerechnenLogik.AbzugDurchBewegung (NeueKoordinatenExtern    => KoordinatenExtern,
                                                                                                                                           EinheitRasseNummerExtern => LadungExtern)
      then
         return False;
         
      else
         return True;
      end if;
      
   end Entladung;

end EinheitentransporterLogik;
