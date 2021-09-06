pragma SPARK_Mode (On);

with GlobaleKonstanten;

with KIKonstanten, KIDatentypen;

with SchreibeEinheitenGebaut;
with LeseEinheitenGebaut;

with KartePositionPruefen, BewegungBlockiert, BewegungPassierbarkeitPruefen, EinheitenTransporter;

package body KIBewegungBerechnen is
   
   function BewegungPlanen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
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
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten := KIKonstanten.NullKoordinate;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan := (others => KIKonstanten.NullKoordinate);
            SchreibeEinheitenGebaut.KIBeschäftigt (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    AufgabeExtern            => KIDatentypen.Tut_Nichts);
            SchreibeEinheitenGebaut.Beschäftigung (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    BeschäftigungExtern      => GlobaleDatentypen.Leer);
      end case;
      
      return PlanungErfolgreich;
      
   end BewegungPlanen;
   
   
   
   function PlanenRekursiv
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AktuelleKoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      AktuellePlanpositionExtern : in GlobaleDatentypen.Stadtfeld)
      return Boolean
   is begin
      
      DurchlaufSchleife:
      for DurchlaufSchleifenwert in 1 .. 8 loop
         
         BewertungPosition := 1;
         
         YAchseÄnderungSchleife:
         for YAchseÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            XAchseÄnderungSchleife:
            for XAchseÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            
               FeldBewertung (YAchseÄnderungSchleifenwert, XAchseÄnderungSchleifenwert) := BewertungFeldposition (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                    KoordinatenExtern        => AktuelleKoordinatenExtern,
                                                                                                                    YÄnderungExtern          => YAchseÄnderungSchleifenwert,
                                                                                                                    XÄnderungExtern          => XAchseÄnderungSchleifenwert);
         
               Bewertung (BewertungPosition) := (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse, FeldBewertung (YAchseÄnderungSchleifenwert, XAchseÄnderungSchleifenwert));
               BewertungPosition := BewertungPosition + 1;
               
            end loop XAchseÄnderungSchleife;
         end loop YAchseÄnderungSchleife;
         
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
         
         case
           Bewertung (DurchlaufSchleifenwert).Bewertung
         is
            when 0 =>
               PlanungErfolgreichRekursiv := False;
               
            when 11 =>
               SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       PositionExtern           => (Bewertung (DurchlaufSchleifenwert).EAchse, Bewertung (DurchlaufSchleifenwert).YAchse, Bewertung (DurchlaufSchleifenwert).XAchse),
                                                       PlanpositionExtern       => AktuellePlanpositionExtern);
               return True;
               
            when others =>
               SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       PositionExtern           => (Bewertung (DurchlaufSchleifenwert).EAchse, Bewertung (DurchlaufSchleifenwert).YAchse, Bewertung (DurchlaufSchleifenwert).XAchse),
                                                       PlanpositionExtern       => AktuellePlanpositionExtern);
               
               if
                 AktuellePlanpositionExtern = GlobaleRecords.KIBewegungPlanArray'Last
               then
                  return True;
         
               else
                  PlanungErfolgreichRekursiv := PlanenRekursiv (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                                                AktuelleKoordinatenExtern  => (Bewertung (DurchlaufSchleifenwert).EAchse,
                                                                                               Bewertung (DurchlaufSchleifenwert).YAchse,
                                                                                               Bewertung (DurchlaufSchleifenwert).XAchse),
                                                                AktuellePlanpositionExtern => AktuellePlanpositionExtern + 1);
               end if;
               
         end case;
         
         case
           PlanungErfolgreichRekursiv
         is
            when True =>
               return True;
               
            when False =>
               SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                       PositionExtern           => KIKonstanten.NullKoordinate,
                                                       PlanpositionExtern       => AktuellePlanpositionExtern);
         end case;
         
      end loop DurchlaufSchleife;
      
      return False;
      
   end PlanenRekursiv;
   
   
   
   function BewertungFeldposition
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      YÄnderungExtern, XÄnderungExtern : in GlobaleDatentypen.LoopRangeMinusEinsZuEins)
      return GlobaleDatentypen.ProduktionSonstiges
   is begin
      
      KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => KoordinatenExtern,
                                                                  ÄnderungExtern    => (0, YÄnderungExtern, XÄnderungExtern));
      
      if
        YÄnderungExtern = 0
        and
          XÄnderungExtern = 0
      then
         return 0;

      else
         null;
      end if;
            
      case
        KartenWert.XAchse
      is
         when GlobaleKonstanten.LeerYXKartenWert =>
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
        BewegungBlockiert.FeldBlockiert (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                         NeuePositionExtern       => KartenWert)
      is
         when False =>   
            null;
            
         when True =>
            return 0;
      end case;
      
      return BerechnungBewertungPosition (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                          KoordinatenExtern        => KoordinatenExtern,
                                          NeueKoordinatenExtern    => KartenWert);
      
   end BewertungFeldposition;
   
   
   
   function BerechnungBewertungPosition
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      KoordinatenExtern, NeueKoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.ProduktionSonstiges
   is begin
      
      -- KoordinatenExtern ist der aktuelle Punkt, NeueKoordinatenExtern ist der mögliche neue Punkt.
      if
        LeseEinheitenGebaut.KIZielKoordinaten (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = NeueKoordinatenExtern
      then
         return 11;
         
      else
         PositionAltEins := (0,
                             abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse - KoordinatenExtern.YAchse),
                             abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse - KoordinatenExtern.XAchse));
         PositionAltZwei := (0,
                             abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse - KoordinatenExtern.YAchse
                               + Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße),
                             abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse - KoordinatenExtern.XAchse
                               + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));
         PositionAltDrei := (0,
                             abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse + KoordinatenExtern.YAchse
                               - Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße),
                             abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse + KoordinatenExtern.XAchse
                               - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));

         PositionNeuEins := (0,
                             abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse - NeueKoordinatenExtern.YAchse),
                             abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse - NeueKoordinatenExtern.XAchse));
         PositionNeuZwei := (0,
                             abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse - NeueKoordinatenExtern.YAchse
                               + Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße),
                             abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse - NeueKoordinatenExtern.XAchse
                               + Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));
         PositionNeuDrei := (0,
                             abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse + NeueKoordinatenExtern.YAchse
                               - Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße),
                             abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse + NeueKoordinatenExtern.XAchse
                               - Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße));
      end if;
        
      if
        ((PositionNeuEins.YAchse < PositionAltEins.YAchse
          and
            PositionNeuEins.YAchse < PositionAltZwei.YAchse
          and
            PositionNeuEins.YAchse < PositionAltDrei.YAchse)
         or
           (PositionNeuZwei.YAchse < PositionAltEins.YAchse
            and
              PositionNeuZwei.YAchse < PositionAltZwei.YAchse
            and
              PositionNeuZwei.YAchse < PositionAltDrei.YAchse)
         or
           (PositionNeuDrei.YAchse < PositionAltEins.YAchse
            and
              PositionNeuDrei.YAchse < PositionAltZwei.YAchse
            and
              PositionNeuDrei.YAchse < PositionAltDrei.YAchse))
        and
          ((PositionNeuEins.XAchse < PositionAltEins.XAchse
            and
              PositionNeuEins.XAchse < PositionAltZwei.XAchse
            and
              PositionNeuEins.XAchse < PositionAltDrei.XAchse)
           or
             (PositionNeuZwei.XAchse < PositionAltEins.XAchse
              and
                PositionNeuZwei.XAchse < PositionAltZwei.XAchse
              and
                PositionNeuZwei.XAchse < PositionAltDrei.XAchse)
           or
             (PositionNeuDrei.XAchse < PositionAltEins.XAchse
              and
                PositionNeuDrei.XAchse < PositionAltZwei.XAchse
              and
                PositionNeuDrei.XAchse < PositionAltDrei.XAchse))
      then
         return 10;
         
      elsif
        (((PositionNeuEins.YAchse < PositionAltEins.YAchse
           and
             PositionNeuEins.YAchse < PositionAltZwei.YAchse
           and
             PositionNeuEins.YAchse < PositionAltDrei.YAchse)
          or
            (PositionNeuZwei.YAchse < PositionAltEins.YAchse
             and
               PositionNeuZwei.YAchse < PositionAltZwei.YAchse
             and
               PositionNeuZwei.YAchse < PositionAltDrei.YAchse)
          or
            (PositionNeuDrei.YAchse < PositionAltEins.YAchse
             and
               PositionNeuDrei.YAchse < PositionAltZwei.YAchse
             and
               PositionNeuDrei.YAchse < PositionAltDrei.YAchse))
         and
           ((PositionNeuEins.XAchse = PositionAltEins.XAchse
             and
               PositionNeuEins.XAchse = PositionAltZwei.XAchse
             and
               PositionNeuEins.XAchse = PositionAltDrei.XAchse)
            or
              (PositionNeuZwei.XAchse = PositionAltEins.XAchse
               and
                 PositionNeuZwei.XAchse = PositionAltZwei.XAchse
               and
                 PositionNeuZwei.XAchse = PositionAltDrei.XAchse)
            or
              (PositionNeuDrei.XAchse = PositionAltEins.XAchse
               and
                 PositionNeuDrei.XAchse = PositionAltZwei.XAchse
               and
                 PositionNeuDrei.XAchse = PositionAltDrei.XAchse)))
        or
          (((PositionNeuEins.YAchse = PositionAltEins.YAchse
             and
               PositionNeuEins.YAchse = PositionAltZwei.YAchse
             and
               PositionNeuEins.YAchse = PositionAltDrei.YAchse)
            or
              (PositionNeuZwei.YAchse = PositionAltEins.YAchse
               and
                 PositionNeuZwei.YAchse = PositionAltZwei.YAchse
               and
                 PositionNeuZwei.YAchse = PositionAltDrei.YAchse)
            or
              (PositionNeuDrei.YAchse = PositionAltEins.YAchse
               and
                 PositionNeuDrei.YAchse = PositionAltZwei.YAchse
               and
                 PositionNeuDrei.YAchse = PositionAltDrei.YAchse))
           and
             ((PositionNeuEins.XAchse < PositionAltEins.XAchse
               and
                 PositionNeuEins.XAchse < PositionAltZwei.XAchse
               and
                 PositionNeuEins.XAchse < PositionAltDrei.XAchse)
              or
                (PositionNeuZwei.XAchse < PositionAltEins.XAchse
                 and
                   PositionNeuZwei.XAchse < PositionAltZwei.XAchse
                 and
                   PositionNeuZwei.XAchse < PositionAltDrei.XAchse)
              or
                (PositionNeuDrei.XAchse < PositionAltEins.XAchse
                 and
                   PositionNeuDrei.XAchse < PositionAltZwei.XAchse
                 and
                   PositionNeuDrei.XAchse < PositionAltDrei.XAchse)))
      then
         return 5;
         
      elsif
        (((PositionNeuEins.YAchse < PositionAltEins.YAchse
           and
             PositionNeuEins.YAchse < PositionAltZwei.YAchse
           and
             PositionNeuEins.YAchse < PositionAltDrei.YAchse)
          or
            (PositionNeuZwei.YAchse < PositionAltEins.YAchse
             and
               PositionNeuZwei.YAchse < PositionAltZwei.YAchse
             and
               PositionNeuZwei.YAchse < PositionAltDrei.YAchse)
          or
            (PositionNeuDrei.YAchse < PositionAltEins.YAchse
             and
               PositionNeuDrei.YAchse < PositionAltZwei.YAchse
             and
               PositionNeuDrei.YAchse < PositionAltDrei.YAchse))
         and
           ((PositionNeuEins.XAchse > PositionAltEins.XAchse
             and
               PositionNeuEins.XAchse > PositionAltZwei.XAchse
             and
               PositionNeuEins.XAchse > PositionAltDrei.XAchse)
            or
              (PositionNeuZwei.XAchse > PositionAltEins.XAchse
               and
                 PositionNeuZwei.XAchse > PositionAltZwei.XAchse
               and
                 PositionNeuZwei.XAchse > PositionAltDrei.XAchse)
            or
              (PositionNeuDrei.XAchse > PositionAltEins.XAchse
               and
                 PositionNeuDrei.XAchse > PositionAltZwei.XAchse
               and
                 PositionNeuDrei.XAchse > PositionAltDrei.XAchse)))
        or
          (((PositionNeuEins.YAchse > PositionAltEins.YAchse
             and
               PositionNeuEins.YAchse > PositionAltZwei.YAchse
             and
               PositionNeuEins.YAchse > PositionAltDrei.YAchse)
            or
              (PositionNeuZwei.YAchse > PositionAltEins.YAchse
               and
                 PositionNeuZwei.YAchse > PositionAltZwei.YAchse
               and
                 PositionNeuZwei.YAchse > PositionAltDrei.YAchse)
            or
              (PositionNeuDrei.YAchse > PositionAltEins.YAchse
               and
                 PositionNeuDrei.YAchse > PositionAltZwei.YAchse
               and
                 PositionNeuDrei.YAchse > PositionAltDrei.YAchse))
           and
             ((PositionNeuEins.XAchse < PositionAltEins.XAchse
               and
                 PositionNeuEins.XAchse < PositionAltZwei.XAchse
               and
                 PositionNeuEins.XAchse < PositionAltDrei.XAchse)
              or
                (PositionNeuZwei.XAchse < PositionAltEins.XAchse
                 and
                   PositionNeuZwei.XAchse < PositionAltZwei.XAchse
                 and
                   PositionNeuZwei.XAchse < PositionAltDrei.XAchse)
              or
                (PositionNeuDrei.XAchse < PositionAltEins.XAchse
                 and
                   PositionNeuDrei.XAchse < PositionAltZwei.XAchse
                 and
                   PositionNeuDrei.XAchse < PositionAltDrei.XAchse)))
      then
         return 3;  
        
      elsif
        (((PositionNeuEins.YAchse = PositionAltEins.YAchse
           and
             PositionNeuEins.YAchse = PositionAltZwei.YAchse
           and
             PositionNeuEins.YAchse = PositionAltDrei.YAchse)
          or
            (PositionNeuZwei.YAchse = PositionAltEins.YAchse
             and
               PositionNeuZwei.YAchse = PositionAltZwei.YAchse
             and
               PositionNeuZwei.YAchse = PositionAltDrei.YAchse)
          or
            (PositionNeuDrei.YAchse = PositionAltEins.YAchse
             and
               PositionNeuDrei.YAchse = PositionAltZwei.YAchse
             and
               PositionNeuDrei.YAchse = PositionAltDrei.YAchse))
         and
           ((PositionNeuEins.XAchse > PositionAltEins.XAchse
             and
               PositionNeuEins.XAchse > PositionAltZwei.XAchse
             and
               PositionNeuEins.XAchse > PositionAltDrei.XAchse)
            or
              (PositionNeuZwei.XAchse > PositionAltEins.XAchse
               and
                 PositionNeuZwei.XAchse > PositionAltZwei.XAchse
               and
                 PositionNeuZwei.XAchse > PositionAltDrei.XAchse)
            or
              (PositionNeuDrei.XAchse > PositionAltEins.XAchse
               and
                 PositionNeuDrei.XAchse > PositionAltZwei.XAchse
               and
                 PositionNeuDrei.XAchse > PositionAltDrei.XAchse)))
        or
          (((PositionNeuEins.YAchse > PositionAltEins.YAchse
             and
               PositionNeuEins.YAchse > PositionAltZwei.YAchse
             and
               PositionNeuEins.YAchse > PositionAltDrei.YAchse)
            or
              (PositionNeuZwei.YAchse > PositionAltEins.YAchse
               and
                 PositionNeuZwei.YAchse > PositionAltZwei.YAchse
               and
                 PositionNeuZwei.YAchse > PositionAltDrei.YAchse)
            or
              (PositionNeuDrei.YAchse > PositionAltEins.YAchse
               and
                 PositionNeuDrei.YAchse > PositionAltZwei.YAchse
               and
                 PositionNeuDrei.YAchse > PositionAltDrei.YAchse))
           and
             ((PositionNeuEins.XAchse = PositionAltEins.XAchse
               and
                 PositionNeuEins.XAchse = PositionAltZwei.XAchse
               and
                 PositionNeuEins.XAchse = PositionAltDrei.XAchse)
              or
                (PositionNeuZwei.XAchse = PositionAltEins.XAchse
                 and
                   PositionNeuZwei.XAchse = PositionAltZwei.XAchse
                 and
                   PositionNeuZwei.XAchse = PositionAltDrei.XAchse)
              or
                (PositionNeuDrei.XAchse = PositionAltEins.XAchse
                 and
                   PositionNeuDrei.XAchse = PositionAltZwei.XAchse
                 and
                   PositionNeuDrei.XAchse = PositionAltDrei.XAchse)))
      then
         return 2;
         
      else
         return 1;
      end if;
      
   end BerechnungBewertungPosition;
   
   
   
   function FeldBereitsBetreten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      FelderSchleife:
      for FelderSchleifenwert in GlobaleRecords.KIBewegungPlanArray'Range loop
         
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
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      ErsterZugSchleife:
      for ErsterZugSchleifenwert in GlobaleRecords.KIBewegungPlanArray'Range loop
         ÜberNächsterZugSchleife:
         for ÜberNächsterZugSchleifenwert in GlobaleRecords.KIBewegungPlanArray'Range loop
            
            if
              LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                  PlanschrittExtern        => ÜberNächsterZugSchleifenwert)
              = KIKonstanten.NullKoordinate
              or
                LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                    PlanschrittExtern        => ErsterZugSchleifenwert)
              = KIKonstanten.NullKoordinate
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
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      ErsterZugExtern, ÜberNächsterZugExtern : in GlobaleDatentypen.Stadtfeld)
   is begin
      
      EAchseSchleife:
      for EÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         YAchseSchleife:
         for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            XAchseSchleife:
            for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
               
               KartenWertVereinfachung := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                                                 PlanschrittExtern        => ErsterZugExtern),
                                                                                        ÄnderungExtern    => (EÄnderungSchleifenwert, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
                     
               if
                 KartenWertVereinfachung.XAchse = GlobaleKonstanten.LeerYXKartenWert
               then
                  null;
              
               elsif
                 KartenWertVereinfachung = LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                               PlanschrittExtern        => ÜberNächsterZugExtern)
               then
                  BewegungPlanVerschiebenSchleife:
                  for PositionSchleifenwert in ErsterZugExtern .. GlobaleRecords.KIBewegungPlanArray'Last - 1 loop
               
                     SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                             PositionExtern           => LeseEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                                                             PlanschrittExtern        => (ÜberNächsterZugExtern)),
                                                             PlanpositionExtern       => (PositionSchleifenwert + 1));
               
                  end loop BewegungPlanVerschiebenSchleife;
                  SchreibeEinheitenGebaut.KIBewegungPlan (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                          PositionExtern           => KIKonstanten.NullKoordinate,
                                                          PlanpositionExtern       => GlobaleRecords.KIBewegungPlanArray'Last);
                           
               else
                  null;
               end if;
                  
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
   end VorhandenenPlanVereinfachenPrüfen;
   
   
   
   function TransporterNutzen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      EinheitenSchleife:
      for EinheitSchleifenwert in GlobaleVariablen.EinheitenGebautArray'Range (2) loop
         
         if
           EinheitRasseNummerExtern.Platznummer = EinheitSchleifenwert
           or
             LeseEinheitenGebaut.ID (EinheitRasseNummerExtern => EinheitRasseNummerExtern) = GlobaleKonstanten.LeerEinheitenID
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
