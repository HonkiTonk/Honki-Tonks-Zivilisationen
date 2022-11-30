with KartenKonstanten;
with StadtDatentypen;
with KartenRecordKonstanten;

with SchreibeWeltkarte;
with SchreibeStadtGebaut;
with LeseWeltkarte;
with LeseStadtGebaut;

with KartenkoordinatenberechnungssystemLogik;
with StadtumgebungsbereichBerechnenLogik;
with GebaeudeAllgemeinLogik;
with FelderbewirtschaftungLogik;
with StadtSuchenLogik;

package body StadtumgebungFestlegenLogik is
   
   procedure StadtumgebungFestlegenTechnologie
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
               StadtumgebungFestlegen (StadtRasseNummerExtern => (RasseExtern, StadtSchleifenwert));
         end case;
         
      end loop StadtSchleife;
      
   end StadtumgebungFestlegenTechnologie;
   
   

   procedure StadtumgebungFestlegen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      GrößeAlt := LeseStadtGebaut.UmgebungGröße (StadtRasseNummerExtern => StadtRasseNummerExtern);
      StadtumgebungsbereichBerechnenLogik.StadtumgebungsbereichFestlegen (StadtRasseNummerExtern => StadtRasseNummerExtern);
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
              True = LeseWeltkarte.BestimmteStadtBelegtGrund (StadtRasseNummerExtern => StadtRasseNummerExtern,
                                                              KoordinatenExtern      => KartenWert)
              and
                ((abs (YAchseSchleifenwert) > GrößeNeu
                  or
                  abs (XAchseSchleifenwert) > GrößeNeu)
                 or
                   (GrößeNeu = 0
                    and
                      (YAchseSchleifenwert = 0
                       or
                         XAchseSchleifenwert = 0)))
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
               GrundBelegen (StadtRasseNummerExtern => StadtRasseNummerExtern,
                             KoordinatenExtern      => KartenWert);
               
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
            
            FelderbewirtschaftungLogik.BewirtschaftbareFelderBelegen (ZuwachsSchwundExtern   => True,
                                                                      StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         end loop ArbeiterSchleife;
      
      elsif
        GrößeNeu < GrößeAlt
      then
         GebaeudeAllgemeinLogik.UmgebungsreduktionGebäudeEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);
         UmgebendeStädteAnpassen (KoordinatenExtern => Stadtkoordinaten,
                                   GrößeAltExtern    => GrößeAlt);
         
      else
         null;
      end if;
      
   end StadtumgebungFestlegen;
   
   
   
   procedure GrundBelegen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
   is
      use type RassenDatentypen.Rassen_Enum;
      use type StadtDatentypen.MaximaleStädteMitNullWert;
   begin
      
      GrundBelegbar := False;
            
      EAchseSchleife:
      for EAchseSchleifenwert in KartenDatentypen.EbenenbereichEins'Range loop
         YAchseSchleife:
         for YAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
            XAchseSchleife:
            for XAchseSchleifenwert in KartenDatentypen.UmgebungsbereichEins'Range loop
               
               BelegungKartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                                 ÄnderungExtern    => (EAchseSchleifenwert, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                                 LogikGrafikExtern => True);
               
               if
                 BelegungKartenwert.XAchse = KartenKonstanten.LeerXAchse
               then
                  null;
                  
               elsif
                 StadtRasseNummerExtern.Rasse = LeseWeltkarte.RasseBelegtGrund (KoordinatenExtern => BelegungKartenwert)
                 or
                   StadtKonstanten.LeerNummer /= StadtSuchenLogik.KoordinatenStadtMitRasseSuchen (RasseExtern       => StadtRasseNummerExtern.Rasse,
                                                                                                  KoordinatenExtern => BelegungKartenwert)
               then
                  GrundBelegbar := True;
                  exit EAchseSchleife;
                  
               else
                  null;
               end if;
               
            end loop XAchseSchleife;
         end loop YAchseSchleife;
      end loop EAchseSchleife;
      
      case
        GrundBelegbar
      is
         when True =>
            SchreibeWeltkarte.BelegterGrund (KoordinatenExtern   => KoordinatenExtern,
                                             BelegterGrundExtern => StadtRasseNummerExtern);
            
         when False =>
            null;
      end case;
               
   end GrundBelegen;
   
   
   
   procedure UmgebendeStädteAnpassen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord;
      GrößeAltExtern : in KartenDatentypen.UmgebungsbereichDrei)
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
   begin
      
      YAchseSchleife:
      for YAchseSchleifenwert in -GrößeAltExtern -1 .. GrößeAltExtern + 1 loop
         XAchseSchleife:
         for XAchseSchleifenwert in -GrößeAltExtern -1 .. GrößeAltExtern + 1 loop

            if
            abs (YAchseSchleifenwert) < GrößeAltExtern + 1
              and
            abs (XAchseSchleifenwert) < GrößeAltExtern + 1
            then
               null;

            else
               UmgebendesKartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                                   ÄnderungExtern    => (KartenKonstanten.LeerEAchseÄnderung, YAchseSchleifenwert, XAchseSchleifenwert),
                                                                                                                   LogikGrafikExtern => True);

               case
                 UmgebendesKartenwert.XAchse
               is
                  when KartenKonstanten.LeerXAchse =>
                     null;

                  when others =>
                     if
                       LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => UmgebendesKartenwert).Nummer = StadtKonstanten.LeerNummer
                     then
                        null;

                     else
                        StadtumgebungFestlegen (StadtRasseNummerExtern => LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => UmgebendesKartenwert));
                     end if;
               end case;
            end if;

         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end UmgebendeStädteAnpassen;
   
end StadtumgebungFestlegenLogik;
