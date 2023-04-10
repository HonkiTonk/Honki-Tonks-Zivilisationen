with KartenKonstanten;
with KartenRecordKonstanten;
with StadtKonstanten;
with StadtDatentypen;
with SpeziesKonstanten;
with TonDatentypen;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;

with KartenkoordinatenberechnungssystemLogik;
with EinheitenbewegungLogik;
with BewegungsberechnungEinheitenLogik;
with PassierbarkeitspruefungLogik;
with EinheitSuchenLogik;
with StadtSuchenLogik;
with NachGrafiktask;
with NachSoundtask;
with TransporterBeladenEntladenLogik;

with KIBewegungsplanVereinfachenLogik;
with KIBewegungsbewertungLogik;
with KIBewegungsplanBerechnenLogik;

package body BewegungsplanLogik is
   
   function Einzelschritt
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      ÄnderungExtern : in KartenRecords.AchsenKartenfeldRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldRecord;
   begin
            
      if
        ÄnderungExtern = KartenRecordKonstanten.LeerKoordinatenänderung
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
      use type EinheitenDatentypen.Lebenspunkte;
   begin
      
      EinheitenKoordinaten := LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
      
      case
        PlanungUnnötig (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                         ZielkoordinatenExtern      => ZielkoordinatenExtern,
                         EinheitenkoordinatenExtern => EinheitenKoordinaten)
      is
         when True =>
            return True;
            
         when False =>
            SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                       KoordinatenExtern          => ZielkoordinatenExtern);
      end case;
      
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
                  NachSoundtask.SoundStoppen := TonDatentypen.Sound_Einheitenbewegung_Enum;
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
               
               -- Sollte die Länge der Bewegungsverzögerung und des Bewegungssounds identisch sein? äöü
               NachSoundtask.SoundAbspielen := TonDatentypen.Sound_Einheitenbewegung_Enum;
               
               if
                 KartenRecordKonstanten.LeerKoordinate = NeueKoordinaten
               then
                  exit DurchführungSchleife;
                  
               elsif
                 ZielkoordinatenExtern = NeueKoordinaten
               then
                  NeuGleichZiel (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                 AndereEinheitExtern        => AndereEinheit,
                                 ZielkoordinatenExtern      => ZielkoordinatenExtern,
                                 StadtSpeziesNummerExtern   => StadtAufFeld);
                  exit DurchführungSchleife;
                  
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
                     -- Sollte die Länge der Bewegungsverzögerung und des Bewegungssounds identisch sein? äöü
                     delay Bewegungsverzögerung;
                  end if;
               end if;
               
               KIBewegungsplanVereinfachenLogik.BewegungsplanVerschieben (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern);
                  
            end loop DurchführungSchleife;
            
            NachSoundtask.SoundStoppen := TonDatentypen.Sound_Einheitenbewegung_Enum;
            
         when False =>
            null;
      end case;
      
      NachGrafiktask.Einheitenbewegung := False;
      return True;
      
   end BewegungPlanen;
   
   
   
   function PlanungUnnötig
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      ZielkoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EinheitenkoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is
      use type KartenRecords.AchsenKartenfeldNaturalRecord;
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      if
        EinheitenkoordinatenExtern = ZielkoordinatenExtern
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
         return False;
      end if;
      
   end PlanungUnnötig;
   
   
   
   procedure NeuGleichZiel
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      AndereEinheitExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      ZielkoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type SpeziesDatentypen.Spezies_Enum;
      use type StadtDatentypen.MaximaleStädteMitNullWert;
   begin
      
      if
        EinheitSpeziesNummerExtern.Spezies = AndereEinheitExtern.Spezies
      then
         case
           TransporterBeladenEntladenLogik.TransporterBeladen (TransporterExtern => AndereEinheitExtern,
                                                               LadungExtern      => EinheitSpeziesNummerExtern.Nummer)
         is
            when True =>
               null;
                           
            when False =>
               BewegungsberechnungEinheitenLogik.Bewegungsberechnung (EinheitSpeziesNummerExtern => AndereEinheitExtern,
                                                                      NeueKoordinatenExtern      => LeseEinheitenGebaut.Koordinaten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern),
                                                                      EinheitentauschExtern      => True);
                     
               BewegungsberechnungEinheitenLogik.Bewegungsberechnung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                      NeueKoordinatenExtern      => ZielkoordinatenExtern,
                                                                      EinheitentauschExtern      => False);
         end case;
         
         return;
                     
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
                                                  FremdeEinheitExtern        => AndereEinheitExtern)
         is
            when False =>
               BewegungDurchführen := False;
                           
            when True =>
               BewegungDurchführen := EinheitenbewegungLogik.FremdeStadtAufFeld (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                                  FremdeStadtExtern          => StadtSpeziesNummerExtern);
         end case;
         
         case
           BewegungDurchführen
         is
            when False =>
               return;
                           
            when True =>
               null;
         end case;
                     
      elsif
        (AndereEinheitExtern.Spezies /= EinheitSpeziesNummerExtern.Spezies
         and
           AndereEinheitExtern.Spezies /= SpeziesKonstanten.LeerSpezies)
        and then
          False = EinheitenbewegungLogik.FremderAufFeld (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                         FremdeEinheitExtern        => AndereEinheitExtern)
      then
         return;
         
      elsif
        (StadtSpeziesNummerExtern.Spezies /= SpeziesKonstanten.LeerSpezies
         and
           StadtSpeziesNummerExtern.Spezies /= EinheitSpeziesNummerExtern.Spezies)
        and then
          False = EinheitenbewegungLogik.FremdeStadtAufFeld (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                             FremdeStadtExtern          => StadtSpeziesNummerExtern)
      then
         return;
         
      else
         null;
      end if;
      
      BewegungsberechnungEinheitenLogik.Bewegungsberechnung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                             NeueKoordinatenExtern      => NeueKoordinaten,
                                                             EinheitentauschExtern      => False);
      
   end NeuGleichZiel;
   
   
   
   -- Den Teil hier mit KIBewegunsplanBerechnenLogik verschmelzen? äöü
   function PlanenRekursiv
     (EinheitSpeziesNummerExtern : in EinheitenRecords.SpeziesEinheitnummerRecord;
      AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      AktuellePlanpositionExtern : in EinheitenDatentypen.BewegungsplanVorhanden)
      return Boolean
   is begin
      
      Felderbewertung (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                       AktuelleKoordinatenExtern  => AktuelleKoordinatenExtern);
      
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
      
      -- Muss hier für Windows zwischengespeichert werden, da sonst Bewertung (DurchlaufExtern).Koordinaten in PlanenRekursiv überschrieben wird und als neue AktuelleKoordinatenExtern in der Schleife verwendet wird.
      -- Gilt auch für KIBewegungsplanBerechnenLogik und KIStaedteverbindungssystemLogik.
      -- Passiert nicht unter Linux, eventuell ein Kompilerfehler? Später, erst nach der Veröffentlichung von GNAT 13, mal nachprüfen.
      KoordinatenzwischenspeicherWindows := Bewertung (DurchlaufExtern).Koordinaten;
            
      case
        Bewertung (DurchlaufExtern).Bewertung
      is
         when KartenDatentypen.KartenfeldPositiv'Last =>
            return False;
               
         when KartenDatentypen.KartenfeldNatural'First =>
            SchreibeEinheitenGebaut.KIBewegungPlan (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    KoordinatenExtern          => KoordinatenzwischenspeicherWindows,
                                                    PlanplatzExtern            => AktuellePlanpositionExtern);
            return True;
               
         when others =>
            SchreibeEinheitenGebaut.KIBewegungPlan (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                    KoordinatenExtern          => KoordinatenzwischenspeicherWindows,
                                                    PlanplatzExtern            => AktuellePlanpositionExtern);
            
            if
              AktuellePlanpositionExtern = EinheitenRecords.KIBewegungPlanArray'Last
            then
               return True;
         
            else
               return PlanenRekursiv (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                      AktuelleKoordinatenExtern  => KoordinatenzwischenspeicherWindows,
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
        True = KIBewegungsplanBerechnenLogik.FeldBereitsBetreten (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                  KoordinatenExtern          => NeueKoordinatenExtern)
      then
         return KartenDatentypen.KartenfeldPositiv'Last;
         
      elsif
        False = EinheitenbewegungLogik.BewegungPrüfen (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                        KoordinatenExtern          => NeueKoordinatenExtern)
      then
         return KartenDatentypen.KartenfeldPositiv'Last;
          
      else
         return KIBewegungsbewertungLogik.PositionsbewertungEinheit (EinheitSpeziesNummerExtern => EinheitSpeziesNummerExtern,
                                                                     NeueKoordinatenExtern      => NeueKoordinatenExtern);
      end if;
      
   end BewertungFeldposition;

end BewegungsplanLogik;
