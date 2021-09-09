pragma SPARK_Mode (On);

with GlobaleKonstanten;

with SchreibeKarten, SchreibeStadtGebaut;
with LeseKarten;

with KartePositionPruefen, GesamtwerteFeld, StadtUmgebungsbereichFestlegen, GebaeudeRichtigeUmgebung;

package body StadtWerteFestlegen is
   
   procedure StadtUmgebungGrößeFestlegenTechnologie
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      StadtSchleife:
      for StadtSchleifenwert in GlobaleVariablen.StadtGebautArray'First (2) .. GlobaleVariablen.Grenzen (RasseExtern).Städtegrenze loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert))
         is
            when GlobaleKonstanten.LeerStadtID =>
               null;
               
            when others =>
               StadtUmgebungGrößeFestlegen (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert));
         end case;
         
      end loop StadtSchleife;
      
   end StadtUmgebungGrößeFestlegenTechnologie;
   
   

   procedure StadtUmgebungGrößeFestlegen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin    
            
      GrößeAlt := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);
      StadtUmgebungsbereichFestlegen.StadtUmgebungsbereichFestlegen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      GrößeNeu := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);

      -- StadtUmgebungGröße darf hier nicht genutzt werden, damit bei einer Verkleinerung auch alle Felder zurückgenommen werden können.
      YAchseSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                        ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
            
            if
              KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
               
            elsif
              (abs (YÄnderungSchleifenwert) > GrößeNeu
               or
               abs (XÄnderungSchleifenwert) > GrößeNeu)
              and
                LeseKarten.BestimmteStadtBelegtGrund (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                      KoordinatenExtern      => KartenWert)
              = True
            then
               SchreibeKarten.BelegterGrund (PositionExtern      => KartenWert,
                                             BelegterGrundExtern => GlobaleKonstanten.LeerDurchStadtBelegterGrund);
               
               case
                 LeseStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                          YPositionExtern        => YÄnderungSchleifenwert,
                                                          XPositionExtern        => XÄnderungSchleifenwert)
               is
                  when True =>
                     SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                            EinwohnerArbeiterExtern => False,
                                                            ÄnderungExtern          => -1);
                     SchreibeStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                  YPositionExtern        => YÄnderungSchleifenwert,
                                                                  XPositionExtern        => XÄnderungSchleifenwert,
                                                                  BelegenEntfernenExtern => False);
                     
                  when False =>
                     null;
               end case;

            elsif
            abs (YÄnderungSchleifenwert) > GrößeNeu
              or
            abs (XÄnderungSchleifenwert) > GrößeNeu
            then
               null;
                     
            elsif
              LeseKarten.BelegterGrundLeer (KoordinatenExtern => KartenWert) = True
            then
               SchreibeKarten.BelegterGrund (PositionExtern      => KartenWert,
                                             BelegterGrundExtern => 
                                               (GlobaleDatentypen.Rassen_Verwendet_Enum'Pos (StadtRasseNummerExtern.Rasse) * GlobaleKonstanten.RassenMulitplikationWert
                                                + GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Platznummer))
                                            );
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      if
        GrößeNeu > GrößeAlt
      then
         ArbeiterSchleife:
         for ArbeiterSchleifenwert in 1 .. LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                              EinwohnerArbeiterExtern => True) - LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                                                                    EinwohnerArbeiterExtern => False) loop
            
            BewirtschaftbareFelderBelegen (ZuwachsOderSchwundExtern => True,
                                           StadtRasseNummerExtern   => StadtRasseNummerExtern);
            
         end loop ArbeiterSchleife;
         
      elsif
        GrößeNeu < GrößeAlt
      then
         GebäudeEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);
         
      else
         null;
      end if;
      
   end StadtUmgebungGrößeFestlegen;
   


   procedure BewirtschaftbareFelderBelegen
     (ZuwachsOderSchwundExtern : in Boolean;
      StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      case
        ZuwachsOderSchwundExtern
      is
         when False =>
            SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                   EinwohnerArbeiterExtern => True,
                                                   ÄnderungExtern         => -1);
            
            if
              LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                 EinwohnerArbeiterExtern => True)
              >= LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                    EinwohnerArbeiterExtern => False)
            then
               return;
               
            else
               null;
            end if;
            
         when True =>
            null;
      end case;
      
      NutzbarerBereich := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);
      Umgebung := (others => (others => (False, GlobaleDatentypen.GesamtproduktionStadt'First)));

      YAchseSchleife:
      for YPositionSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XPositionSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => LeseStadtGebaut.Position (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                                                        ÄnderungExtern    => (0, YPositionSchleifenwert, XPositionSchleifenwert));
            
            if
              KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
               
            elsif
              YPositionSchleifenwert = 0
              and
                XPositionSchleifenwert = 0
            then
               null;
               
            elsif
              LeseKarten.BestimmteStadtBelegtGrund (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                    KoordinatenExtern      => KartenWert)
              = False
            then
               null;
              
            elsif
              LeseStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                       YPositionExtern        => YPositionSchleifenwert,
                                                       XPositionExtern        => XPositionSchleifenwert)
              = ZuwachsOderSchwundExtern
            then
               Umgebung (YPositionSchleifenwert, XPositionSchleifenwert).Belegt := ZuwachsOderSchwundExtern;
               
            else
               Umgebung (YPositionSchleifenwert, XPositionSchleifenwert)
                 := (not ZuwachsOderSchwundExtern, FeldBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                 PositionExtern         => KartenWert,
                                                                 BelegenOderEntfernen   => ZuwachsOderSchwundExtern));
               
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      WelchesFeld := (0, 0, 0);
      
      case
        ZuwachsOderSchwundExtern
      is
         when True =>
            ArbeiterBelegen (StadtRasseNummerExtern => StadtRasseNummerExtern);
                  
         when False =>
            ArbeiterEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      end case;
      
   end BewirtschaftbareFelderBelegen;
   
   
   
   function FeldBewerten
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      BelegenOderEntfernen : in Boolean)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      Bewertung := 0;
      NahrungGesamt := GesamtwerteFeld.FeldNahrung (KoordinatenExtern => PositionExtern,
                                                    RasseExtern       => StadtRasseNummerExtern.Rasse);
      RessourcenGesamt := GesamtwerteFeld.FeldProduktion (KoordinatenExtern => PositionExtern,
                                                          RasseExtern       => StadtRasseNummerExtern.Rasse);
      GeldGesamt := GesamtwerteFeld.FeldGeld (KoordinatenExtern => PositionExtern,
                                              RasseExtern       => StadtRasseNummerExtern.Rasse);
      WissenGesamt := GesamtwerteFeld.FeldWissen (KoordinatenExtern => PositionExtern,
                                                  RasseExtern       => StadtRasseNummerExtern.Rasse);
      
      if
        LeseStadtGebaut.Nahrungsproduktion (StadtRasseNummerExtern => StadtRasseNummerExtern) <= 1
        and
          NahrungGesamt >= 1
      then
         case
           BelegenOderEntfernen
         is
            when True =>
               Bewertung := Bewertung + 100 + (NahrungGesamt * 20);
               
            when False =>
               Bewertung := Bewertung - 100 - (NahrungGesamt * 20);
         end case;
         
      else
         case
           BelegenOderEntfernen
         is
            when True =>
               Bewertung := Bewertung + NahrungGesamt;
               
            when False =>
               Bewertung := Bewertung - NahrungGesamt;
         end case;
      end if;
      
      if
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern) <= 0
        and
          RessourcenGesamt >= 1
      then
         case
           BelegenOderEntfernen
         is
            when True =>
               Bewertung := Bewertung + 25 + RessourcenGesamt;
               
            when False =>
               Bewertung := Bewertung - 25 - RessourcenGesamt;
         end case;
         
      else
         case
           BelegenOderEntfernen
         is
            when True =>
               Bewertung := Bewertung + RessourcenGesamt;
               
            when False =>
               Bewertung := Bewertung - RessourcenGesamt;
         end case;
      end if;
      
      if
        LeseStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern) <= 0
        and
          GeldGesamt >= 1
      then
         case
           BelegenOderEntfernen
         is
            when True =>
               Bewertung := Bewertung + 25 + GeldGesamt;
               
            when False =>
               Bewertung := Bewertung - 25 - GeldGesamt;
         end case;
         
      else
         case
           BelegenOderEntfernen
         is
            when True =>
               Bewertung := Bewertung + GeldGesamt;
               
            when False =>
               Bewertung := Bewertung - GeldGesamt;
         end case;
      end if;
      
      if
        LeseStadtGebaut.Forschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern) <= 0
        and
          WissenGesamt >= 1
      then
         case
           BelegenOderEntfernen
         is
            when True =>
               Bewertung := Bewertung + 25 + WissenGesamt;
               
            when False =>
               Bewertung := Bewertung - 25 - WissenGesamt;
         end case;
         
      else
         case
           BelegenOderEntfernen
         is
            when True =>
               Bewertung := Bewertung + WissenGesamt;
               
            when False =>
               Bewertung := Bewertung - WissenGesamt;
         end case;
      end if;
      
      return Bewertung;
      
   end FeldBewerten;
   
   
   
   procedure ArbeiterBelegen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      YAchseSchleife:
      for YPositionSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XPositionSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
            
            if
              Umgebung (YPositionSchleifenwert, XPositionSchleifenwert).Belegt = True
              or
                Umgebung (YPositionSchleifenwert, XPositionSchleifenwert).Gesamtbewertung = GlobaleDatentypen.GesamtproduktionStadt'First
            then
               null;
               
            elsif
              Umgebung (YPositionSchleifenwert, XPositionSchleifenwert).Gesamtbewertung > WelchesFeld.HöchsterWert
            then
               WelchesFeld := (Umgebung (YPositionSchleifenwert, XPositionSchleifenwert).Gesamtbewertung, YPositionSchleifenwert, XPositionSchleifenwert);
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
                  
      case
        WelchesFeld.HöchsterWert
      is
         when 0 =>
            null;
            
         when others =>
            SchreibeStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                         YPositionExtern        => WelchesFeld.YKoordinate,
                                                         XPositionExtern        => WelchesFeld.XKoordinate,
                                                         BelegenEntfernenExtern => True);
            SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                   EinwohnerArbeiterExtern => False,
                                                   ÄnderungExtern         => 1);
      end case;
      
   end ArbeiterBelegen;
   
   
   
   procedure ArbeiterEntfernen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      YAchseSchleife:
      for YPositionSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XPositionSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
            
            if
              Umgebung (YPositionSchleifenwert, XPositionSchleifenwert).Belegt = False
              or
                Umgebung (YPositionSchleifenwert, XPositionSchleifenwert).Gesamtbewertung = GlobaleDatentypen.GesamtproduktionStadt'First
            then
               null;
               
            elsif
              Umgebung (YPositionSchleifenwert, XPositionSchleifenwert).Gesamtbewertung > WelchesFeld.HöchsterWert
            then
               WelchesFeld := (Umgebung (YPositionSchleifenwert, XPositionSchleifenwert).Gesamtbewertung, YPositionSchleifenwert, XPositionSchleifenwert);
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
                  
      case
        WelchesFeld.HöchsterWert
      is
         when 0 =>
            null;
            
         when others =>
            SchreibeStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                         YPositionExtern        => WelchesFeld.YKoordinate,
                                                         XPositionExtern        => WelchesFeld.XKoordinate,
                                                         BelegenEntfernenExtern => False);
            SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                   EinwohnerArbeiterExtern => False,
                                                   ÄnderungExtern         => -1);
      end case;
      
   end ArbeiterEntfernen;
   
   
   
   procedure GebäudeEntfernen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in GlobaleDatentypen.GebäudeID'Range loop
         
         if
           LeseStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                              WelchesGebäudeExtern  => GebäudeSchleifenwert)
           = False
         then
            null;
            
         elsif
           GebaeudeRichtigeUmgebung.RichtigeUmgebungVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                               GebäudeIDExtern       => GebäudeSchleifenwert)
           = True
         then
            null;
            
         else
            SchreibeStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern     => StadtRasseNummerExtern,
                                                   WelchesGebäudeExtern      => GebäudeSchleifenwert,
                                                   HinzufügenEntfernenExtern => False);
         end if;
         
      end loop GebäudeSchleife;
      
   end GebäudeEntfernen;
   
end StadtWerteFestlegen;
