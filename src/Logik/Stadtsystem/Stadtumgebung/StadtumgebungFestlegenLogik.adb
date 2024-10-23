with KartenKonstanten;
with KartenRecordKonstanten;
with SystemDatentypen;

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
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
   is begin
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern) loop
         
         case
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert))
         is
            when StadtKonstanten.LeerID =>
               exit StadtSchleife;
               
            when others =>
               StadtumgebungFestlegen (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert));
         end case;
         
      end loop StadtSchleife;
      
   end StadtumgebungFestlegenTechnologie;
   
   

   procedure StadtumgebungFestlegen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      GrößeAlt := LeseStadtGebaut.Gesamtumgebung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      StadtumgebungsbereichBerechnenLogik.StadtumgebungsbereichFestlegen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      GrößeNeu := LeseStadtGebaut.Gesamtumgebung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);

      -- StadtUmgebungGröße darf hier nicht genutzt werden, damit bei einer Verkleinerung auch alle Felder zurückgenommen werden können.
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in KartenDatentypen.SenkrechteUmgebungDrei'Range loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in KartenDatentypen.WaagerechteUmgebungDrei'Range loop
            
            KartenWert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => Stadtkoordinaten,
                                                                                                      ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                      TaskExtern        => SystemDatentypen.Logik_Task_Enum);
            
            if
              KartenWert.Waagerechte = KartenKonstanten.LeerWaagerechte
            then
               null;
               
            elsif
              True = LeseWeltkarte.BestimmteStadtBelegtGrund (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                              KoordinatenExtern        => KartenWert)
              and
                ((abs (SenkrechteSchleifenwert) > GrößeNeu.Senkrechte
                  or
                  abs (WaagerechteSchleifenwert) > GrößeNeu.Waagerechte)
                 or
                   (GrößeNeu.Senkrechte = 0
                    and
                      GrößeNeu.Waagerechte = 0
                    and
                      (SenkrechteSchleifenwert = 0
                       or
                         WaagerechteSchleifenwert = 0)))
            then
               SchreibeWeltkarte.BelegterGrund (KoordinatenExtern   => KartenWert,
                                                BelegterGrundExtern => KartenRecordKonstanten.LeerDurchStadtBelegterGrund);
               
               case
                 LeseStadtGebaut.UmgebungBewirtschaftung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                          YKoordinateExtern        => SenkrechteSchleifenwert,
                                                          XKoordinateExtern        => WaagerechteSchleifenwert)
               is
                  when True =>
                     SchreibeStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                            EinwohnerArbeiterExtern  => False,
                                                            WachsenSchrumpfenExtern  => False);
                     SchreibeStadtGebaut.UmgebungBewirtschaftung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                  YKoordinateExtern        => SenkrechteSchleifenwert,
                                                                  XKoordinateExtern        => WaagerechteSchleifenwert,
                                                                  BelegenEntfernenExtern   => False);
                     
                  when False =>
                     null;
               end case;

            elsif
            abs (SenkrechteSchleifenwert) > GrößeNeu.Senkrechte
              or
            abs (WaagerechteSchleifenwert) > GrößeNeu.Waagerechte
            then
               null;
                     
            elsif
              LeseWeltkarte.UnbelegterGrund (KoordinatenExtern => KartenWert) = True
            then
               GrundBelegen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                             KoordinatenExtern        => KartenWert);
               
            else
               null;
            end if;
            
         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
      if
        GrößeNeu.Senkrechte > GrößeAlt.Senkrechte
        and
          GrößeNeu.Waagerechte > GrößeAlt.Waagerechte
      then
         ArbeiterSchleife:
         for ArbeiterSchleifenwert in 1 .. LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                              EinwohnerArbeiterExtern  => True) - LeseStadtGebaut.EinwohnerArbeiter (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern,
                                                                                                                                                     EinwohnerArbeiterExtern  => False) loop
            
            FelderbewirtschaftungLogik.BewirtschaftbareFelderBelegen (ZuwachsSchwundExtern     => True,
                                                                      StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            
         end loop ArbeiterSchleife;
      
      elsif
        GrößeNeu.Senkrechte < GrößeAlt.Senkrechte
        and
          GrößeNeu.Waagerechte < GrößeAlt.Waagerechte
      then
         GebaeudeAllgemeinLogik.UmgebungsreduktionGebäudeEntfernen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
         UmgebendeStädteAnpassen (KoordinatenExtern => Stadtkoordinaten,
                                   GrößeAltExtern    => GrößeAlt);
         
      else
         null;
      end if;
      
   end StadtumgebungFestlegen;
   
   
   
   procedure GrundBelegen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord;
      KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
   is
      use type SpeziesDatentypen.Spezies_Enum;
      use type StadtDatentypen.Städtebereich;
   begin
      
      GrundBelegbar := False;
            
      EbeneSchleife:
      for EbeneSchleifenwert in KartenDatentypen.EbenenbereichEins'Range loop
         SenkrechteSchleife:
         for SenkrechteSchleifenwert in KartenDatentypen.SenkrechteUmgebungEins'Range loop
            WaagerechteSchleife:
            for WaagerechteSchleifenwert in KartenDatentypen.WaagerechteUmgebungEins'Range loop
               
               BelegungKartenwert := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                                 ÄnderungExtern    => (EbeneSchleifenwert, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                                 TaskExtern        => SystemDatentypen.Logik_Task_Enum);
               
               if
                 BelegungKartenwert.Waagerechte = KartenKonstanten.LeerWaagerechte
               then
                  null;
                  
               elsif
                 StadtSpeziesNummerExtern.Spezies = LeseWeltkarte.SpeziesBelegtGrund (KoordinatenExtern => BelegungKartenwert)
                 or
                   StadtKonstanten.LeerNummer /= StadtSuchenLogik.KoordinatenStadtMitSpeziesSuchen (SpeziesExtern     => StadtSpeziesNummerExtern.Spezies,
                                                                                                    KoordinatenExtern => BelegungKartenwert)
               then
                  GrundBelegbar := True;
                  exit EbeneSchleife;
                  
               else
                  null;
               end if;
               
            end loop WaagerechteSchleife;
         end loop SenkrechteSchleife;
      end loop EbeneSchleife;
      
      case
        GrundBelegbar
      is
         when True =>
            SchreibeWeltkarte.BelegterGrund (KoordinatenExtern   => KoordinatenExtern,
                                             BelegterGrundExtern => StadtSpeziesNummerExtern);
            
         when False =>
            null;
      end case;
               
   end GrundBelegen;
   
   
   
   procedure UmgebendeStädteAnpassen
     (KoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord;
      GrößeAltExtern : in KartenRecords.UmgebungDreiRecord)
   is
      use type StadtDatentypen.Städtebereich;
   begin
      
      SenkrechteSchleife:
      for SenkrechteSchleifenwert in -GrößeAltExtern.Senkrechte - 1 .. GrößeAltExtern.Senkrechte + 1 loop
         WaagerechteSchleife:
         for WaagerechteSchleifenwert in -GrößeAltExtern.Waagerechte - 1 .. GrößeAltExtern.Waagerechte + 1 loop

            if
            abs (SenkrechteSchleifenwert) < GrößeAltExtern.Senkrechte + 1
              and
            abs (WaagerechteSchleifenwert) < GrößeAltExtern.Waagerechte + 1
            then
               null;

            else
               UmgebendesKartenwert
                 := KartenkoordinatenberechnungssystemLogik.Kartenkoordinatenberechnungssystem (KoordinatenExtern => KoordinatenExtern,
                                                                                                ÄnderungExtern    => (KartenKonstanten.LeerEbeneÄnderung, SenkrechteSchleifenwert, WaagerechteSchleifenwert),
                                                                                                TaskExtern        => SystemDatentypen.Logik_Task_Enum);

               case
                 UmgebendesKartenwert.Waagerechte
               is
                  when KartenKonstanten.LeerWaagerechte =>
                     null;

                  when others =>
                     if
                       LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => UmgebendesKartenwert).Nummer = StadtKonstanten.LeerNummer
                     then
                        null;

                     else
                        StadtumgebungFestlegen (StadtSpeziesNummerExtern => LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => UmgebendesKartenwert));
                     end if;
               end case;
            end if;

         end loop WaagerechteSchleife;
      end loop SenkrechteSchleife;
      
   end UmgebendeStädteAnpassen;
   
end StadtumgebungFestlegenLogik;
