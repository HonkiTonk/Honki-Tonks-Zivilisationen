pragma SPARK_Mode (On);

with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with KartenRecords; use KartenRecords;
with KartenKonstanten;
with EinheitenKonstanten;
with SystemDatentypen;

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
                                                    BeschäftigungExtern      => SystemDatentypen.Leer);
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
      for DurchlaufSchleifenwert in 1 .. 8 loop
         
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
                                                       PositionExtern           => KIKonstanten.LeerKoordinate,
                                                       PlanpositionExtern       => AktuellePlanpositionExtern);
         end case;
         
      end loop DurchlaufSchleife;
      
      return False;
      
   end PlanenRekursiv;
   
   
   
   procedure FelderBewerten
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      AktuelleKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
   is begin
      
      BewertungPosition := 1;
         
      YAchseÄnderungSchleife:
      for YAchseÄnderungSchleifenwert in KartenDatentypen.LoopRangeMinusEinsZuEins'Range loop
         XAchseÄnderungSchleife:
         for XAchseÄnderungSchleifenwert in KartenDatentypen.LoopRangeMinusEinsZuEins'Range loop
            
            FeldBewertung (YAchseÄnderungSchleifenwert, XAchseÄnderungSchleifenwert) := BewertungFeldposition (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                 KoordinatenExtern        => AktuelleKoordinatenExtern,
                                                                                                                 YÄnderungExtern          => YAchseÄnderungSchleifenwert,
                                                                                                                 XÄnderungExtern          => XAchseÄnderungSchleifenwert);
         
            Bewertung (BewertungPosition) := (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse, FeldBewertung (YAchseÄnderungSchleifenwert, XAchseÄnderungSchleifenwert));
            BewertungPosition := BewertungPosition + 1;
               
         end loop XAchseÄnderungSchleife;
      end loop YAchseÄnderungSchleife;
      
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
         when 0 =>
            return False;
               
         when 11 =>
            SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    PositionExtern           => (Bewertung (DurchlaufExtern).EAchse, Bewertung (DurchlaufExtern).YAchse, Bewertung (DurchlaufExtern).XAchse),
                                                    PlanpositionExtern       => AktuellePlanpositionExtern);
            return True;
               
         when others =>
            SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    PositionExtern           => (Bewertung (DurchlaufExtern).EAchse, Bewertung (DurchlaufExtern).YAchse, Bewertung (DurchlaufExtern).XAchse),
                                                    PlanpositionExtern       => AktuellePlanpositionExtern);
            
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
      YÄnderungExtern : in KartenDatentypen.LoopRangeMinusEinsZuEins;
      XÄnderungExtern : in KartenDatentypen.LoopRangeMinusEinsZuEins)
      return EinheitStadtDatentypen.ProduktionSonstiges
   is begin
            
      if
        YÄnderungExtern = 0
        and
          XÄnderungExtern = 0
      then
         return 0;

      else
         KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => KoordinatenExtern,
                                                                     ÄnderungExtern    => (0, YÄnderungExtern, XÄnderungExtern));
      end if;
            
      case
        KartenWert.XAchse
      is
         when KartenKonstanten.LeerXAchse =>
            return 0;

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
            return 0;
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
               return 0;
            end if;
      end case;
      
      case
        KIBewegungAllgemein.FeldBetreten (FeldPositionExtern       => KartenWert,
                                          EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when -1 | 0 =>
            return BerechnungBewertungPosition (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                KoordinatenExtern        => KoordinatenExtern,
                                                NeueKoordinatenExtern    => KartenWert);
            
         when 1 =>
            return 0;
      end case;
      
   end BewertungFeldposition;
   
   
   
   function BerechnungBewertungPosition
     (EinheitRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      NeueKoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return EinheitStadtDatentypen.ProduktionSonstiges
   is begin
      
      -- KoordinatenExtern ist der aktuelle Punkt, NeueKoordinatenExtern ist der mögliche neue Punkt.
      if
        LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = NeueKoordinatenExtern
      then
         return 11;
         
      else
         PositionAlt := (0,
                         abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse - KoordinatenExtern.YAchse),
                         abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse - KoordinatenExtern.XAchse));

         PositionNeu := (0,
                         abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse - NeueKoordinatenExtern.YAchse),
                         abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse - NeueKoordinatenExtern.XAchse));
      end if;
        
      if
        PositionNeu.YAchse < PositionAlt.YAchse
        and
          PositionNeu.XAchse < PositionAlt.XAchse
      then
         return 10;
         
      elsif
        (PositionNeu.YAchse < PositionAlt.YAchse
         and
           PositionNeu.XAchse = PositionAlt.XAchse)
        or
          (PositionNeu.YAchse = PositionAlt.YAchse
           and
             PositionNeu.XAchse < PositionAlt.XAchse)
      then
         return 5;
         
      elsif
        (PositionNeu.YAchse < PositionAlt.YAchse
         and
           PositionNeu.XAchse > PositionAlt.XAchse)
        or
          (PositionNeu.YAchse > PositionAlt.YAchse
           and
             PositionNeu.XAchse < PositionAlt.XAchse)
      then
         return 3;
        
      elsif
        (PositionNeu.YAchse = PositionAlt.YAchse
         and
           PositionNeu.XAchse > PositionAlt.XAchse)
        or
          (PositionNeu.YAchse > PositionAlt.YAchse
           and
             PositionNeu.XAchse = PositionAlt.XAchse)
      then
         return 2;
         
      else
         return 1;
      end if;
      
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
                                                                                        ÄnderungExtern    => (EÄnderungSchleifenwert, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
                     
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
                                                             PositionExtern           => LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                             PlanschrittExtern        => (ÜberNächsterZugExtern)),
                                                             PlanpositionExtern       => (PositionSchleifenwert + 1));
               
                  end loop BewegungPlanVerschiebenSchleife;
                  SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                          PositionExtern           => KIKonstanten.LeerKoordinate,
                                                          PlanpositionExtern       => EinheitStadtRecords.KIBewegungPlanArray'Last);
                           
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
             LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = EinheitenKonstanten.LeerID
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
