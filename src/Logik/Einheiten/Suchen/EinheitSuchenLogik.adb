with EinheitenKonstanten;
with SpeziesKonstanten;

with LeseEinheitenGebaut;
with LeseWeltkarte;
-- with LeseEinheitenDatenbank;

package body EinheitSuchenLogik is

   -- Sucht für die hineingegebene Spezies.
   function KoordinatenEinheitMitSpeziesSuchen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return EinheitenDatentypen.Einheitenbereich
   is
      use type SpeziesDatentypen.Spezies_Enum;
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      Einheit (TaskExtern) := LeseWeltkarte.EinheitenbelegungGrund (KoordinatenExtern => KoordinatenExtern);
      
      if
        Einheit (TaskExtern).Spezies /= SpeziesExtern
        or
          Einheit (TaskExtern).Spezies = SpeziesKonstanten.LeerSpezies
        or
          Einheit (TaskExtern).Nummer = EinheitenKonstanten.LeerNummer
      then
         return EinheitenKonstanten.LeerNummer;
         
      elsif
        LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => Einheit (TaskExtern)) /= KoordinatenExtern
      then
         return EinheitenKonstanten.LeerNummer;
            
      else
         return TransporterverschachtelungDurchgehen (EinheitSpeziesNummerExtern => Einheit (TaskExtern),
                                                      TaskExtern          => TaskExtern).Nummer;
      end if;
      
   end KoordinatenEinheitMitSpeziesSuchen;
   


   -- Sucht beliebige Einheit.
   function KoordinatenEinheitOhneSpeziesSuchen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return EinheitenRecords.SpeziesEinheitnummerRecord
   is
      use type SpeziesDatentypen.Spezies_Enum;
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      Einheit (TaskExtern) := LeseWeltkarte.EinheitenbelegungGrund (KoordinatenExtern => KoordinatenExtern);
      
      if
        Einheit (TaskExtern).Spezies = SpeziesKonstanten.LeerSpezies
        or
          Einheit (TaskExtern).Nummer = EinheitenKonstanten.LeerNummer
      then
         return EinheitenKonstanten.LeerEinheit;
         
      elsif
        LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => Einheit (TaskExtern)) /= KoordinatenExtern
      then
         return EinheitenKonstanten.LeerEinheit;
            
      else
         return TransporterverschachtelungDurchgehen (EinheitSpeziesNummerExtern => Einheit (TaskExtern),
                                                      TaskExtern          => TaskExtern);
      end if;
      
   end KoordinatenEinheitOhneSpeziesSuchen;



   -- Sucht ohne die hineingegebene Spezies.
   function KoordinatenEinheitOhneSpezielleSpeziesSuchen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return EinheitenRecords.SpeziesEinheitnummerRecord
   is
      use type SpeziesDatentypen.Spezies_Enum;
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      Einheit (TaskExtern) := LeseWeltkarte.EinheitenbelegungGrund (KoordinatenExtern => KoordinatenExtern);
      
      if
        Einheit (TaskExtern).Spezies = SpeziesExtern
        or
          Einheit (TaskExtern).Spezies = SpeziesKonstanten.LeerSpezies
        or
          Einheit (TaskExtern).Nummer = EinheitenKonstanten.LeerNummer
      then
         return EinheitenKonstanten.LeerEinheit;
         
      elsif
        LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => Einheit (TaskExtern)) /= KoordinatenExtern
      then
         return EinheitenKonstanten.LeerEinheit;
            
      else
         return TransporterverschachtelungDurchgehen (EinheitSpeziesNummerExtern => Einheit (TaskExtern),
                                                      TaskExtern          => TaskExtern);
      end if;
      
   end KoordinatenEinheitOhneSpezielleSpeziesSuchen;
   
   
   
   function TransporterverschachtelungDurchgehen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      TaskExtern : in SystemDatentypen.Task_Enum)
      return EinheitenRecords.SpeziesEinheitnummerRecord
   is begin
      
      Transporternummer (TaskExtern) := LeseEinheitenGebaut.WirdTransportiert (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            
      case
        Transporternummer (TaskExtern)
      is
         when EinheitenKonstanten.LeerWirdTransportiert =>
            return EinheitSpeziesNummerExtern;
                  
         when others =>
            return TransporterverschachtelungDurchgehen (EinheitSpeziesNummerExtern => (EinheitSpeziesNummerExtern.Spezies, Transporternummer (TaskExtern)),
                                                         TaskExtern          => TaskExtern);
      end case;
      
   end TransporterverschachtelungDurchgehen;
   
   
   
   -- Prüft ob die hineingegebe Einheit geladen ist und über dem Transporter blinken soll.
   -- Benötigt keine Taskaufteilung da sie nur vom Grafiktask aufgerufen wird.
   function TransporterladungSuchen
     (TransporterExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      LadungsnummerExtern : in EinheitenDatentypen.Einheitenbereich)
      return Boolean
   is
      use type SpeziesDatentypen.Spezies_Enum;
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
            
      if
        TransporterExtern.Spezies = SpeziesKonstanten.LeerSpezies
        or
          TransporterExtern.Nummer = EinheitenKonstanten.LeerNummer
          or
            LadungsnummerExtern = EinheitenKonstanten.LeerNummer
      then
         return False;
         
      elsif
        LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => TransporterExtern) = LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => (TransporterExtern.Spezies, LadungsnummerExtern))
      then
         return True;
         
      else
         return False;
      end if;
      
   end TransporterladungSuchen;

end EinheitSuchenLogik;
