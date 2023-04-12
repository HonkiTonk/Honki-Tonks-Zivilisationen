with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;

with KartenverbesserungDatentypen;
with StadtKonstanten;

with LeseStadtGebaut;
with LeseWeltkarte;
  
with TexteingabeLogik;
with NachGrafiktask;

package body StadtSuchenLogik is

   function KoordinatenStadtMitSpeziesSuchen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return StadtDatentypen.MaximaleStädteMitNullWert
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      case
        LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern)
      is
         when KartenverbesserungDatentypen.Verbesserung_Städte_Enum'Range =>
            Stadt := LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => KoordinatenExtern);
            
         when others =>
            return StadtKonstanten.LeerNummer;
      end case;
            
      if
        Stadt.Spezies = SpeziesExtern
      then
         return Stadt.Nummer;
            
      else
         return StadtKonstanten.LeerNummer;
      end if;
      
   end KoordinatenStadtMitSpeziesSuchen;
   


   function KoordinatenStadtOhneSpeziesSuchen
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return StadtRecords.SpeziesStadtnummerRecord
   is begin
      
      case
        LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern)
      is
         when KartenverbesserungDatentypen.Verbesserung_Städte_Enum'Range =>
            return LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => KoordinatenExtern);
            
         when others =>
            return StadtKonstanten.LeerStadt;
      end case;
      
   end KoordinatenStadtOhneSpeziesSuchen;
   
   
   
   function KoordinatenStadtOhneSpezielleSpeziesSuchen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldNaturalRecord)
      return StadtRecords.SpeziesStadtnummerRecord
   is
      use type SpeziesDatentypen.Spezies_Enum;
   begin
      
      case
        LeseWeltkarte.Verbesserung (KoordinatenExtern => KoordinatenExtern)
      is
         when KartenverbesserungDatentypen.Verbesserung_Städte_Enum'Range =>
            Stadt := LeseWeltkarte.StadtbelegungGrund (KoordinatenExtern => KoordinatenExtern);
            
         when others =>
            return StadtKonstanten.LeerStadt;
      end case;
      
      if
        Stadt.Spezies = SpeziesExtern
      then
         return StadtKonstanten.LeerStadt;
         
      else
         return Stadt;
      end if;
      
   end KoordinatenStadtOhneSpezielleSpeziesSuchen;
   

   
   procedure StadtNachNamenSuchen
   is
      use type KartenverbesserungDatentypen.Verbesserung_Enum;
   begin
      
      StadtName := TexteingabeLogik.StadtName (StadtSpeziesNummerExtern => StadtKonstanten.LeerStadt,
                                               BauenExtern            => False);
      
      case
        StadtName.ErfolgreichAbbruch
      is
         when False =>
            return;
            
         when True =>
            null;
      end case;
      
      SpeziesSchleife:
      for SpeziesSchleifenwert in SpeziesDatentypen.Spezies_Verwendet_Enum'Range loop
         
         case
           LeseSpeziesbelegung.Belegung (SpeziesExtern => SpeziesSchleifenwert)
         is
            when SpeziesDatentypen.Leer_Spieler_Enum =>
               null;
               
            when others =>
               StadtSchleife:
               for StadtNummerSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesSchleifenwert) loop
                  
                  if
                    LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesSchleifenwert, StadtNummerSchleifenwert)) = StadtKonstanten.LeerID
                  then
                     null;
                     
                  elsif
                    LeseStadtGebaut.Name (StadtSpeziesNummerExtern => (SpeziesSchleifenwert, StadtNummerSchleifenwert)) = StadtName.EingegebenerText
                  then
                     NachGrafiktask.GeheZu := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => (SpeziesSchleifenwert, StadtNummerSchleifenwert));
                     return;
               
                  else
                     null;
                  end if;
            
               end loop StadtSchleife;
         end case;
         
      end loop SpeziesSchleife;
      
   end StadtNachNamenSuchen;

end StadtSuchenLogik;
