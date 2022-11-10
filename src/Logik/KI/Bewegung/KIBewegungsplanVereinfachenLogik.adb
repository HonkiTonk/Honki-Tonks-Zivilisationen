pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with KartenRecords; use KartenRecords;
with KartenDatentypen; use KartenDatentypen;
with KartenRecordKonstanten;
with KartenKonstanten;

with LeseEinheitenGebaut;
with SchreibeEinheitenGebaut;

with KartenkoordinatenberechnungssystemLogik;

package body KIBewegungsplanVereinfachenLogik is

   procedure Planvereinfachung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
   is begin
      
      ErsterZugSchleife:
      for ErsterZugSchleifenwert in EinheitenRecords.KIBewegungPlanArray'Range loop
         ÜberNächsterZugSchleife:
         for ÜberNächsterZugSchleifenwert in EinheitenRecords.KIBewegungPlanArray'Range loop
            
            if
              KartenRecordKonstanten.LeerKoordinate = LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                          PlanschrittExtern        => ÜberNächsterZugSchleifenwert)
              or
                KartenRecordKonstanten.LeerKoordinate = LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                            PlanschrittExtern        => ErsterZugSchleifenwert)
            then
               return;
               
            else
               null;
            end if;
            
            if
              ÜberNächsterZugSchleifenwert <= ErsterZugSchleifenwert + 1
            then
               null;
               
            else
               PlanvereinfachungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                         ErsterZugExtern         => ErsterZugSchleifenwert,
                                         ÜberNächsterZugExtern   => ÜberNächsterZugSchleifenwert);
            end if;
            
         end loop ÜberNächsterZugSchleife;
      end loop ErsterZugSchleife;
      
   end Planvereinfachung;
   
   
   
   procedure PlanvereinfachungPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      ErsterZugExtern : in EinheitenDatentypen.Bewegungsplan;
      ÜberNächsterZugExtern : in EinheitenDatentypen.Bewegungsplan)
   is begin
      
      EAchseSchleife:
      for EAchseSchleifenwert in KartenDatentypen.EbenenbereichEins'Range loop
         YAchseSchleife:
         for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            XAchseSchleife:
            for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
               
               KartenWertVereinfachung
                 := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                                         PlanschrittExtern        => ErsterZugExtern),
                                                                                                ÄnderungExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                LogikGrafikExtern => True);
               
               if
                 KartenWertVereinfachung.XAchse = KartenKonstanten.LeerXAchse
               then
                  null;
              
               elsif
                 KartenWertVereinfachung = LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                               PlanschrittExtern        => ÜberNächsterZugExtern)
               then
                  BewegungPlanVerschiebenSchleife:
                  for PositionSchleifenwert in ErsterZugExtern .. EinheitenRecords.KIBewegungPlanArray'Last - 1 loop
               
                     SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             KoordinatenExtern        => LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                             PlanschrittExtern        => (ÜberNächsterZugExtern)),
                                                             PlanplatzExtern          => (PositionSchleifenwert + 1));
               
                  end loop BewegungPlanVerschiebenSchleife;
                  
                  SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                          KoordinatenExtern        => KartenRecordKonstanten.LeerKoordinate,
                                                          PlanplatzExtern          => EinheitenRecords.KIBewegungPlanArray'Last);
                           
               else
                  null;
               end if;
                  
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
   end PlanvereinfachungPrüfen;

end KIBewegungsplanVereinfachenLogik;
