with KartenDatentypen;
with KartenverbesserungDatentypen;
with StadtDatentypen;
with KartenKonstanten;
with EinheitenKonstanten;
with KartenRecordKonstanten;
with TextnummernKonstanten;

with SchreibeEinheitenGebaut;
with SchreibeStadtGebaut;
with SchreibeWeltkarte;
with SchreibeWichtiges;
with LeseWeltkarte;
with LeseEinheitenGebaut;
with LeseStadtGebaut;

with KartenkoordinatenberechnungssystemLogik;
with RasseEntfernenLogik;
with JaNeinLogik;
with GlobalesWachstumLogik;

package body StadtEntfernenLogik is
   
   function StadtAbreißen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
      return Boolean
   is begin
      
      Abriss := JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageStadtAbreißen);
         
      case
        Abriss
      is
         when True =>
            StadtEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);
            
         when False =>
            null;
      end case;
      
      return Abriss;
      
   end StadtAbreißen;
   
   

   procedure StadtEntfernen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is begin
      
      BelegteStadtfelderFreigeben (StadtRasseNummerExtern => StadtRasseNummerExtern);
      HeimatstädteEntfernen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      NeueHauptstadtSetzen (StadtRasseNummerExtern => StadtRasseNummerExtern);
      SchreibeWeltkarte.Verbesserung (KoordinatenExtern  => LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern),
                                      VerbesserungExtern => KartenverbesserungDatentypen.Leer_Verbesserung_Enum);
      SchreibeStadtGebaut.Nullsetzung (StadtRasseNummerExtern => StadtRasseNummerExtern);
      GlobalesWachstumLogik.WachstumWichtiges (RasseExtern => StadtRasseNummerExtern.Rasse);
      SchreibeWichtiges.AnzahlStädte (RasseExtern     => StadtRasseNummerExtern.Rasse,
                                       PlusMinusExtern => False);
      RasseEntfernenLogik.RasseExistenzPrüfen (RasseExtern => StadtRasseNummerExtern.Rasse);
      
   end StadtEntfernen;
   
   
   
   procedure BelegteStadtfelderFreigeben
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is
      use type KartenDatentypen.Kartenfeld;
   begin
      
      Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtRasseNummerExtern => StadtRasseNummerExtern);
      
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
            then
               SchreibeWeltkarte.BelegterGrund (KoordinatenExtern   => KartenWert,
                                                BelegterGrundExtern => KartenRecordKonstanten.LeerDurchStadtBelegterGrund);
            
            else
               null;
            end if;
         
         end loop XAchseSchleife;
      end loop YAchseSchleife;
      
   end BelegteStadtfelderFreigeben;
   
   
   
   procedure HeimatstädteEntfernen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
   begin
      
      EinheitenSchleife:
      for EinheitNummerSchleifenwert in SpielVariablen.EinheitenGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Einheitengrenze loop
         
         if
           LeseEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerSchleifenwert)) = StadtRasseNummerExtern.Nummer
         then
            SchreibeEinheitenGebaut.Heimatstadt (EinheitRasseNummerExtern => (StadtRasseNummerExtern.Rasse, EinheitNummerSchleifenwert),
                                                 HeimatstadtExtern        => EinheitenKonstanten.LeerHeimatstadt);
            
         else
            null;
         end if;
         
      end loop EinheitenSchleife;
      
   end HeimatstädteEntfernen;
   
   
   
   procedure NeueHauptstadtSetzen
     (StadtRasseNummerExtern : in StadtRecords.RasseStadtnummerRecord)
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
      use type KartenverbesserungDatentypen.Karten_Verbesserung_Enum;
   begin
      
      case
        LeseStadtGebaut.ID (StadtRasseNummerExtern => StadtRasseNummerExtern)
      is
         when KartenverbesserungDatentypen.Hauptstadt_Enum =>
            null;
            
         when others =>
            return;
      end case;
      
      StadtSchleife:
      for StadtSchleifenwert in SpielVariablen.StadtGebautArray'First (2) .. SpielVariablen.Grenzen (StadtRasseNummerExtern.Rasse).Städtegrenze loop
         
         if
           LeseStadtGebaut.ID (StadtRasseNummerExtern => (StadtRasseNummerExtern.Rasse, StadtSchleifenwert)) = KartenverbesserungDatentypen.Leer_Verbesserung_Enum
           or
             StadtSchleifenwert = StadtRasseNummerExtern.Nummer
         then
            null;
            
         else
            SchreibeStadtGebaut.ID (StadtRasseNummerExtern => (StadtRasseNummerExtern.Rasse, StadtSchleifenwert),
                                    IDExtern               => KartenverbesserungDatentypen.Hauptstadt_Enum);
            return;
         end if;
         
      end loop StadtSchleife;
      
   end NeueHauptstadtSetzen;

end StadtEntfernenLogik;
