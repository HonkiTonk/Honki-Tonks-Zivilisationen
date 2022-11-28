with KartenKonstanten;
with StadtDatentypen;
with KartenRecordKonstanten;

with SchreibeWeltkarte;
with SchreibeStadtGebaut;
with LeseWeltkarte;

with KartenkoordinatenberechnungssystemLogik;
with KartenfelderwerteLogik;
with StadtumgebungsbereichFestlegenLogik;
with GebaeudeumgebungLogik;

package body StadtwerteFestlegenLogik is
   
   procedure StadtUmgebungGrößeFestlegenTechnologie
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
   is begin
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (RasseExtern => RasseExtern) loop
         
         case
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               null;
               
            when others =>
               StadtUmgebungGrößeFestlegen (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert));
         end case;
         
      end loop StadtSchleife;
      
   end StadtUmgebungGrößeFestlegenTechnologie;
   
   

   procedure StadtUmgebungGrößeFestlegen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
            
      GrößeAlt := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);
      StadtumgebungsbereichFestlegenLogik.StadtumgebungsbereichFestlegen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      GrößeNeu := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern);

      -- StadtUmgebungGröße darf hier nicht genutzt werden, damit bei einer Verkleinerung auch alle Felder zurückgenommen werden können.
      YAchseSchleife:
      for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
         XAchseSchleife:
         for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichDrei'Range loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Stadtkoordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              (abs (YAchseSchleifenwert) > GrößeNeu
               or
               abs (XAchseSchleifenwert) > GrößeNeu)
              and
                True = LeseWeltkarte.BestimmteStadtBelegtGrund (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                KoordinatenExtern      => KartenWert)
            then
               SchreibeWeltkarte.BelegterGrund (KoordinatenExtern   => KartenWert,
                                                BelegterGrundExtern => KartenRecordKonstanten.LeerDurchStadtBelegterGrund);
               
               case
                 LeseStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                          YKoordinateExtern      => YAchseSchleifenwert,
                                                          XKoordinateExtern      => XAchseSchleifenwert)
               is
                  when True =>
                     SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                            EinwohnerArbeiterExtern => False,
                                                            WachsenSchrumpfenExtern => False);
                     SchreibeStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                  YKoordinateExtern      => YAchseSchleifenwert,
                                                                  XKoordinateExtern      => XAchseSchleifenwert,
                                                                  BelegenEntfernenExtern => False);
                     
                  when False =>
                     null;
               end case;

            elsif
            abs (YAchseSchleifenwert) > GrößeNeu
              or
            abs (XAchseSchleifenwert) > GrößeNeu
            then
               null;
                     
            elsif
              LeseWeltkarte.UnbelegterGrund (KoordinatenExtern => KartenWert) = True
            then
               SchreibeWeltkarte.BelegterGrund (KoordinatenExtern   => KartenWert,
                                                BelegterGrundExtern => (StadtRasseNummerExtern.Rasse, StadtRasseNummerExtern.Nummer));
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      case
        GrößeNeu
      is
         when 0 =>
            null;
            
         when others =>
            NeueUmgebungsgrößePrüfen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                         GrößeNeuExtern         => GrößeNeu,
                                         GrößeAltExtern         => GrößeAlt);
      end case;
      
   end StadtUmgebungGrößeFestlegen;
   
   
   
   procedure NeueUmgebungsgrößePrüfen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      GrößeNeuExtern : in KartenDatentypen.UmgebungsbereichDrei;
      GrößeAltExtern : in KartenDatentypen.UmgebungsbereichDrei)
   is begin
      
      if
        GrößeNeuExtern > GrößeAltExtern
      then
         ArbeiterSchleife:
         for ArbeiterSchleifenwert in 1 .. LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                              EinwohnerArbeiterExtern => True) - LeseStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                                                                                                                    EinwohnerArbeiterExtern => False) loop
            
            BewirtschaftbareFelderBelegen (ZuwachsOderSchwundExtern => True,
                                           StadtRasseNummerExtern   => StadtRasseNummerExtern);
            
         end loop ArbeiterSchleife;
         
      elsif
        GrößeNeuExtern < GrößeAltExtern
      then
         GebäudeEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);
         
      else
         null;
      end if;
      
   end NeueUmgebungsgrößePrüfen;
   


   procedure BewirtschaftbareFelderBelegen
     (ZuwachsOderSchwundExtern : in Boolean;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      case
        ZuwachsOderSchwundExtern
      is
         when False =>
            SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                   EinwohnerArbeiterExtern => True,
                                                   WachsenSchrumpfenExtern => False);
            
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
      
      UmgebungFestlegen (ZuwachsOderSchwundExtern => ZuwachsOderSchwundExtern,
                         StadtRasseNummerExtern   => StadtRasseNummerExtern);
      -- Diese Verwendung hier überall auch mal anpassen. äöü
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
   
   
   
   procedure UmgebungFestlegen
     (ZuwachsOderSchwundExtern : in Boolean;
      StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      NutzbarerBereich := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);
      Umgebung := (others => (others => (False, ProduktionDatentypen.Stadtproduktion'First)));
      
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern);

      YAchseSchleife:
      for YAchseSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XAchseSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Stadtkoordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                      LogikGrafikExtern => True);
            
            if
              KartenWert.XAchse = KartenKonstanten.LeerXAchse
            then
               null;
               
            elsif
              YAchseSchleifenwert = 0
              and
                XAchseSchleifenwert = 0
            then
               null;
               
            elsif
              False = LeseWeltkarte.BestimmteStadtBelegtGrund (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                               KoordinatenExtern      => KartenWert)
            then
               null;
              
            elsif
              ZuwachsOderSchwundExtern = LeseStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                                  YKoordinateExtern      => YAchseSchleifenwert,
                                                                                  XKoordinateExtern      => XAchseSchleifenwert)
            then
               Umgebung (YAchseSchleifenwert, XAchseSchleifenwert).Belegt := ZuwachsOderSchwundExtern;
               
            else
               Umgebung (YAchseSchleifenwert, XAchseSchleifenwert) := (not ZuwachsOderSchwundExtern, FeldBewerten (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                                                                   KoordinatenExtern      => KartenWert,
                                                                                                                   BelegenOderEntfernen   => ZuwachsOderSchwundExtern));
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end UmgebungFestlegen;
   
   
   
   function FeldBewerten
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      BelegenOderEntfernen : in Boolean)
      return ProduktionDatentypen.Stadtproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      return NahrungBewertung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                               KoordinatenExtern      => KoordinatenExtern,
                               BelegenOderEntfernen   => BelegenOderEntfernen)
        + ProduktionBewertung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                               KoordinatenExtern      => KoordinatenExtern,
                               BelegenOderEntfernen   => BelegenOderEntfernen)
        + GeldBewertung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                         KoordinatenExtern      => KoordinatenExtern,
                         BelegenOderEntfernen   => BelegenOderEntfernen)
        + WissenBewertung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                           KoordinatenExtern      => KoordinatenExtern,
                           BelegenOderEntfernen   => BelegenOderEntfernen);
      
   end FeldBewerten;
   
   
   
   function NahrungBewertung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      BelegenOderEntfernen : in Boolean)
      return ProduktionDatentypen.Stadtproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      NahrungGesamt := KartenfelderwerteLogik.FeldNahrung (KoordinatenExtern => KoordinatenExtern,
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
               return 100 + (NahrungGesamt * 20);
               
            when False =>
               return -100 - (NahrungGesamt * 20);
         end case;
         
      else
         case
           BelegenOderEntfernen
         is
            when True =>
               return NahrungGesamt;
               
            when False =>
               return -NahrungGesamt;
         end case;
      end if;
      
   end NahrungBewertung;
   
   
   
   function ProduktionBewertung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      BelegenOderEntfernen : in Boolean)
      return ProduktionDatentypen.Stadtproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      RessourcenGesamt := KartenfelderwerteLogik.FeldProduktion (KoordinatenExtern => KoordinatenExtern,
                                                                 RasseExtern       => StadtRasseNummerExtern.Rasse);
      
      if
        LeseStadtGebaut.Produktionrate (StadtRasseNummerExtern => StadtRasseNummerExtern) <= 0
        and
          RessourcenGesamt >= 1
      then
         case
           BelegenOderEntfernen
         is
            when True =>
               return 25 + RessourcenGesamt;
               
            when False =>
               return -25 - RessourcenGesamt;
         end case;
         
      else
         case
           BelegenOderEntfernen
         is
            when True =>
               return RessourcenGesamt;
               
            when False =>
               return -RessourcenGesamt;
         end case;
      end if;
      
   end ProduktionBewertung;



   function GeldBewertung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      BelegenOderEntfernen : in Boolean)
      return ProduktionDatentypen.Stadtproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      GeldGesamt := KartenfelderwerteLogik.FeldGeld (KoordinatenExtern => KoordinatenExtern,
                                                     RasseExtern       => StadtRasseNummerExtern.Rasse);

      if
        LeseStadtGebaut.Geldgewinnung (StadtRasseNummerExtern => StadtRasseNummerExtern) <= 0
        and
          GeldGesamt >= 1
      then
         case
           BelegenOderEntfernen
         is
            when True =>
               return 25 + GeldGesamt;
               
            when False =>
               return -25 - GeldGesamt;
         end case;
         
      else
         case
           BelegenOderEntfernen
         is
            when True =>
               return GeldGesamt;
               
            when False =>
               return -GeldGesamt;
         end case;
      end if;

   end GeldBewertung;
   
   
   
   function WissenBewertung
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      BelegenOderEntfernen : in Boolean)
      return ProduktionDatentypen.Stadtproduktion
   is
      use type ProduktionDatentypen.Produktion;
   begin

      WissenGesamt := KartenfelderwerteLogik.FeldWissen (KoordinatenExtern => KoordinatenExtern,
                                                         RasseExtern       => StadtRasseNummerExtern.Rasse);
      
      if
        LeseStadtGebaut.Forschungsrate (StadtRasseNummerExtern => StadtRasseNummerExtern) = 0
        and
          WissenGesamt >= 1
      then
         case
           BelegenOderEntfernen
         is
            when True =>
               return 25 + WissenGesamt;
               
            when False =>
               return -25 - WissenGesamt;
         end case;
      
      else
         case
           BelegenOderEntfernen
         is
            when True =>
               return WissenGesamt;
               
            when False =>
               return -WissenGesamt;
         end case;
      end if;
      
   end WissenBewertung;
   
   
   
   procedure ArbeiterBelegen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XAchseSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
            
            if
              Umgebung (YAchseSchleifenwert, XAchseSchleifenwert).Belegt = True
            then
               null;
               
            elsif
              Umgebung (YAchseSchleifenwert, XAchseSchleifenwert).Gesamtbewertung > WelchesFeld.HöchsterWert
            then
               WelchesFeld := (Umgebung (YAchseSchleifenwert, XAchseSchleifenwert).Gesamtbewertung, YAchseSchleifenwert, XAchseSchleifenwert);
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
      ArbeiterBelegenEntfernen (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                BelegenEntfernenExtern  => True,
                                WachsenSchrumpfenExtern => True);
      
   end ArbeiterBelegen;
   
   
   
   procedure ArbeiterEntfernen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is
      use type ProduktionDatentypen.Produktion;
   begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
         XAchseSchleife:
         for XAchseSchleifenwert in -NutzbarerBereich .. NutzbarerBereich loop
            
            if
              Umgebung (YAchseSchleifenwert, XAchseSchleifenwert).Belegt = False
            then
               null;
               
            elsif
              Umgebung (YAchseSchleifenwert, XAchseSchleifenwert).Gesamtbewertung < WelchesFeld.HöchsterWert
            then
               WelchesFeld := (Umgebung (YAchseSchleifenwert, XAchseSchleifenwert).Gesamtbewertung, YAchseSchleifenwert, XAchseSchleifenwert);
               
            else
               null;
            end if;
            
         end loop XAchseSchleife;
      end loop YAchseSchleife;
                  
      ArbeiterBelegenEntfernen (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                BelegenEntfernenExtern  => False,
                                WachsenSchrumpfenExtern => False);
      
   end ArbeiterEntfernen;
   
   
   
   procedure ArbeiterBelegenEntfernen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      BelegenEntfernenExtern : in Boolean;
      WachsenSchrumpfenExtern : in Boolean)
   is begin
      
      case
        WelchesFeld.HöchsterWert
      is
         when 0 =>
            null;
            
         when others =>
            SchreibeStadtGebaut.UmgebungBewirtschaftung (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                         YKoordinateExtern      => WelchesFeld.YKoordinate,
                                                         XKoordinateExtern      => WelchesFeld.XKoordinate,
                                                         BelegenEntfernenExtern => BelegenEntfernenExtern);
            SchreibeStadtGebaut.EinwohnerArbeiter (StadtRasseNummerExtern  => StadtRasseNummerExtern,
                                                   EinwohnerArbeiterExtern => False,
                                                   WachsenSchrumpfenExtern => WachsenSchrumpfenExtern);
      end case;
      
   end ArbeiterBelegenEntfernen;
   
   
   
   procedure GebäudeEntfernen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      GebäudeSchleife:
      for GebäudeSchleifenwert in StadtDatentypen.GebäudeID'Range loop
         
         if
           False = LeseStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                      WelchesGebäudeExtern  => GebäudeSchleifenwert)
         then
            null;
            
         elsif
           True = GebaeudeumgebungLogik.RichtigeUmgebungVorhanden (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                                   GebäudeIDExtern        => GebäudeSchleifenwert)
         then
            null;
            
         else
            SchreibeStadtGebaut.GebäudeVorhanden (StadtRasseNummerExtern     => StadtRasseNummerExtern,
                                                   WelchesGebäudeExtern      => GebäudeSchleifenwert,
                                                   HinzufügenEntfernenExtern => False);
         end if;
         
      end loop GebäudeSchleife;
      
   end GebäudeEntfernen;
   
end StadtwerteFestlegenLogik;
