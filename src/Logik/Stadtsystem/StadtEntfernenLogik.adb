with KartenverbesserungDatentypen;
with StadtDatentypen;
with EinheitenKonstanten;
with TextnummernKonstanten;
with EinheitenDatentypen;

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
with StadtAllgemeinesLogik;

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
      
      case
        SpeziesEntfernenLogik.SpeziesExistiertNoch (SpeziesExtern => StadtSpeziesNummerExtern.Spezies)
      is
         when True =>
            StadtAllgemeinesLogik.StädteSortieren (SpeziesExtern => StadtSpeziesNummerExtern.Spezies);
            
         when False =>
            null;
      end case;
      
   end StadtEntfernen;
   
   
   
   procedure HeimatstädteEntfernen
     (StadtSpeziesNummerExtern : in StadtRecords.SpeziesStadtnummerRecord)
   is
      use type StadtDatentypen.Städtebereich;
      use type EinheitenDatentypen.EinheitenID;
   begin
      
      EinheitenSchleife:
      for EinheitNummerSchleifenwert in EinheitenKonstanten.AnfangNummer .. LeseGrenzen.Einheitengrenze (SpeziesExtern => StadtSpeziesNummerExtern.Spezies) loop
         
         if
           LeseEinheitenGebaut.ID (EinheitSpeziesNummerExtern => (StadtSpeziesNummerExtern.Spezies, EinheitNummerSchleifenwert)) = EinheitenKonstanten.LeerID
         then
            exit EinheitenSchleife;
            
         elsif
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
      use type StadtDatentypen.Städtebereich;
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
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (StadtSpeziesNummerExtern.Spezies, StadtSchleifenwert)) = StadtKonstanten.LeerID
         then
            exit StadtSchleife;
             
         elsif
           StadtSchleifenwert = StadtSpeziesNummerExtern.Nummer
         then
            null;
            
         else
            SchreibeStadtGebaut.ID (StadtSpeziesNummerExtern => (StadtSpeziesNummerExtern.Spezies, StadtSchleifenwert),
                                    IDExtern                 => KartenverbesserungDatentypen.Hauptstadt_Enum);
            exit StadtSchleife;
         end if;
         
      end loop StadtSchleife;
      
   end NeueHauptstadtSetzen;

end StadtEntfernenLogik;
