with KartenverbesserungDatentypen;
with EinheitenKonstanten;
with KartenRecordKonstanten;
with StadtKonstanten;
with SystemDatentypen;

with LeseStadtGebaut;

with EinheitSuchenLogik;

-- Wird hier irgendwo mal geprüft ob die Stadt sichtbar ist? äöü
package body KIStadtSuchenLogik is
   
   function NähesteFeindlicheStadtSuchen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      AnfangKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return KartenRecords.KartenfeldNaturalRecord
   is begin
   
      GefundeneStadt := StadtSuchen (SpeziesExtern           => SpeziesExtern,
                                     AnfangKoordinatenExtern => AnfangKoordinatenExtern);
         
      case
        GefundeneStadt
      is
         when 0 =>
            return KartenRecordKonstanten.LeerKoordinate;
            
         when others =>
            return LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => (SpeziesExtern, GefundeneStadt));
      end case;
      
   end NähesteFeindlicheStadtSuchen;
   
   
   
   function StadtSuchen
     (SpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum;
      AnfangKoordinatenExtern : in KartenRecords.KartenfeldNaturalRecord)
      return StadtDatentypen.Städtebereich
   is
      use type KartenverbesserungDatentypen.Verbesserung_Enum;
      use type KartenDatentypen.Ebene;
   begin
      
      AktuelleStadt := StadtDatentypen.Städtebereich'First;
      
      StadtSchleife:
      for StadtSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => SpeziesExtern) loop
         
         if
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert)) = StadtKonstanten.LeerID
         then
            exit StadtSchleife;
            
         elsif
           AktuelleStadt = StadtDatentypen.Städtebereich'First
         then
            AktuelleStadt := StadtSchleifenwert;
            Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => (SpeziesExtern, AktuelleStadt));
            
            Entfernung := Natural (abs (AnfangKoordinatenExtern.Ebene - Stadtkoordinaten.Ebene)) + Natural (abs (AnfangKoordinatenExtern.Senkrechte - Stadtkoordinaten.Senkrechte))
              + Natural (abs (AnfangKoordinatenExtern.Waagerechte - Stadtkoordinaten.Waagerechte));
            
         else
            Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => (SpeziesExtern, StadtSchleifenwert));
            
            EntfernungNeu := Natural (abs (AnfangKoordinatenExtern.Ebene - Stadtkoordinaten.Ebene)) + Natural (abs (AnfangKoordinatenExtern.Senkrechte - Stadtkoordinaten.Senkrechte))
              + Natural (abs (AnfangKoordinatenExtern.Waagerechte - Stadtkoordinaten.Waagerechte));
            
            if
              Entfernung > EntfernungNeu
            then
               AktuelleStadt := StadtSchleifenwert;
               
            else
               null;
            end if;
         end if;
            
      end loop StadtSchleife;
      
      return AktuelleStadt;
      
   end StadtSuchen;
   
   
   
   function UnbewachteStadtSuchen
     (FeindlicheSpeziesExtern : in SpeziesDatentypen.Spezies_Vorhanden_Enum)
      return KartenRecords.KartenfeldNaturalRecord
   is
      use type KartenverbesserungDatentypen.Verbesserung_Enum;
   begin
      
      StadtSchleife:
      for StadtNummerSchleifenwert in StadtKonstanten.AnfangNummer .. LeseGrenzen.Städtegrenzen (SpeziesExtern => FeindlicheSpeziesExtern) loop
         
         if
           LeseStadtGebaut.ID (StadtSpeziesNummerExtern => (FeindlicheSpeziesExtern, StadtNummerSchleifenwert)) = StadtKonstanten.LeerID
         then
            exit StadtSchleife;
               
         else
            Stadtkoordinaten := LeseStadtGebaut.Koordinaten (StadtSpeziesNummerExtern => (FeindlicheSpeziesExtern, StadtNummerSchleifenwert));
                                                             
            case
              EinheitSuchenLogik.KoordinatenEinheitMitSpeziesSuchen (SpeziesExtern     => FeindlicheSpeziesExtern,
                                                                     KoordinatenExtern => Stadtkoordinaten,
                                                                     TaskExtern        => SystemDatentypen.Logik_Task_Enum)
            is
               when EinheitenKonstanten.LeerNummer =>
                  return Stadtkoordinaten;
                  
               when others =>
                  null;
            end case;
         end if;
         
      end loop StadtSchleife;
      
      return KartenRecordKonstanten.LeerKoordinate;
      
   end UnbewachteStadtSuchen;

end KIStadtSuchenLogik;
