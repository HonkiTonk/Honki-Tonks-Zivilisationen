pragma SPARK_Mode (On);

with KIKonstanten, KIDatentypen;

with KartenPruefungen, BewegungBlockiert, BewegungPassierbarkeitPruefen, KINullwerteSetzen;

package body KIBewegungBerechnen is
   
   function BewegungPlanen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
            
      case
        TransporterNötig (EinheitRasseNummerExtern => EinheitRasseNummerExtern)
      is
         when False =>
            null;
            
         when True =>            
            KINullwerteSetzen.ZielBewegungNullSetzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                      WelchenWertNullSetzten   => 0);
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Keine_Aufgabe;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung := GlobaleDatentypen.Keine;
            return False;
      end case;
      
      PlanungErfolgreich := PlanenRekursiv (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                            AktuelleKoordinatenExtern  => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Position,
                                            AktuellePlanpositionExtern => 1);
      
      case
        PlanungErfolgreich
      is
         when True =>
            VorhandenenPlanVereinfachen (EinheitRasseNummerExtern => EinheitRasseNummerExtern);
            
         when False =>
            KINullwerteSetzen.ZielBewegungNullSetzen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                      WelchenWertNullSetzten   => 0);
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBeschäftigt := KIDatentypen.Keine_Aufgabe;
            GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).Beschäftigung := GlobaleDatentypen.Keine;
      end case;
      
      return PlanungErfolgreich;
      
   end BewegungPlanen;
   
   
   
   function PlanenRekursiv
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AktuelleKoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      AktuellePlanpositionExtern : in Positive)
      return Boolean
   is begin
      
      if
        AktuellePlanpositionExtern > GlobaleRecords.KIBewegungPlanArray'Last
      then
         return True;
         
      else
         null;
      end if;
      
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
               PlanungErfolgreich := False;
               
            when 11 =>
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (AktuellePlanpositionExtern)
                 := (Bewertung (DurchlaufSchleifenwert).EAchse, Bewertung (DurchlaufSchleifenwert).YAchse, Bewertung (DurchlaufSchleifenwert).XAchse);
               return True;
               
            when others =>
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (AktuellePlanpositionExtern)
                 := (Bewertung (DurchlaufSchleifenwert).EAchse, Bewertung (DurchlaufSchleifenwert).YAchse, Bewertung (DurchlaufSchleifenwert).XAchse);
               
               PlanungErfolgreich := PlanenRekursiv (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                                     AktuelleKoordinatenExtern  => (Bewertung (DurchlaufSchleifenwert).EAchse,
                                                                                    Bewertung (DurchlaufSchleifenwert).YAchse,
                                                                                    Bewertung (DurchlaufSchleifenwert).XAchse),
                                                     AktuellePlanpositionExtern => AktuellePlanpositionExtern + 1);
         end case;
         
         case
           PlanungErfolgreich
         is
            when True =>
               return True;
               
            when False =>
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (AktuellePlanpositionExtern) := KIKonstanten.NullKoordinate;
         end case;
         
      end loop DurchlaufSchleife;
      
      return False;
      
   end PlanenRekursiv;
   
   
   
   function BewertungFeldposition
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      YÄnderungExtern, XÄnderungExtern : in GlobaleDatentypen.LoopRangeMinusEinsZuEins)
      return Natural
   is begin
      
      if
        YÄnderungExtern = 0
        and
          XÄnderungExtern = 0
      then
         return 0;

      else
         null;
      end if;
      
      KartenWert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => KoordinatenExtern,
                                                              ÄnderungExtern       => (0, YÄnderungExtern, XÄnderungExtern));
      
      case
        KartenWert.YAchse
      is
         when 0 =>
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
        BewegungPassierbarkeitPruefen.FeldFürDieseEinheitPassierbarNeu (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                         NeuePositionExtern       => KartenWert)
      is
         when GlobaleDatentypen.Normale_Bewegung_Möglich =>                  
            null;
                        
         when others =>
            return 0;
      end case;
                  
      case
        BewegungBlockiert.BlockiertStadtEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                 NeuePositionExtern       => KartenWert)
      is
         when GlobaleDatentypen.Normale_Bewegung_Möglich =>   
            null;
                        
         when others =>
            return 0;
      end case;
      
      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten = KartenWert
      then
         return 11;
        
      elsif
      abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse - KartenWert.YAchse)
        < abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse - KoordinatenExtern.YAchse)
        and
      abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse - KartenWert.XAchse)
        < abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse - KoordinatenExtern.XAchse)
      then
         return 10;
         
      elsif
        (abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse - KartenWert.YAchse)
         < abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse - KoordinatenExtern.YAchse)
         and
         abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse - KartenWert.XAchse)
         = abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse - KoordinatenExtern.XAchse))
        or
          (abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse - KartenWert.YAchse)
           = abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse - KoordinatenExtern.YAchse)
           and
           abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse - KartenWert.XAchse)
           < abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse - KoordinatenExtern.XAchse))
      then
         return 5;
         
      elsif
        (abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse - KartenWert.YAchse)
         < abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse - KoordinatenExtern.YAchse)
         and
         abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse - KartenWert.XAchse)
         > abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse - KoordinatenExtern.XAchse))
        or
          (abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse - KartenWert.YAchse)
           > abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse - KoordinatenExtern.YAchse)
           and
           abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse - KartenWert.XAchse)
           < abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse - KoordinatenExtern.XAchse))
      then
         return 3;  
        
      elsif        
        (abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse - KartenWert.YAchse)
         > abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse - KoordinatenExtern.YAchse)
         and
         abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse - KartenWert.XAchse)
         = abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse - KoordinatenExtern.XAchse))
        or
          (abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse - KartenWert.YAchse)
           = abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse - KoordinatenExtern.YAchse)
           and
           abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse - KartenWert.XAchse)
           > abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse - KoordinatenExtern.XAchse))
      then
         return 2;
         
      else
         return 1;
      end if;
      
   end BewertungFeldposition;
   
   
   
   function FeldBereitsBetreten
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      KoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      FelderSchleife:
      for FelderSchleifenwert in GlobaleRecords.KIBewegungPlanArray'Range loop
         
         if
           GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (FelderSchleifenwert) = KoordinatenExtern
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
              GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (ÜberNächsterZugSchleifenwert) = KIKonstanten.NullKoordinate
              or
                GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (ErsterZugSchleifenwert) = KIKonstanten.NullKoordinate
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
      ErsterZugExtern, ÜberNächsterZugExtern : in Positive)
   is begin
      
      EAchseSchleife:
      for EÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
         YAchseSchleife:
         for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
            XAchseSchleife:
            for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusEinsZuEins'Range loop
                  
               KartenWertVereinfachung := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse,
                                                                                    EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (ErsterZugExtern),
                                                                                    ÄnderungExtern       => (GlobaleDatentypen.Ebene (EÄnderungSchleifenwert), YÄnderungSchleifenwert, XÄnderungSchleifenwert));
                     
               exit XAchseSchleife when KartenWertVereinfachung.YAchse = 0;
                        
               if
                 KartenWertVereinfachung = GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (ÜberNächsterZugExtern)
               then
                  BewegungPlanVerschiebenSchleife:
                  for PositionSchleifenwert in ErsterZugExtern .. GlobaleRecords.KIBewegungPlanArray'Last - 1 loop
               
                     GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (PositionSchleifenwert + 1)
                       := GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (ÜberNächsterZugExtern);
               
                  end loop BewegungPlanVerschiebenSchleife;
                  GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (GlobaleRecords.KIBewegungPlanArray'Last) := KIKonstanten.NullKoordinate;
                           
               else
                  null;
               end if;
                  
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
   end VorhandenenPlanVereinfachenPrüfen;
   
   
   
   function TransporterNötig
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      return False;
      
   end TransporterNötig;

end KIBewegungBerechnen;
