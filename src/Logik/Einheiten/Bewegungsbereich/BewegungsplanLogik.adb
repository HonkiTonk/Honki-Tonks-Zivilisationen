with KartenKonstanten;
with KartenRecordKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;

with KartenkoordinatenberechnungssystemLogik;
with EinheitenbewegungLogik;
with BewegungsberechnungEinheitenLogik;
with PassierbarkeitspruefungLogik;
with EinheitSuchenLogik;

with KIBewegungsplanVereinfachenLogik;
with KIBewegungsbewertungLogik;

package body BewegungsplanLogik is
   
   function Einzelschritt
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldRecord;
   begin
      
      if
        ÄnderungExtern = KeineÄnderung
      then
         return True;
            
      else
         return BewegungPlanen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                ZielkoordinatenExtern    =>
                                  KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                                                              ÄnderungExtern    => ÄnderungExtern,
                                                                                                              LogikGrafikExtern => True));
      end if;
      
   end Einzelschritt;
   
   
      
   function BewegungPlanen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      ZielkoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
      use type EinheitenDatentypen.Bewegungspunkte;
      use type RassenDatentypen.Rassen_Enum;
   begin
      
      EinheitenKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
      
      if
        EinheitenKoordinaten = ZielkoordinatenExtern
      then
         return True;
         
      elsif
        False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                          NeueKoordinatenExtern    => ZielkoordinatenExtern)
        and
          EinheitRasseNummerExtern.Rasse /= EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => ZielkoordinatenExtern,
                                                                                                  LogikGrafikExtern => True).Rasse
      then
         return True;
         
      else
         SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
         SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    KoordinatenExtern        => ZielkoordinatenExtern);
         
         PlanungErfolgreich := PlanenRekursiv (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                               AktuelleKoordinatenExtern  => EinheitenKoordinaten,
                                               AktuellePlanpositionExtern => 1);
      end if;
      
      case
        PlanungErfolgreich
      is
         when True =>
            KIBewegungsplanVereinfachenLogik.Planvereinfachung (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
            DurchführungSchleife:
            loop
                  
               AktuelleBewegungspunkte := LeseEinheitenGebaut.Bewegungspunkte (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
               
               if
                 AktuelleBewegungspunkte = EinheitenKonstanten.LeerBewegungspunkte
               then
                  return False;
                        
               else
                  NeueKoordinaten := LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                         PlanschrittExtern        => 1);
               end if;
                  
               if
                 KartenRecordKonstanten.LeerKoordinate = NeueKoordinaten
               then
                  exit DurchführungSchleife;
                  
               elsif
                 ZielkoordinatenExtern = NeueKoordinaten
                 and
                   EinheitRasseNummerExtern.Rasse = EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => ZielkoordinatenExtern,
                                                                                                          LogikGrafikExtern => True).Rasse
               then
                  BewegungsberechnungEinheitenLogik.Bewegungsberechnung (EinheitRasseNummerExtern => EinheitSuchenLogik.KoordinatenEinheitOhneRasseSuchen (KoordinatenExtern => ZielkoordinatenExtern,
                                                                                                                                                           LogikGrafikExtern => True),
                                                                         NeueKoordinatenExtern    => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                                                         EinheitentauschExtern    => True);
                  
                  BewegungsberechnungEinheitenLogik.Bewegungsberechnung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                         NeueKoordinatenExtern    => NeueKoordinaten,
                                                                         EinheitentauschExtern    => False);
                  
               else
                  BewegungsberechnungEinheitenLogik.Bewegungsberechnung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                         NeueKoordinatenExtern    => NeueKoordinaten,
                                                                         EinheitentauschExtern    => False);
                  
                  if
                    KartenRecordKonstanten.LeerKoordinate = LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                PlanschrittExtern        => 2)
                  then
                     null;
                     
                  else
                     delay 0.20;
                  end if;
               end if;
               
               KIBewegungsplanVereinfachenLogik.BewegungsplanVerschieben (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
                  
            end loop DurchführungSchleife;
            
         when False =>
            null;
      end case;
      
      return True;
      
   end BewegungPlanen;
   
   
   
   function PlanenRekursiv
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      AktuellePlanpositionExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
      return Boolean
   is begin
      
      Felderbewertung (EinheitRasseNummerExtern  => EinheitRasseNummerExtern,
                       AktuelleKoordinatenExtern => AktuelleKoordinatenExtern);
      
      DurchlaufSchleife:
      for DurchlaufSchleifenwert in BewertungArray'Range loop
         
         case
           PlanschrittFestlegen (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                 DurchlaufExtern            => DurchlaufSchleifenwert,
                                 AktuellePlanpositionExtern => AktuellePlanpositionExtern)
         is
            when True =>
               return True;
               
            when False =>
               SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => KartenRecordKonstanten.LeerKoordinate,
                                                       PlanplatzExtern          => AktuellePlanpositionExtern);
         end case;
         
      end loop DurchlaufSchleife;
      
      return False;
      
   end PlanenRekursiv;
   
   
   
   function PlanschrittFestlegen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      DurchlaufExtern : in Positive;
      AktuellePlanpositionExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
      return Boolean
   is
      use type EinheitenDatentypen.BewegungsplanVorhanden;
   begin
            
      case
        Bewertung (DurchlaufExtern).Bewertung
      is
         when KartenDatentypen.KartenfeldPositiv'Last =>
            return False;
               
         when KartenDatentypen.KartenfeldNatural'First =>
            SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    KoordinatenExtern        => Bewertung (DurchlaufExtern).Koordinaten,
                                                    PlanplatzExtern          => AktuellePlanpositionExtern);
            return True;
               
         when others =>
            SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    KoordinatenExtern        => Bewertung (DurchlaufExtern).Koordinaten,
                                                    PlanplatzExtern          => AktuellePlanpositionExtern);
            
            if
              AktuellePlanpositionExtern = EinheitenRecords.KIBewegungPlanArray'Last
            then
               return True;
         
            else
               return PlanenRekursiv (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                      AktuelleKoordinatenExtern  => Bewertung (DurchlaufExtern).Koordinaten,
                                      AktuellePlanpositionExtern => AktuellePlanpositionExtern + 1);
            end if;
      end case;
      
   end PlanschrittFestlegen;
   
   
   
   procedure Felderbewertung
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      BewertungPosition := BewertungArray'First;
      
      EAchseSchleife:
      for EAchseSchleifenwert in KartenDatentypen.EbenenbereichEins'Range loop
         YAchseSchleife:
         for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            XAchseSchleife:
            for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
               
               KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => AktuelleKoordinatenExtern,
                                                                                                         ÄnderungExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                         LogikGrafikExtern => True);
               
               Bewertung (BewertungPosition).Koordinaten := KartenWert;
               
               if
                 KartenWert.XAchse = KartenKonstanten.LeerXAchse
                 or
                   KartenWert = AktuelleKoordinatenExtern
               then
                  Bewertung (BewertungPosition).Bewertung := KartenDatentypen.KartenfeldPositiv'Last;
            
               else
                  Bewertung (BewertungPosition).Bewertung := BewertungFeldposition (EinheitRasseNummerExtern  => EinheitRasseNummerExtern,
                                                                                    NeueKoordinatenExtern     => KartenWert);
               end if;
               
               BewertungPosition := BewertungPosition + 1;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
                  
      SortierenEinsSchleife:
      for SortierenEinsSchleifenwert in BewertungArray'Range loop
         SortierenZweiSchleife:
         for SortierenZweiSchleifenwert in SortierenEinsSchleifenwert + 1 .. BewertungArray'Last loop
                           
            if
              Bewertung (SortierenEinsSchleifenwert).Bewertung > Bewertung (SortierenZweiSchleifenwert).Bewertung
            then
               Sortieren := Bewertung (SortierenEinsSchleifenwert);
               Bewertung (SortierenEinsSchleifenwert) := Bewertung (SortierenZweiSchleifenwert);
               Bewertung (SortierenZweiSchleifenwert) := Sortieren;
                  
            else
               null;
            end if;
               
         end loop SortierenZweiSchleife;
      end loop SortierenEinsSchleife;
      
   end Felderbewertung;
   
   
   
   function BewertungFeldposition
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenDatentypen.KartenfeldNatural
   is begin
            
      if
        True = FeldBereitsBetreten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                    KoordinatenExtern        => NeueKoordinatenExtern)
      then
         return KartenDatentypen.KartenfeldPositiv'Last;
         
      elsif
        False = EinheitenbewegungLogik.BewegungPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                        KoordinatenExtern        => NeueKoordinatenExtern)
      then
         return KartenDatentypen.KartenfeldPositiv'Last;
          
      else
         return KIBewegungsbewertungLogik.Positionsbewertung (EinheitRasseNummerExtern  => EinheitRasseNummerExtern,
                                                              NeueKoordinatenExtern     => NeueKoordinatenExtern);
      end if;
      
   end BewertungFeldposition;
   
   
   
   function FeldBereitsBetreten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      FelderSchleife:
      for FelderSchleifenwert in EinheitenRecords.KIBewegungPlanArray'Range loop
         
         if
           KoordinatenExtern = LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                   PlanschrittExtern        => FelderSchleifenwert)
         then
            return True;
            
         else
            null;
         end if;
         
      end loop FelderSchleife;
      
      return False;
      
   end FeldBereitsBetreten;

end BewegungsplanLogik;
