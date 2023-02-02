with KartenKonstanten;
with KartenRecordKonstanten;
with StadtKonstanten;
with StadtDatentypen;
with SpeziesKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;

with KartenkoordinatenberechnungssystemLogik;
with EinheitenbewegungLogik;
with BewegungsberechnungEinheitenLogik;
with PassierbarkeitspruefungLogik;
with EinheitSuchenLogik;
with StadtSuchenLogik;
with NachGrafiktask;

with KIBewegungsplanVereinfachenLogik;
with KIBewegungsbewertungLogik;

package body BewegungsplanLogik is
   
   function Einzelschritt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
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
         EinzelbewegungKartenwert
           := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern),
                                                                                          ÄnderungExtern    => ÄnderungExtern,
                                                                                          LogikGrafikExtern => True);
      end if;
      
      case
        EinzelbewegungKartenwert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return True;
            
         when others =>
            return BewegungPlanen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                   ZielkoordinatenExtern      => EinzelbewegungKartenwert);
      end case;
      
   end Einzelschritt;
   
   
      
   function BewegungPlanen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      ZielkoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
      use type EinheitenDatentypen.Bewegungspunkte;
      use type SpeziesDatentypen.Spezies_Enum;
      use type StadtDatentypen.MaximaleStädteMitNullWert;
      use type EinheitenDatentypen.Lebenspunkte;
   begin
      
      EinheitenKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      if
        EinheitenKoordinaten = ZielkoordinatenExtern
      then
         return True;
         
      elsif
        False = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                          NeueKoordinatenExtern      => ZielkoordinatenExtern)
        and
          EinheitSpeziesNummerExtern.Spezies /= EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => ZielkoordinatenExtern,
                                                                                                        LogikGrafikExtern => True).Spezies
      then
         return True;
         
      elsif
        EinheitSpeziesNummerExtern.Spezies = EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => ZielkoordinatenExtern,
                                                                                                     LogikGrafikExtern => True).Spezies
        and then
          False = EinheitenbewegungLogik.EinheitentauschPrüfung (BewegendeEinheitExtern => EinheitSpeziesNummerExtern,
                                                                  StehendeEinheitExtern  => EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => ZielkoordinatenExtern,
                                                                                                                                                    LogikGrafikExtern => True))
      then
         return True;
        
      else
         SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
         SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    KoordinatenExtern          => ZielkoordinatenExtern);
      end if;
      
      case
        PlanenRekursiv (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                        AktuelleKoordinatenExtern  => EinheitenKoordinaten,
                        AktuellePlanpositionExtern => 1)
      is
         when True =>
            NachGrafiktask.Einheitenbewegung := True;
            
            DurchführungSchleife:
            loop
                  
               AktuelleBewegungspunkte := LeseEinheitenGebaut.Bewegungspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
               
               if
                 AktuelleBewegungspunkte = EinheitenKonstanten.LeerBewegungspunkte
                 or
                   EinheitenKonstanten.LeerLebenspunkte = LeseEinheitenGebaut.Lebenspunkte (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern)
               then
                  NachGrafiktask.Einheitenbewegung := False;
                  return False;
                        
               else
                  NeueKoordinaten := LeseEinheitenGebaut.KIBewegungPlan (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                         PlanschrittExtern          => 1);
                  AndereEinheit := EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => NeueKoordinaten,
                                                                                           LogikGrafikExtern => True);
                  StadtAufFeld := StadtSuchenLogik.KoordinatenStadtOhneSpezielleSpeziesSuchen (SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies,
                                                                                               KoordinatenExtern => NeueKoordinaten);
               end if;
               
               if
                 KartenRecordKonstanten.LeerKoordinate = NeueKoordinaten
               then
                  exit DurchführungSchleife;
                  
               elsif
                 ZielkoordinatenExtern = NeueKoordinaten
               then
                  if
                    EinheitSpeziesNummerExtern.Spezies = AndereEinheit.Spezies
                  then
                     BewegungsberechnungEinheitenLogik.Bewegungsberechnung (EinheitSpeziesNummerExtern => EinheitSuchenLogik.KoordinatenEinheitOhneSpeziesSuchen (KoordinatenExtern => ZielkoordinatenExtern,
                                                                                                                                                                  LogikGrafikExtern => True),
                                                                            NeueKoordinatenExtern      => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern),
                                                                            EinheitentauschExtern      => True);
                     
                     BewegungsberechnungEinheitenLogik.Bewegungsberechnung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                            NeueKoordinatenExtern      => ZielkoordinatenExtern,
                                                                            EinheitentauschExtern      => False);
                     
                  elsif
                    EinheitSpeziesNummerExtern.Spezies /= AndereEinheit.Spezies
                    and
                      SpeziesKonstanten.LeerSpezies /= AndereEinheit.Spezies
                      and
                        StadtKonstanten.LeerNummer /= StadtSuchenLogik.KoordinatenStadtOhneSpezielleSpeziesSuchen (SpeziesExtern     => EinheitSpeziesNummerExtern.Spezies,
                                                                                                                   KoordinatenExtern => ZielkoordinatenExtern).Nummer
                  then
                     case
                       EinheitenbewegungLogik.FremderAufFeld (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                              FremdeEinheitExtern        => AndereEinheit)
                     is
                        when False =>
                           null;
                           
                        when True =>
                           BewegungDurchführen := EinheitenbewegungLogik.FremdeStadtAufFeld (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                                              FremdeStadtExtern          => StadtAufFeld);
                     end case;
                     
                     case 
                       BewegungDurchführen
                     is
                        when False =>
                           null;
                           
                        when True =>
                           BewegungsberechnungEinheitenLogik.Bewegungsberechnung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                                  NeueKoordinatenExtern      => NeueKoordinaten,
                                                                                  EinheitentauschExtern      => False);
                     end case;
                     
                  elsif
                    AndereEinheit.Spezies /= EinheitSpeziesNummerExtern.Spezies
                    and
                      AndereEinheit.Spezies /= SpeziesKonstanten.LeerSpezies
                  then
                     case
                       EinheitenbewegungLogik.FremderAufFeld (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                              FremdeEinheitExtern        => AndereEinheit)
                     is
                        when False =>
                           null;
                           
                        when True =>
                           BewegungsberechnungEinheitenLogik.Bewegungsberechnung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                                  NeueKoordinatenExtern      => NeueKoordinaten,
                                                                                  EinheitentauschExtern      => False);
                     end case;
                  
                  elsif
                    StadtAufFeld.Spezies /= SpeziesKonstanten.LeerSpezies
                    and
                      StadtAufFeld.Spezies /= EinheitSpeziesNummerExtern.Spezies
                  then
                     case
                       EinheitenbewegungLogik.FremdeStadtAufFeld (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                  FremdeStadtExtern          => StadtAufFeld)
                     is
                        when False =>
                           null;
                           
                        when True =>
                           BewegungsberechnungEinheitenLogik.Bewegungsberechnung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                                  NeueKoordinatenExtern      => NeueKoordinaten,
                                                                                  EinheitentauschExtern      => False);
                     end case;
                     
                  else
                     BewegungsberechnungEinheitenLogik.Bewegungsberechnung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                            NeueKoordinatenExtern      => NeueKoordinaten,
                                                                            EinheitentauschExtern      => False);
                  end if;
                  
               else
                  BewegungsberechnungEinheitenLogik.Bewegungsberechnung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                         NeueKoordinatenExtern      => NeueKoordinaten,
                                                                         EinheitentauschExtern      => False);
                  
                  if
                    KartenRecordKonstanten.LeerKoordinate = LeseEinheitenGebaut.KIBewegungPlan (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                                                PlanschrittExtern          => 2)
                  then
                     null;
                     
                  else
                     delay Bewegungsverzögerung;
                  end if;
               end if;
               
               KIBewegungsplanVereinfachenLogik.BewegungsplanVerschieben (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
                  
            end loop DurchführungSchleife;
            
         when False =>
            null;
      end case;
      
      NachGrafiktask.Einheitenbewegung := False;
      return True;
      
   end BewegungPlanen;
   
   
   
   function PlanenRekursiv
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      AktuellePlanpositionExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
      return Boolean
   is begin
      
      Felderbewertung (EinheitSpeziesNummerExtern  => EinheitSpeziesNummerExtern,
                       AktuelleKoordinatenExtern => AktuelleKoordinatenExtern);
      
      DurchlaufSchleife:
      for DurchlaufSchleifenwert in BewertungArray'Range loop
         
         case
           PlanschrittFestlegen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                 DurchlaufExtern            => DurchlaufSchleifenwert,
                                 AktuellePlanpositionExtern => AktuellePlanpositionExtern)
         is
            when True =>
               return True;
               
            when False =>
               SchreibeEinheitenGebaut.KIBewegungPlan (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                       KoordinatenExtern          => KartenRecordKonstanten.LeerKoordinate,
                                                       PlanplatzExtern            => AktuellePlanpositionExtern);
         end case;
         
      end loop DurchlaufSchleife;
      
      return False;
      
   end PlanenRekursiv;
   
   
   
   function PlanschrittFestlegen
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
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
            SchreibeEinheitenGebaut.KIBewegungPlan (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    KoordinatenExtern          => Bewertung (DurchlaufExtern).Koordinaten,
                                                    PlanplatzExtern            => AktuellePlanpositionExtern);
            return True;
               
         when others =>
            SchreibeEinheitenGebaut.KIBewegungPlan (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    KoordinatenExtern          => Bewertung (DurchlaufExtern).Koordinaten,
                                                    PlanplatzExtern            => AktuellePlanpositionExtern);
            
            if
              AktuellePlanpositionExtern = EinheitenRecords.KIBewegungPlanArray'Last
            then
               return True;
         
            else
               return PlanenRekursiv (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                      AktuelleKoordinatenExtern  => Bewertung (DurchlaufExtern).Koordinaten,
                                      AktuellePlanpositionExtern => AktuellePlanpositionExtern + 1);
            end if;
      end case;
      
   end PlanschrittFestlegen;
   
   
   
   procedure Felderbewertung
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
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
                  Bewertung (BewertungPosition).Bewertung := BewertungFeldposition (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                                    NeueKoordinatenExtern      => KartenWert);
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
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KartenDatentypen.KartenfeldNatural
   is begin
            
      if
        True = FeldBereitsBetreten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                    KoordinatenExtern          => NeueKoordinatenExtern)
      then
         return KartenDatentypen.KartenfeldPositiv'Last;
         
      elsif
        False = EinheitenbewegungLogik.BewegungPrüfen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                        KoordinatenExtern          => NeueKoordinatenExtern)
      then
         return KartenDatentypen.KartenfeldPositiv'Last;
          
      else
         return KIBewegungsbewertungLogik.Positionsbewertung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                              NeueKoordinatenExtern      => NeueKoordinatenExtern);
      end if;
      
   end BewertungFeldposition;
   
   
   
   function FeldBereitsBetreten
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
   begin
      
      FelderSchleife:
      for FelderSchleifenwert in EinheitenRecords.KIBewegungPlanArray'Range loop
         
         if
           KoordinatenExtern = LeseEinheitenGebaut.KIBewegungPlan (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                   PlanschrittExtern          => FelderSchleifenwert)
         then
            return True;
            
         else
            null;
         end if;
         
      end loop FelderSchleife;
      
      return False;
      
   end FeldBereitsBetreten;

end BewegungsplanLogik;
