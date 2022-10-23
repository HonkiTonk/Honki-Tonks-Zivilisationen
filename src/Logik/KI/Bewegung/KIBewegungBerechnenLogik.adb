pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with EinheitenDatentypen; use EinheitenDatentypen;
with KartenRecords; use KartenRecords;
with KartenKonstanten;
with EinheitenKonstanten;
with KartenRecordKonstanten;

with KIDatentypen; use KIDatentypen;
with KIKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;

with KartenkoordinatenberechnungssystemLogik;
with PassierbarkeitspruefungLogik;
with EinheitentransporterLogik;

with KIBewegungAllgemeinLogik;

package body KIBewegungBerechnenLogik is
   
   function BewegungPlanen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord)
      return Boolean
   is begin
               
      PlanungErfolgreich := PlanenRekursiv (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                            AktuelleKoordinatenExtern  => LeseEinheitenGebaut.Koordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                            AktuellePlanpositionExtern => 1);
      
      case
        PlanungErfolgreich
      is
         when True =>
            VorhandenenPlanVereinfachen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when False =>
            SchreibeEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       KoordinatenExtern        => KartenRecordKonstanten.LeerKoordinate);
            SchreibeEinheitenGebaut.KIBewegungsplanLeeren (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Leer_Aufgabe_Enum);
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern      => EinheitenKonstanten.LeerBeschäftigung);
      end case;
      
      return PlanungErfolgreich;
      
   end BewegungPlanen;
   
   
   
   function PlanenRekursiv
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      AktuellePlanpositionExtern : in KartenDatentypen.Stadtfeld)
      return Boolean
   is begin
      
      DurchlaufSchleife:
      for DurchlaufSchleifenwert in BewertungArray'First .. BewertungArray'Last - 1 loop
         
         FelderBewerten (EinheitRasseNummerExtern  => EinheitRasseNummerExtern,
                         AktuelleKoordinatenExtern => AktuelleKoordinatenExtern);
         BewertungSortieren;
         
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
   
   
   
   procedure FelderBewerten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is begin
      
      BewertungPosition := BewertungArray'First;
      
      EAchseÄnderungSchleife:
      for EAchseÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEinsEAchse'Range loop
         YAchseÄnderungSchleife:
         for YAchseÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            XAchseÄnderungSchleife:
            for XAchseÄnderungSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            
               FeldBewertung (EAchseÄnderungSchleifenwert, YAchseÄnderungSchleifenwert, XAchseÄnderungSchleifenwert) := BewertungFeldposition (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                                  KoordinatenExtern        => AktuelleKoordinatenExtern,
                                                                                                                                                  EÄnderungExtern          => EAchseÄnderungSchleifenwert,
                                                                                                                                                  YÄnderungExtern          => YAchseÄnderungSchleifenwert,
                                                                                                                                                  XÄnderungExtern          => XAchseÄnderungSchleifenwert);
               
               Bewertung (BewertungPosition) := (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse, FeldBewertung (EAchseÄnderungSchleifenwert, YAchseÄnderungSchleifenwert, XAchseÄnderungSchleifenwert));
               
               case
                 BewertungPosition
               is
                  when BewertungArray'Last =>
                     exit EAchseÄnderungSchleife;
                     
                  when others =>
                     BewertungPosition := BewertungPosition + 1;
               end case;
               
            end loop XAchseÄnderungSchleife;
         end loop YAchseÄnderungSchleife;
      end loop EAchseÄnderungSchleife;
      
   end FelderBewerten;
   
   
   
   procedure BewertungSortieren
   is begin
      
      HöchsteWertungEinsSchleife:
      for HöchsteWertungEinsSchleifenwert in BewertungArray'Range loop
         HöchsteWertungZweiSchleife:
         for HöchsteWertungZweiSchleifenwert in BewertungArray'Range loop
               
            if
              Bewertung (HöchsteWertungEinsSchleifenwert).Bewertung > Bewertung (HöchsteWertungZweiSchleifenwert).Bewertung
            then
               Sortieren := Bewertung (HöchsteWertungEinsSchleifenwert);
               Bewertung (HöchsteWertungEinsSchleifenwert) := Bewertung (HöchsteWertungZweiSchleifenwert);
               Bewertung (HöchsteWertungZweiSchleifenwert) := Sortieren;
                  
            else
               null;
            end if;
               
         end loop HöchsteWertungZweiSchleife;
      end loop HöchsteWertungEinsSchleife;
      
   end BewertungSortieren;
   
   
   
   function PlanschrittFestlegen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      DurchlaufExtern : in Positive;
      AktuellePlanpositionExtern : in KartenDatentypen.Stadtfeld)
      return Boolean
   is begin
      
      case
        Bewertung (DurchlaufExtern).Bewertung
      is
         when KIKonstanten.BewertungBewegungNullwert =>
            return False;
               
         when KIKonstanten.BewertungBewegungZielpunkt =>
            SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    KoordinatenExtern        => (Bewertung (DurchlaufExtern).EAchse, Bewertung (DurchlaufExtern).YAchse, Bewertung (DurchlaufExtern).XAchse),
                                                    PlanplatzExtern          => AktuellePlanpositionExtern);
            return True;
               
         when others =>
            SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    KoordinatenExtern        => (Bewertung (DurchlaufExtern).EAchse, Bewertung (DurchlaufExtern).YAchse, Bewertung (DurchlaufExtern).XAchse),
                                                    PlanplatzExtern          => AktuellePlanpositionExtern);
            
            if
              AktuellePlanpositionExtern = EinheitenRecords.KIBewegungPlanArray'Last
            then
               return True;
         
            else
               return PlanenRekursiv (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                      AktuelleKoordinatenExtern  => (Bewertung (DurchlaufExtern).EAchse,
                                                                     Bewertung (DurchlaufExtern).YAchse,
                                                                     Bewertung (DurchlaufExtern).XAchse),
                                      AktuellePlanpositionExtern => AktuellePlanpositionExtern + 1);
            end if;
      end case;
      
   end PlanschrittFestlegen;
   
   
   
   function BewertungFeldposition
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      EÄnderungExtern : in KartenDatentypen.UmgebungsbereichEinsEAchse;
      YÄnderungExtern : in KartenDatentypen.UmgebungsbereichEins;
      XÄnderungExtern : in KartenDatentypen.UmgebungsbereichEins)
      return KIDatentypen.BewegungBewertung
   is begin
            
      if
        EÄnderungExtern = 0
        and
          YÄnderungExtern = 0
          and
            XÄnderungExtern = 0
      then
         return KIKonstanten.BewertungBewegungNullwert;

      else
         KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                   ÄnderungExtern    => (EÄnderungExtern, YÄnderungExtern, XÄnderungExtern),
                                                                                                   LogikGrafikExtern => True);
      end if;
            
      case
        KartenWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return KIKonstanten.BewertungBewegungNullwert;

         when others =>
            null;
      end case;
      
      case
        FeldBereitsBetreten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                             KoordinatenExtern        => KartenWert)
      is
         when False =>
            null;
            
         when True =>
            return KIKonstanten.BewertungBewegungNullwert;
      end case;
                  
      case
        PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern    => EinheitRasseNummerExtern,
                                                                  NeueKoordinatenExtern       => KartenWert)
      is
         when True =>
            null;
                        
         when False =>
            if
              True = TransporterNutzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                        KoordinatenExtern        => KartenWert)
            then
               null;
               
            else
               return KIKonstanten.BewertungBewegungNullwert;
            end if;
      end case;
      
      case
        KIBewegungAllgemeinLogik.FeldBetreten (FeldKoordinatenExtern    => KartenWert,
                                               EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when KIKonstanten.BewegungAngriff | KIKonstanten.BewegungNormal =>
            return BerechnungBewertungPosition (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                KoordinatenExtern        => KoordinatenExtern,
                                                NeueKoordinatenExtern    => KartenWert);
            
         when KIKonstanten.KeineBewegung =>
            return KIKonstanten.BewertungBewegungNullwert;
      end case;
      
   end BewertungFeldposition;
   
   
   
   function BerechnungBewertungPosition
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return KIDatentypen.BewegungBewertung
   is begin
      
      -- KoordinatenExtern ist der aktuelle Punkt, NeueKoordinatenExtern ist der mögliche neue Punkt.
      if
        LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = NeueKoordinatenExtern
      then
         return KIKonstanten.BewertungBewegungZielpunkt;
         
      else
         PositionAlt := (abs (SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIZielKoordinaten.EAchse - KoordinatenExtern.EAchse),
                         abs (SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIZielKoordinaten.YAchse - KoordinatenExtern.YAchse),
                         abs (SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIZielKoordinaten.XAchse - KoordinatenExtern.XAchse));

         PositionNeu := (abs (SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIZielKoordinaten.EAchse - NeueKoordinatenExtern.EAchse),
                         abs (SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIZielKoordinaten.YAchse - NeueKoordinatenExtern.YAchse),
                         abs (SpielVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Nummer).KIZielKoordinaten.XAchse - NeueKoordinatenExtern.XAchse));
      end if;
        
      if
        PositionNeu.EAchse < PositionAlt.EAchse
      then
         EÄnderung := 5;
         
      elsif
        PositionNeu.EAchse = PositionAlt.EAchse
      then
         EÄnderung := 3;
         
      else
         EÄnderung := 1;
      end if;
        
      if
        PositionNeu.YAchse < PositionAlt.YAchse
      then
         YÄnderung := 5;
         
      elsif
        PositionNeu.YAchse = PositionAlt.YAchse
      then
         YÄnderung := 3;
         
      else
         YÄnderung := 1;
      end if;
        
      if
        PositionNeu.XAchse < PositionAlt.XAchse
      then
         XÄnderung := 5;
         
      elsif
        PositionNeu.XAchse = PositionAlt.XAchse
      then
         XÄnderung := 3;
         
      else
         XÄnderung := 1;
      end if;
      
      return EÄnderung + YÄnderung + XÄnderung;
      
   end BerechnungBewertungPosition;
   
   
   
   function FeldBereitsBetreten
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
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
   
   
   
   procedure VorhandenenPlanVereinfachen
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
               VorhandenenPlanVereinfachenPrüfen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                   ErsterZugExtern         => ErsterZugSchleifenwert,
                                                   ÜberNächsterZugExtern   => ÜberNächsterZugSchleifenwert);
            end if;
            
         end loop ÜberNächsterZugSchleife;
      end loop ErsterZugSchleife;
      
   end VorhandenenPlanVereinfachen;
   
   
   
   procedure VorhandenenPlanVereinfachenPrüfen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      ErsterZugExtern : in KartenDatentypen.Stadtfeld;
      ÜberNächsterZugExtern : in KartenDatentypen.Stadtfeld)
   is begin
      
      EAchseSchleife:
      for EAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEinsEAchse'Range loop
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
      
   end VorhandenenPlanVereinfachenPrüfen;
   
   
   
   function TransporterNutzen
     (EinheitRasseNummerExtern : in EinheitenRecords.RasseEinheitnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return Boolean
   is begin
      
      EinheitenSchleife:
      for EinheitSchleifenwert in SpielVariablen.EinheitenGebautArray'Range (2) loop
         
         if
           EinheitRasseNummerExtern.Nummer = EinheitSchleifenwert
           or
             LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitSchleifenwert)) = EinheitenKonstanten.LeerID
         then
            null;
            
         elsif
           True = EinheitentransporterLogik.KannTransportiertWerden (LadungExtern      => EinheitRasseNummerExtern,
                                                                     TransporterExtern => (EinheitRasseNummerExtern.Rasse, EinheitSchleifenwert))
           and
             True = PassierbarkeitspruefungLogik.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern    => (EinheitRasseNummerExtern.Rasse, EinheitSchleifenwert),
                                                                              NeueKoordinatenExtern       => KoordinatenExtern)
         then
            -- Hier später True zurückgeben äöü
            null;
            
         else
            null;
         end if;
         
         -- Später entfernen äöü
         exit EinheitenSchleife;
         
      end loop EinheitenSchleife;
      
      return False;
      
   end TransporterNutzen;

end KIBewegungBerechnenLogik;
