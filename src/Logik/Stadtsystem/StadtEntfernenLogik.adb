with KartenverbesserungDatentypen;
with StadtDatentypen;
with EinheitenKonstanten;
with TextnummernKonstanten;

with SchreibeEinheitenGebaut;
with SchreibeStadtGebaut;
with SchreibeWeltkarte;
with SchreibeWichtiges;
with LeseEinheitenGebaut;
with LeseStadtGebaut;

with SpeziesEntfernenLogik;
with JaNeinLogik;
with GlobalesWachstumLogik;
with StadtumgebungFestlegenLogik;

package body StadtEntfernenLogik is
   
   function StadtAbreißen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
      return Boolean
   is begin
      
      Abriss := JaNeinLogik.JaNein (FrageZeileExtern => TextnummernKonstanten.FrageStadtAbreißen);
         
      case
        Abriss
      is
         when True =>
            StadtEntfernen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
            
         when False =>
            null;
      end case;
      
      return Abriss;
      
   end StadtAbreißen;
   
   

   procedure StadtEntfernen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is begin
      
      SchreibeStadtGebaut.Bewohnerentfernung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      StadtumgebungFestlegenLogik.StadtumgebungFestlegen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      
      HeimatstädteEntfernen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      NeueHauptstadtSetzen (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      SchreibeWeltkarte.Verbesserung (KoordinatenExtern  => LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern),
                                      VerbesserungExtern => KartenverbesserungDatentypen.Leer_Verbesserung_Enum);
      SchreibeStadtGebaut.Nullsetzung (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern);
      GlobalesWachstumLogik.WachstumsratenBerechnen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies);
      SchreibeWichtiges.AnzahlStädte (SpeziesExtern   => StadtSpeziesNummerExtern.Spezies,
                                       PlusMinusExtern => False);
      SpeziesEntfernenLogik.SpeziesExistenzPrüfen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies);
      
   end StadtEntfernen;
   
   
   
   procedure HeimatstädteEntfernen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
   begin
      
      EinheitenSchleife:
      for EinheitNummerSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) loop
         
         if
           LeseEinheitenGebaut.Heimatstadt (EinheitSpeziesNummerExtern => (StadtSpeziesNummerExtern.Spezies, EinheitNummerSchleifenwert)) = StadtSpeziesNummerExtern.Nummer
         then
            SchreibeEinheitenGebaut.Heimatstadt (EinheitSpeziesNummerExtern => (StadtSpeziesNummerExtern.Spezies, EinheitNummerSchleifenwert),
                                                 HeimatstadtExtern          => EinheitenKonstanten.LeerHeimatstadt);
            
         else
            null;
         end if;
         
      end loop EinheitenSchleife;
      
   end HeimatstädteEntfernen;
   
   
   
   procedure NeueHauptstadtSetzen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type StadtDatentypen.MaximaleStädteMitNullWert;
      use type KartenverbesserungDatentypen.Verbesserung_Enum;
   begin
      
      case
        LeseStadtGebaut.ID (StadtSpeziesNummerExtern => StadtSpeziesNummerExtern)
      is
         when KartenverbesserungDatentypen.Hauptstadt_Enum =>
            null;
            
         when others =>
            return;
      end case;
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) loop
         
         if
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (StadtSpeziesNummerExtern.Spezies, StadtSchleifenwert)) = KartenverbesserungDatentypen.Leer_Verbesserung_Enum
           or
             StadtSchleifenwert = StadtSpeziesNummerExtern.Nummer
         then
            null;
            
         else
            SchreibeStadtGebaut.ID (StadtSpeziesNummerExtern => (StadtSpeziesNummerExtern.Spezies, StadtSchleifenwert),
                                    IDExtern                 => KartenverbesserungDatentypen.Hauptstadt_Enum);
            return;
         end if;
         
      end loop StadtSchleife;
      
   end NeueHauptstadtSetzen;

end StadtEntfernenLogik;
