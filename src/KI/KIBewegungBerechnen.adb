pragma SPARK_Mode (On);

with KartenPruefungen, BewegungBlockiert, KIPruefungen, BewegungPassierbarkeitPruefen;

package body KIBewegungBerechnen is
   
   function BewegungPlanen
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
      return Boolean
   is begin
      
      PlanungErfolgreich := PlanenRekursiv (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                            AktuelleKoordinatenExtern  => GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).AchsenPosition,
                                            AktuellePlanpositionExtern => 1);
      
      case
        PlanungErfolgreich
      is
         when True =>
            null;
            
         when False => -- Hier noch eine Entfernung der Zielkoordinaten/Aufgabe einfügen, wenn die Planung fehlschlägt? Oder Ziel/Aufgabe ändern?
            null;
      end case;
      
      -- Hier noch eine Prüfung auf Vereinfachung des Wegplans einbauen?
      
      return PlanungErfolgreich;
      
   end BewegungPlanen;
   
   
   
   function PlanenRekursiv
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      AktuelleKoordinatenExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      AktuellePlanpositionExtern : in Positive)
      return Boolean
   is begin
      
      if
        AktuellePlanpositionExtern > 10
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
         
               Bewertung (BewertungPosition) := (FeldBewertung (YAchseÄnderungSchleifenwert, XAchseÄnderungSchleifenwert), YAchseÄnderungSchleifenwert, XAchseÄnderungSchleifenwert);
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
                 := (AktuelleKoordinatenExtern.EAchse, AktuelleKoordinatenExtern.YAchse + Bewertung (DurchlaufSchleifenwert).YÄnderung, AktuelleKoordinatenExtern.XAchse + Bewertung (DurchlaufSchleifenwert).XÄnderung);
               return True;
               
            when others =>
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (AktuellePlanpositionExtern)
                 := (AktuelleKoordinatenExtern.EAchse, AktuelleKoordinatenExtern.YAchse + Bewertung (DurchlaufSchleifenwert).YÄnderung, AktuelleKoordinatenExtern.XAchse + Bewertung (DurchlaufSchleifenwert).XÄnderung);
               
               PlanungErfolgreich := PlanenRekursiv (EinheitRasseNummerExtern   => EinheitRasseNummerExtern,
                                                     AktuelleKoordinatenExtern  => (AktuelleKoordinatenExtern.EAchse,
                                                                                    AktuelleKoordinatenExtern.YAchse + Bewertung (DurchlaufSchleifenwert).YÄnderung,
                                                                                    AktuelleKoordinatenExtern.XAchse + Bewertung (DurchlaufSchleifenwert).XÄnderung),
                                                     AktuellePlanpositionExtern => AktuellePlanpositionExtern + 1);
         end case;
         
         case
           PlanungErfolgreich
         is
            when True =>
               return True;
               
            when False =>
               GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIBewegungPlan (AktuellePlanpositionExtern) := (0, 0, 0);
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
      
      Kartenwert := KartenPruefungen.KartenPositionBestimmen (KoordinatenExtern    => KoordinatenExtern,
                                                              ÄnderungExtern       => (0, YÄnderungExtern, XÄnderungExtern),
                                                              ZusatzYAbstandExtern => 0);
            
      case
        Kartenwert.Erfolgreich
      is
         when False =>
            return 0;
                  
         when True =>
            null;
      end case;
      
      FeldSchonBetreten := FeldBereitsBetreten (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                KoordinatenExtern        => (Kartenwert.EAchse, Kartenwert.YAchse, Kartenwert.XAchse));
      
      case
        FeldSchonBetreten
      is            
         when False =>
            null;
            
         when True =>
            return 0;
      end case;
                  
      FeldPassierbar := BewegungPassierbarkeitPruefen.FeldFürDieseEinheitPassierbarNeu (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                                         NeuePositionExtern       => (Kartenwert.EAchse, Kartenwert.YAchse, Kartenwert.XAchse));
                  
      case
        FeldPassierbar
      is
         when GlobaleDatentypen.Normale_Bewegung_Möglich =>                  
            null;
                        
         when others =>
            return 0;
      end case;
   
      FeldBlockiert := BewegungBlockiert.BlockiertStadtEinheit (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                NeuePositionExtern       => (Kartenwert.EAchse, Kartenwert.YAchse, Kartenwert.XAchse));
                  
      case
        FeldBlockiert
      is
         when GlobaleDatentypen.Normale_Bewegung_Möglich =>   
            null;
                        
         when others =>
            return 0;
      end case;
      
      if
        GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten = (Kartenwert.EAchse, Kartenwert.YAchse, Kartenwert.XAchse)
      then
         return 11;
        
      elsif
      abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse - Kartenwert.YAchse)
        < abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse - KoordinatenExtern.YAchse)
        and
      abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse - Kartenwert.XAchse)
        < abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse - KoordinatenExtern.XAchse)
      then
         return 10;
         
      elsif
      abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse - Kartenwert.YAchse)
        < abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.YAchse - KoordinatenExtern.YAchse)
        or
      abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse - Kartenwert.XAchse)
        < abs (GlobaleVariablen.EinheitenGebaut (EinheitRasseNummerExtern.Rasse, EinheitRasseNummerExtern.Platznummer).KIZielKoordinaten.XAchse - KoordinatenExtern.XAchse)
      then
         return 5;
         
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
   


   procedure NeuesZielErmittelnGefahr
     (EinheitRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      RichtungExtern : in KIDatentypen.Richtung_Enum)
   is begin
      
      ZielKoordinaten := KIPruefungen.NähesteEigeneStadtSuchen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                 RichtungExtern         => RichtungExtern);

      case
        ZielKoordinaten.Erfolgreich
      is
         when True =>
            return;
            
         when False =>
            ZielKoordinaten := KIPruefungen.NähesteEigeneEinheitSuchen (EinheitRasseNummerExtern => EinheitRasseNummerExtern,
                                                                         RichtungExtern         => RichtungExtern);
      end case;            

   end NeuesZielErmittelnGefahr;

end KIBewegungBerechnen;
