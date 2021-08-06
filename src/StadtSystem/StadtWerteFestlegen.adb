pragma SPARK_Mode (On);

with GlobaleKonstanten;

with Karten, KartePositionPruefen, ProduktionFeld;

package body StadtWerteFestlegen is

   procedure StadtUmgebungGrößeFestlegen
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord)
   is begin    
            
      GrößeAlt := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße;
        
      if
        GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Erforscht (4) = True
        and
          GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) >= EinwohnerZweitesWachstum
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße := 3;
         
      elsif
        GlobaleVariablen.Wichtiges (StadtRasseNummerExtern.Rasse).Erforscht (2) = True
        and
          GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) >= EinwohnerErstesWachstum
      then
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße := 2;         
                  
      else
         GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße := 1;
      end if;
            
      GrößeNeu := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße;

      -- StadtUmgebungGröße darf hier nicht genutzt werden, damit bei einer Verkleinerung auch alle Felder zurückgenommen werden können.
      YAchseSchleife:
      for YÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
         XAchseSchleife:
         for XÄnderungSchleifenwert in GlobaleDatentypen.LoopRangeMinusDreiZuDrei'Range loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position,
                                                                        ÄnderungExtern    => (0, YÄnderungSchleifenwert, XÄnderungSchleifenwert));
            
            if
              KartenWert.XAchse = GlobaleKonstanten.LeerYXKartenWert
            then
               null;
               
            elsif
              (abs (YÄnderungSchleifenwert) > GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße
               or
               abs (XÄnderungSchleifenwert) > GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße)
              and
                Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund 
              = GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.Rassen_Verwendet_Enum'Pos (StadtRasseNummerExtern.Rasse)) * GlobaleKonstanten.RassenMulitplikationWert
              + GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Platznummer)
            then
               Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund := 0;
               
               case
                 GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (YÄnderungSchleifenwert, XÄnderungSchleifenwert)
               is
                  when True =>
                     GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2)
                       := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2) - 1;
                     GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (YÄnderungSchleifenwert, XÄnderungSchleifenwert) := False;
                     
                  when False =>
                     null;
               end case;

            elsif
            abs (YÄnderungSchleifenwert) > GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße
              or
            abs (XÄnderungSchleifenwert) > GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße
            then
               null;
                     
            elsif
              Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund = 0
            then
               Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
                 := GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.Rassen_Verwendet_Enum'Pos (StadtRasseNummerExtern.Rasse)) * GlobaleKonstanten.RassenMulitplikationWert
                   + GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Platznummer);
                     
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      if
        GrößeNeu > GrößeAlt
      then
         ArbeiterSchleife:
         for ArbeiterSchleifenwert in 1 .. GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1)
           - GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2) loop
            
            BewirtschaftbareFelderBelegen (ZuwachsOderSchwundExtern => True,
                                           StadtRasseNummerExtern   => StadtRasseNummerExtern);
            
         end loop ArbeiterSchleife;
         
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
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1)
              := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1) - 1;
            
            if
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (1)
              >= GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2)
            then
               return;
               
            else
               null;
            end if;
            
         when True =>
            null;
      end case;
      
      NutzbarerBereich := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungGröße;
      Umgebung := (others => (others => (False, GlobaleDatentypen.GesamtproduktionStadt'First)));

      YAchseSchleife:
      for YPositionSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XPositionSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
            
            KartenWert := KartePositionPruefen.KartenPositionBestimmen (KoordinatenExtern => GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Position,
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
              Karten.Weltkarte (KartenWert.EAchse, KartenWert.YAchse, KartenWert.XAchse).DurchStadtBelegterGrund
              /= GlobaleDatentypen.BelegterGrund (GlobaleDatentypen.Rassen_Verwendet_Enum'Pos (StadtRasseNummerExtern.Rasse)) * GlobaleKonstanten.RassenMulitplikationWert
                + GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Platznummer)
            then
               null;
              
            elsif
              GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (YPositionSchleifenwert, XPositionSchleifenwert) = ZuwachsOderSchwundExtern
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
      NahrungGesamt := ProduktionFeld.FeldNahrung (KoordinatenExtern => PositionExtern,
                                                   RasseExtern       => StadtRasseNummerExtern.Rasse);
      RessourcenGesamt := ProduktionFeld.FeldProduktion (KoordinatenExtern => PositionExtern,
                                                         RasseExtern       => StadtRasseNummerExtern.Rasse);
      GeldGesamt := ProduktionFeld.FeldGeld (KoordinatenExtern => PositionExtern,
                                             RasseExtern       => StadtRasseNummerExtern.Rasse);
      WissenGesamt := ProduktionFeld.FeldWissen (KoordinatenExtern => PositionExtern,
                                                 RasseExtern       => StadtRasseNummerExtern.Rasse);
      
      if
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Nahrungsproduktion <= 1
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
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Produktionrate <= 0
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
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Geldgewinnung <= 0
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
        GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).Forschungsrate <= 0
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
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (WelchesFeld.YKoordinate, WelchesFeld.XKoordinate) := True;
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2)
              := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2) + 1;
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
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).UmgebungBewirtschaftung (WelchesFeld.YKoordinate, WelchesFeld.XKoordinate) := False;
            GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2)
              := GlobaleVariablen.StadtGebaut (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Platznummer).EinwohnerArbeiter (2) - 1;
      end case;
      
   end ArbeiterEntfernen;
   
end StadtWerteFestlegen;
