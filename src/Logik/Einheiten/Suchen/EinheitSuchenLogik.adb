with EinheitenKonstanten;

with LeseEinheitenGebaut;
with LeseWeltkarte;
with LeseEinheitenDatenbank;

package body EinheitSuchenLogik is

   -- Sucht für die hineingegebene Rasse.
   function KoordinatenEinheitMitRasseSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LogikGrafikExtern : in Boolean)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
   is
      use type RassenDatentypen.Rassen_Enum;
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      Einheit (LogikGrafikExtern) := LeseWeltkarte.EinheitenbelegungGrund (KoordinatenExtern => KoordinatenExtern);
      
      if
        Einheit (LogikGrafikExtern).Rasse /= RasseExtern
        or
          Einheit (LogikGrafikExtern).Rasse = EinheitenKonstanten.LeerRasse
        or
          Einheit (LogikGrafikExtern).Nummer = EinheitenKonstanten.LeerNummer
      then
         return EinheitenKonstanten.LeerNummer;
         
      elsif
        LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => Einheit (LogikGrafikExtern)) /= KoordinatenExtern
      then
         return EinheitenKonstanten.LeerNummer;
            
      else
         return TransporterverschachtelungDurchgehen (EinheitRasseNummerExtern => Einheit (LogikGrafikExtern),
                                                      LogikGrafikExtern        => LogikGrafikExtern).Nummer;
      end if;
      
   end KoordinatenEinheitMitRasseSuchen;
   


   -- Sucht beliebige Einheit.
   function KoordinatenEinheitOhneRasseSuchen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LogikGrafikExtern : in Boolean)
      return EinheitenRecords.RasseEinheitnummerRecord
   is
      use type RassenDatentypen.Rassen_Enum;
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      Einheit (LogikGrafikExtern) := LeseWeltkarte.EinheitenbelegungGrund (KoordinatenExtern => KoordinatenExtern);
      
      if
        Einheit (LogikGrafikExtern).Rasse = EinheitenKonstanten.LeerRasse
        or
          Einheit (LogikGrafikExtern).Nummer = EinheitenKonstanten.LeerNummer
      then
         return EinheitenKonstanten.LeerRasseNummer;
         
      elsif
        LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => Einheit (LogikGrafikExtern)) /= KoordinatenExtern
      then
         return EinheitenKonstanten.LeerRasseNummer;
            
      else
         return TransporterverschachtelungDurchgehen (EinheitRasseNummerExtern => Einheit (LogikGrafikExtern),
                                                      LogikGrafikExtern        => LogikGrafikExtern);
      end if;
      
   end KoordinatenEinheitOhneRasseSuchen;



   -- Sucht ohne die hineingegebene Rasse.
   function KoordinatenEinheitOhneSpezielleRasseSuchen
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LogikGrafikExtern : in Boolean)
      return EinheitenRecords.RasseEinheitnummerRecord
   is
      use type RassenDatentypen.Rassen_Enum;
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      Einheit (LogikGrafikExtern) := LeseWeltkarte.EinheitenbelegungGrund (KoordinatenExtern => KoordinatenExtern);
      
      if
        Einheit (LogikGrafikExtern).Rasse = RasseExtern
        or
          Einheit (LogikGrafikExtern).Rasse = EinheitenKonstanten.LeerRasse
        or
          Einheit (LogikGrafikExtern).Nummer = EinheitenKonstanten.LeerNummer
      then
         return EinheitenKonstanten.LeerRasseNummer;
         
      elsif
        LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => Einheit (LogikGrafikExtern)) /= KoordinatenExtern
      then
         return EinheitenKonstanten.LeerRasseNummer;
            
      else
         return TransporterverschachtelungDurchgehen (EinheitRasseNummerExtern => Einheit (LogikGrafikExtern),
                                                      LogikGrafikExtern        => LogikGrafikExtern);
      end if;
      
   end KoordinatenEinheitOhneSpezielleRasseSuchen;
   
   
   
   function TransporterverschachtelungDurchgehen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      LogikGrafikExtern : in Boolean)
      return EinheitenRecords.RasseEinheitnummerRecord
   is begin
      
      Transporternummer (LogikGrafikExtern) := LeseEinheitenGebaut.WirdTransportiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
      case
        Transporternummer (LogikGrafikExtern)
      is
         when EinheitenKonstanten.LeerWirdTransportiert =>
            return EinheitRasseNummerExtern;
                  
         when others =>
            return TransporterverschachtelungDurchgehen (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, Transporternummer (LogikGrafikExtern)),
                                                         LogikGrafikExtern        => LogikGrafikExtern);
      end case;
      
   end TransporterverschachtelungDurchgehen;
   
   
   
   -- Prüft ob die hineingegebe Einheit geladen ist.
   -- Benötigt keine Taskaufteilung da sie nur vom Grafiktask aufgerufen wird.
   function TransporterladungSuchen
     (TransporterExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      LadungsnummerExtern : in EinheitenDatentypen.MaximaleEinheitenMitNullWert)
      return Boolean
   is
      use type RassenDatentypen.Rassen_Enum;
   begin
      
      if
        TransporterExtern.Rasse = EinheitenKonstanten.LeerRasse
        or
          TransporterExtern.Nummer = EinheitenKonstanten.LeerNummer
          or
            LadungsnummerExtern = EinheitenKonstanten.LeerNummer
      then
         return False;
         
      else
         Transporterkapazität := LeseEinheitenDatenbank.Transportkapazität (RasseExtern => TransporterExtern.Rasse,
                                                                              IDExtern    => LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => TransporterExtern));
      end if;
            
      TransporterSchleife:
      for TransporterSchleifenwert in EinheitenRecords.TransporterArray'First .. Transporterkapazität loop
         
         if
           LadungsnummerExtern = LeseEinheitenGebaut.Transportiert (EinheitRasseNummerExtern => TransporterExtern,
                                                                    PlatzExtern              => TransporterSchleifenwert)
         then
            return True;
               
         else
            null;
         end if;
         
      end loop TransporterSchleife;
      
      return False;
      
   end TransporterladungSuchen;

end EinheitSuchenLogik;
