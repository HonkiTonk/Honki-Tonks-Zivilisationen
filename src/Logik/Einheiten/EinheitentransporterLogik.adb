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
   
   -- Eventuell für Ladung und Transporter die Spezies übergeben und dann eine Sicherheitsprüfung einbauen ob es die gleiche Spezies ist und wenn nicht einen Fehler ausgeben? äöü
   function TransporterGroßGenug
     (LadungExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      TransporterExtern : in EinheitenDatentypen.EinheitenIDMitNullWert;
      SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum)
      return Boolean
   is
      use type EinheitenDatentypen.Transport_Enum;
   begin
      
      if
        EinheitenKonstanten.LeerKannTransportiertWerden = LeseEinheitenDatenbank.KannTransportiertWerden (SpeziesExtern => SpeziesExtern,
                                                                                                          IDExtern      => LadungExtern)
        or
          LeseEinheitenDatenbank.KannTransportieren (SpeziesExtern => SpeziesExtern,
                                                     IDExtern      => TransporterExtern)
        < LeseEinheitenDatenbank.KannTransportiertWerden (SpeziesExtern => SpeziesExtern,
                                                          IDExtern      => LadungExtern)
      then
         return False;
         
      else
         return True;
      end if;
      
   end TransporterGroßGenug;
   
   
   
   function KannTransportiertWerden
     (LadungExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord)
      return Boolean
   is begin
      
      TransporterID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => TransporterExtern);
      
      case
        TransporterID
      is
         when EinheitenKonstanten.LeerID =>
            return False;
            
         when others =>
            LadungID := LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => LadungExtern);
      end case;
        
      case
        TransporterGroßGenug (LadungExtern      => LadungID,
                               TransporterExtern => TransporterID,
                               SpeziesExtern     => LadungExtern.Spezies)
      is
         when False =>
            return False;
            
         when True =>
            null;
      end case;
      
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
                                                                           IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => TransporterExtern));
      TransporterKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => TransporterExtern);
      
      TransporterAusladenSchleife:
      for TransporterAusladenSchleifenwert in EinheitenRecords.TransporterArray'First .. Transporterkapazität loop

         AktuelleLadung := LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => TransporterExtern,
                                                              PlatzExtern                => TransporterAusladenSchleifenwert);
         
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
               
            elsif
              False = Entladung (KoordinatenExtern => KartenWert,
                                 LadungExtern      => LadungExtern)
            then
               null;
               
            else
               BewegungsberechnungEinheitenLogik.Bewegungsberechnung (EinheitSpeziesNummerExtern => LadungExtern,
                                                                      NeueKoordinatenExtern      => KartenWert,
                                                                      EinheitentauschExtern      => False);
               return;
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
      
      if
        False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitSpeziesNummerExtern => LadungExtern,
                                                                          NeueKoordinatenExtern      => KoordinatenExtern)
      then
         return False;
         
      elsif
        LeseEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => LadungExtern) < BewegungspunkteBerechnenLogik.Bewegungspunkte (NeueKoordinatenExtern      => KoordinatenExtern,
                                                                                                                                          EinheitSpeziesNummerExtern => LadungExtern)
      then
         return False;
         
      else
         return True;
      end if;
      
   end Entladung;
   
   
   
   function BelegtePlätze
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      TransportkapazitätExtern : in EinheitenDatentypen.Transportplätze)
      return EinheitenDatentypen.Transportplätze
   is
      use type EinheitenDatentypen.Transportplätze;
   begin
      
      AktuelleLadungsmenge := EinheitenKonstanten.LeerTransportkapazität;
      
      BelegtePlätzeSchleife:
      for BelegtePlätzeSchleifenwert in EinheitenRecords.TransporterArray'First .. TransportkapazitätExtern loop
         
         case
           LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                              PlatzExtern                => BelegtePlätzeSchleifenwert)
         is
            when EinheitenKonstanten.LeerNummer =>
               null;
               
            when others =>
               AktuelleLadungsmenge := AktuelleLadungsmenge + 1;
         end case;
         
      end loop BelegtePlätzeSchleife;
      
      return AktuelleLadungsmenge;
      
   end BelegtePlätze;

end EinheitentransporterLogik;
