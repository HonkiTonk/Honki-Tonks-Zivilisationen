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
     (LadungExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type EinheitenDatentypen.Transport_Enum;
   begin
      
      TransporterID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => TransporterExtern);
      
      case
        TransporterID
      is
         when EinheitenKonstanten.LeerID =>
            return False;
            
         when others =>
            LadungID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => LadungExtern);
      end case;
            
      if
        EinheitenKonstanten.LeerKannTransportiertWerden = LeseEinheitenDatenbank.KannTransportiertWerden (SpeziesExtern => LadungExtern.Spezies,
                                                                                                          IDExtern    => LadungID)
        or
          LeseEinheitenDatenbank.KannTransportieren (SpeziesExtern => TransporterExtern.Spezies,
                                                     IDExtern    => TransporterID)
        < LeseEinheitenDatenbank.KannTransportiertWerden (SpeziesExtern => LadungExtern.Spezies,
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
     (TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
   is begin
      
      Transporterkapazität := LeseEinheitenDatenbank.Transportkapazität (SpeziesExtern => TransporterExtern.Spezies,
                                                                           IDExtern    => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => TransporterExtern));
      TransporterKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => TransporterExtern);
      
      TransporterAusladenSchleife:
      for TransporterAusladenSchleifenwert in EinheitenRecords.TransporterArray'First .. Transporterkapazität loop

         AktuelleLadung := LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => TransporterExtern,
                                                              PlatzExtern              => TransporterAusladenSchleifenwert);
         
         case
           AktuelleLadung
         is
            when EinheitenKonstanten.LeerTransportiert =>
               null;
               
            when others =>
               TransporterUmgebung (TranspoterKoordinatenExtern => TransporterKoordinaten,
                                    LadungExtern                => (TransporterExtern.Spezies, AktuelleLadung));
         end case;
               
      end loop TransporterAusladenSchleife;
      
   end TransporterEntladen;
   
   
   
   procedure TransporterUmgebung
     (TranspoterKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LadungExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
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
                     BewegungsberechnungEinheitenLogik.Bewegungsberechnung (EinheitSpeziesNummerExtern => LadungExtern,
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
      LadungExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is
      use type EinheitenDatentypen.Bewegungspunkte;
   begin
      
      EinheitVorhanden := EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => KoordinatenExtern,
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
        PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitSpeziesNummerExtern => LadungExtern,
                                                                  NeueKoordinatenExtern    => KoordinatenExtern)
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
      if
        LeseEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => LadungExtern) < BewegungspunkteBerechnenLogik.Bewegungspunkte (NeueKoordinatenExtern    => KoordinatenExtern,
                                                                                                                                           EinheitSpeziesNummerExtern => LadungExtern)
      then
         return False;
         
      else
         return True;
      end if;
      
   end Entladung;

end EinheitentransporterLogik;
