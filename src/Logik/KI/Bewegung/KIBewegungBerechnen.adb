pragma SPARK_Mode (On);

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenRecords; use KartenRecords;
with KartenKonstanten;
with EinheitenKonstanten;

with KIDatentypen; use KIDatentypen;
with KIKonstanten;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;

with KartePositionPruefen;
with BewegungPassierbarkeitPruefen;
with EinheitenTransporter;

with KIBewegungAllgemein;

package body KIBewegungBerechnen is
   
   function BewegungPlanen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
      return Boolean
   is begin
               
      PlanungErfolgreich := PlanenRekursiv (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                            AktuelleKoordinatenExtern  => LeseEinheitenGebaut.Position (EinheitRasseNummerExtern => EinheitRasseNummerExtern),
                                            AktuellePlanpositionExtern => 1);
      
      case
        PlanungErfolgreich
      is
         when True =>
            VorhandenenPlanVereinfachen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when False =>
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten := KIKonstanten.LeerKoordinate;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan := (others => KIKonstanten.LeerKoordinate);
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Tut_Nichts);
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern      => SystemKonstanten.LeerTastenbelegungKonstante);
      end case;
      
      return PlanungErfolgreich;
      
   end BewegungPlanen;
   
   
   
   function PlanenRekursiv
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
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
                                                       KoordinatenExtern        => KIKonstanten.LeerKoordinate,
                                                       PlanplatzExtern          => AktuellePlanpositionExtern);
         end case;
         
      end loop DurchlaufSchleife;
      
      return False;
      
   end PlanenRekursiv;
   
   
   
   procedure FelderBewerten
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      BewertungPosition := BewertungArray'First;
      
      EAchseÄnderungSchleife:
      for EAchseÄnderungSchleifenwert in KartenDatentypen.LoopRangeMinusEinsZuEins'Range loop
         YAchseÄnderungSchleife:
         for YAchseÄnderungSchleifenwert in KartenDatentypen.LoopRangeMinusEinsZuEins'Range loop
            XAchseÄnderungSchleife:
            for XAchseÄnderungSchleifenwert in KartenDatentypen.LoopRangeMinusEinsZuEins'Range loop
            
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
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
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
              AktuellePlanpositionExtern = EinheitStadtRecords.KIBewegungPlanArray'Last
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
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      EÄnderungExtern : in KartenDatentypen.LoopRangeMinusEinsZuEins;
      YÄnderungExtern : in KartenDatentypen.LoopRangeMinusEinsZuEins;
      XÄnderungExtern : in KartenDatentypen.LoopRangeMinusEinsZuEins)
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
         KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => KoordinatenExtern,
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
        BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                   NeuePositionExtern       => KartenWert)
      is
         when True =>
            null;
                        
         when False =>
            if
              TransporterNutzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                 KoordinatenExtern        => KartenWert)
              = True
            then
               null;
               
            else
               return KIKonstanten.BewertungBewegungNullwert;
            end if;
      end case;
      
      case
        KIBewegungAllgemein.FeldBetreten (FeldPositionExtern       => KartenWert,
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
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return KIDatentypen.BewegungBewertung
   is begin
      
      -- KoordinatenExtern ist der aktuelle Punkt, NeueKoordinatenExtern ist der mögliche neue Punkt.
      if
        LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = NeueKoordinatenExtern
      then
         return KIKonstanten.BewertungBewegungZielpunkt;
         
      else
         PositionAlt := (abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.EAchse - KoordinatenExtern.EAchse),
                         abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse - KoordinatenExtern.YAchse),
                         abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse - KoordinatenExtern.XAchse));

         PositionNeu := (abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.EAchse - NeueKoordinatenExtern.EAchse),
                         abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse - NeueKoordinatenExtern.YAchse),
                         abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse - NeueKoordinatenExtern.XAchse));
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
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      FelderSchleife:
      for FelderSchleifenwert in EinheitStadtRecords.KIBewegungPlanArray'Range loop
         
         if
           LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                               PlanschrittExtern        => FelderSchleifenwert)
           = KoordinatenExtern
         then
            return True;
            
         else
            null;
         end if;
         
      end loop FelderSchleife;
      
      return False;
      
   end FeldBereitsBetreten;
   
   
   
   procedure VorhandenenPlanVereinfachen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord)
   is begin
      
      ErsterZugSchleife:
      for ErsterZugSchleifenwert in EinheitStadtRecords.KIBewegungPlanArray'Range loop
         ÜberNächsterZugSchleife:
         for ÜberNächsterZugSchleifenwert in EinheitStadtRecords.KIBewegungPlanArray'Range loop
            
            if
              LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  PlanschrittExtern        => ÜberNächsterZugSchleifenwert)
              = KIKonstanten.LeerKoordinate
              or
                LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    PlanschrittExtern        => ErsterZugSchleifenwert)
              = KIKonstanten.LeerKoordinate
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
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      ErsterZugExtern : in KartenDatentypen.Stadtfeld;
      ÜberNächsterZugExtern : in KartenDatentypen.Stadtfeld)
   is begin
      
      EAchseSchleife:
      for EÄnderungSchleifenwert in KartenDatentypen.LoopRangeMinusEinsZuEins'Range loop
         YAchseSchleife:
         for YÄnderungSchleifenwert in KartenDatentypen.LoopRangeMinusEinsZuEins'Range loop
            XAchseSchleife:
            for XÄnderungSchleifenwert in KartenDatentypen.LoopRangeMinusEinsZuEins'Range loop
               
               KartenWertVereinfachung := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                                 PlanschrittExtern        => ErsterZugExtern),
                                                                                        ÄnderungExtern    => (EÄnderungSchleifenwert, YÄnderungSchleifenwert, XÄnderungSchleifenwert),
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
                  for PositionSchleifenwert in ErsterZugExtern .. EinheitStadtRecords.KIBewegungPlanArray'Last - 1 loop
               
                     SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             KoordinatenExtern        => LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                             PlanschrittExtern        => (ÜberNächsterZugExtern)),
                                                             PlanplatzExtern          => (PositionSchleifenwert + 1));
               
                  end loop BewegungPlanVerschiebenSchleife;
                  
                  SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                          KoordinatenExtern        => KIKonstanten.LeerKoordinate,
                                                          PlanplatzExtern          => EinheitStadtRecords.KIBewegungPlanArray'Last);
                           
               else
                  null;
               end if;
                  
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
   end VorhandenenPlanVereinfachenPrüfen;
   
   
   
   function TransporterNutzen
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      EinheitenSchleife:
      for EinheitSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
         
         if
           EinheitRasseNummerExtern.Platznummer = EinheitSchleifenwert
           or
             LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitSchleifenwert)) = EinheitenKonstanten.LeerID
         then
            null;
            
         elsif
           EinheitenTransporter.KannTransportiertWerden (LadungExtern      => EinheitRasseNummerExtern,
                                                         TransporterExtern => (EinheitRasseNummerExtern.Rasse, EinheitSchleifenwert))
             = True
           and
             BewegungPassierbarkeitPruefen.PassierbarkeitPrüfenNummer (EinheitRasseNummerExtern => (EinheitRasseNummerExtern.Rasse, EinheitSchleifenwert),
                                                                        NeuePositionExtern       => KoordinatenExtern)
           = True
         then
            -- Hier später True zurückgeben
            null;
            
         else
            null;
         end if;
         
         -- Später entfernen
         exit EinheitenSchleife;
         
      end loop EinheitenSchleife;
      
      return False;
      
   end TransporterNutzen;

end KIBewegungBerechnen;
