with EinheitenKonstanten;
with SpeziesKonstanten;

with LeseEinheitenGebaut;
with LeseWeltkarte;
with LeseEinheitenDatenbank;

package body EinheitSuchenLogik is

   -- Sucht für die hineingegebene Spezies.
   function KoordinatenEinheitMitSpeziesSuchen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LogikGrafikExtern : in Boolean)
      return EinheitenDatentypen.MaximaleEinheitenMitNullWert
   is
      use type SpeziesDatentypen.Spezies_Enum;
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      Einheit (LogikGrafikExtern) := LeseWeltkarte.EinheitenbelegungGrund (KoordinatenExtern => KoordinatenExtern);
      
      if
        Einheit (LogikGrafikExtern).Spezies /= SpeziesExtern
        or
          Einheit (LogikGrafikExtern).Spezies = SpeziesKonstanten.LeerSpezies
        or
          Einheit (LogikGrafikExtern).Nummer = EinheitenKonstanten.LeerNummer
      then
         return EinheitenKonstanten.LeerNummer;
         
      elsif
        LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => Einheit (LogikGrafikExtern)) /= KoordinatenExtern
      then
         return EinheitenKonstanten.LeerNummer;
            
      else
         return TransporterverschachtelungDurchgehen (EinheitSpeziesNummerExtern => Einheit (LogikGrafikExtern),
                                                      LogikGrafikExtern          => LogikGrafikExtern).Nummer;
      end if;
      
   end KoordinatenEinheitMitSpeziesSuchen;
   


   -- Sucht beliebige Einheit.
   function KoordinatenEinheitOhneSpeziesSuchen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LogikGrafikExtern : in Boolean)
      return EinheitenRecords.SpeziesEinheitnummerRecord
   is
      use type SpeziesDatentypen.Spezies_Enum;
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      Einheit (LogikGrafikExtern) := LeseWeltkarte.EinheitenbelegungGrund (KoordinatenExtern => KoordinatenExtern);
      
      if
        Einheit (LogikGrafikExtern).Spezies = SpeziesKonstanten.LeerSpezies
        or
          Einheit (LogikGrafikExtern).Nummer = EinheitenKonstanten.LeerNummer
      then
         return EinheitenKonstanten.LeerEinheit;
         
      elsif
        LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => Einheit (LogikGrafikExtern)) /= KoordinatenExtern
      then
         return EinheitenKonstanten.LeerEinheit;
            
      else
         return TransporterverschachtelungDurchgehen (EinheitSpeziesNummerExtern => Einheit (LogikGrafikExtern),
                                                      LogikGrafikExtern          => LogikGrafikExtern);
      end if;
      
   end KoordinatenEinheitOhneSpeziesSuchen;



   -- Sucht ohne die hineingegebene Spezies.
   function KoordinatenEinheitOhneSpezielleSpeziesSuchen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      LogikGrafikExtern : in Boolean)
      return EinheitenRecords.SpeziesEinheitnummerRecord
   is
      use type SpeziesDatentypen.Spezies_Enum;
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      Einheit (LogikGrafikExtern) := LeseWeltkarte.EinheitenbelegungGrund (KoordinatenExtern => KoordinatenExtern);
      
      if
        Einheit (LogikGrafikExtern).Spezies = SpeziesExtern
        or
          Einheit (LogikGrafikExtern).Spezies = SpeziesKonstanten.LeerSpezies
        or
          Einheit (LogikGrafikExtern).Nummer = EinheitenKonstanten.LeerNummer
      then
         return EinheitenKonstanten.LeerEinheit;
         
      elsif
        LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => Einheit (LogikGrafikExtern)) /= KoordinatenExtern
      then
         return EinheitenKonstanten.LeerEinheit;
            
      else
         return TransporterverschachtelungDurchgehen (EinheitSpeziesNummerExtern => Einheit (LogikGrafikExtern),
                                                      LogikGrafikExtern          => LogikGrafikExtern);
      end if;
      
   end KoordinatenEinheitOhneSpezielleSpeziesSuchen;
   
   
   
   function TransporterverschachtelungDurchgehen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      LogikGrafikExtern : in Boolean)
      return EinheitenRecords.SpeziesEinheitnummerRecord
   is begin
      
      Transporternummer (LogikGrafikExtern) := LeseEinheitenGebaut.WirdTransportiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
      case
        Transporternummer (LogikGrafikExtern)
      is
         when EinheitenKonstanten.LeerWirdTransportiert =>
            return EinheitSpeziesNummerExtern;
                  
         when others =>
            return TransporterverschachtelungDurchgehen (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, Transporternummer (LogikGrafikExtern)),
                                                         LogikGrafikExtern          => LogikGrafikExtern);
      end case;
      
   end TransporterverschachtelungDurchgehen;
   
   
   
   -- Prüft ob die hineingegebe Einheit geladen ist.
   -- Benötigt keine Taskaufteilung da sie nur vom Grafiktask aufgerufen wird.
   function TransporterladungSuchen
     (TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      LadungsnummerExtern : in EinheitenDatentypen.MaximaleEinheitenMitNullWert)
      return Boolean
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      if
        TransporterExtern.Spezies = SpeziesKonstanten.LeerSpezies
        or
          TransporterExtern.Nummer = EinheitenKonstanten.LeerNummer
          or
            LadungsnummerExtern = EinheitenKonstanten.LeerNummer
      then
         return False;
         
      else
         Transporterkapazität := LeseEinheitenDatenbank.Transportkapazität (SpeziesExtern => TransporterExtern.Spezies,
                                                                              IDExtern      => LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => TransporterExtern));
      end if;
            
      TransporterSchleife:
      for TransporterSchleifenwert in EinheitenRecords.TransporterArray'First .. Transporterkapazität loop
         
         if
           LadungsnummerExtern = LeseEinheitenGebaut.Transportiert (EinheitSpeziesNummerExtern => TransporterExtern,
                                                                    PlatzExtern                => TransporterSchleifenwert)
         then
            return True;
               
         else
            null;
         end if;
         
      end loop TransporterSchleife;
      
      return False;
      
   end TransporterladungSuchen;

end EinheitSuchenLogik;
