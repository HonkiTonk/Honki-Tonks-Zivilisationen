with KartenDatentypen;
with KartenRecordKonstanten;
with KartenKonstanten;

with LeseEinheitenGebaut;
with SchreibeEinheitenGebaut;

with KartenkoordinatenberechnungssystemLogik;

package body KIBewegungsplanVereinfachenLogik is

   procedure Planvereinfachung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
      use type EinheitenDatentypen.Bewegungsplan;
   begin
            
      PlanschrittSchleife:
      for PlanschrittSchleifenwert in EinheitenRecords.KIBewegungPlanArray'First .. EinheitenRecords.KIBewegungPlanArray'Last - 2 loop
            
         if
           KartenRecordKonstanten.LeerKoordinate = LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                       PlanschrittExtern        => PlanschrittSchleifenwert)
         then
            return;
               
         else
            PlanvereinfachungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                      PlanschrittExtern        => PlanschrittSchleifenwert);
         end if;
         
      end loop PlanschrittSchleife;
      
   end Planvereinfachung;
   
   
   
   procedure PlanvereinfachungPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PlanschrittExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      AktuellePlankoordinaten := LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                      PlanschrittExtern        => PlanschrittExtern);
      
      EAchseSchleife:
      for EAchseSchleifenwert in KartenDatentypen.EbenenbereichEins'Range loop
         YAchseSchleife:
         for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            XAchseSchleife:
            for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
               
               KartenwertVereinfachung := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => AktuellePlankoordinaten,
                                                                                                                      ÄnderungExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                                      LogikGrafikExtern => True);
               
               if
                 KartenwertVereinfachung.XAchse = KartenKonstanten.LeerXAchse
               then
                  null;
                     
               elsif
                 True = Verschieben (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                     PlanschrittExtern        => PlanschrittExtern,
                                     KoordinatenExtern        => KartenwertVereinfachung)
               then
                  return;
                  
               else
                  null;
               end if;
                  
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
   end PlanvereinfachungPrüfen;
   
   
   
   function Verschieben
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      PlanschrittExtern : in EinheitenDatentypen.BewegungsplanVorhanden;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
      use type EinheitenDatentypen.BewegungsplanVorhanden;
   begin
      
      Planschritt := 0;
      
      BewegungsplanSchleife:
      for BewegungsplanSchleifenwert in reverse PlanschrittExtern + ÜbernächsterSchritt .. EinheitenRecords.KIBewegungPlanArray'Last loop
                        
         if
           KoordinatenExtern = LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                   PlanschrittExtern        => BewegungsplanSchleifenwert)
         then
            Planschritt := BewegungsplanSchleifenwert;
            
            exit BewegungsplanSchleife;
            
         else
            null;
         end if;
                        
      end loop BewegungsplanSchleife;
      
      case
        Planschritt
      is
         when 0 =>
            return False;
            
         when others =>
            Zusatzschritt := NächsterSchritt;
      end case;
      
      VerschiebungSchleife:
      for VerschiebungSchleifenwert in Planschritt .. EinheitenRecords.KIBewegungPlanArray'Last loop
                  
         SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 KoordinatenExtern        => LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                 PlanschrittExtern        => VerschiebungSchleifenwert),
                                                 PlanplatzExtern          => PlanschrittExtern + Zusatzschritt);
            
         Zusatzschritt := Zusatzschritt + 1;
               
      end loop VerschiebungSchleife;
      
      LöschenSchleife:
      for LöschenSchleifenwert in PlanschrittExtern + Zusatzschritt .. EinheitenRecords.KIBewegungPlanArray'Last loop
         
        SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                KoordinatenExtern        => KartenRecordKonstanten.LeerKoordinate,
                                                PlanplatzExtern          => LöschenSchleifenwert);
         
      end loop LöschenSchleife;
            
      return True;
      
   end Verschieben;
   
   
   
   procedure BewegungsplanVerschieben
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is
      use type EinheitenDatentypen.BewegungsplanVorhanden;
   begin
      
      BewegungPlanVerschiebenSchleife:
      for PositionSchleifenwert in EinheitenRecords.KIBewegungPlanArray'First + 1 .. EinheitenRecords.KIBewegungPlanArray'Last loop
         
         SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 KoordinatenExtern        => LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                 PlanschrittExtern        => PositionSchleifenwert),
                                                 PlanplatzExtern          => (PositionSchleifenwert - 1));
         
      end loop BewegungPlanVerschiebenSchleife;
            
      SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                              KoordinatenExtern        => KartenRecordKonstanten.LeerKoordinate,
                                              PlanplatzExtern          => EinheitenRecords.KIBewegungPlanArray'Last);
      
   end BewegungsplanVerschieben;

end KIBewegungsplanVereinfachenLogik;
