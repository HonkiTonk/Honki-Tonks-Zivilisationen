pragma SPARK_Mode (On);

with GlobaleKonstanten;

with RassenAllgemein;

package body LeseKarten is
   
   function Grund
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Karten_Grund_Enum
   is begin
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Grund;
      
   end Grund;
   
   
   
   function Hügel
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Hügel;
      
   end Hügel;
   
   
   
   function Sichtbar
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Sichtbar (RasseExtern);
        
   end Sichtbar;
   
   
   
   function Fluss
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Karten_Grund_Enum
   is begin
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Fluss;
      
   end Fluss;
   
   
   
   function VerbesserungWeg
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Karten_Verbesserung_Enum
   is begin
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungWeg;
      
   end VerbesserungWeg;
   
   
   
   function VerbesserungGebiet
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Karten_Verbesserung_Enum
   is begin
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungGebiet;
      
   end VerbesserungGebiet;
   
   
   
   function Ressource
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Karten_Grund_Enum
   is begin
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Ressource;
      
   end Ressource;
   
   
   
   function Bewertung
     (PositionExtern : in GlobaleRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Felderwertung (RasseExtern);
      
   end Bewertung;
   
   
   
   function BelegterGrund
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund
      in
        RassenAllgemein.RassenBelegungAnfang (RasseExtern => RasseExtern) .. RassenAllgemein.RassenBelegungEnde (RasseExtern => RasseExtern)
      then
         return True;
         
      else
         return False;
      end if;
      
   end BelegterGrund;
   
   
   
   function BelegterGrundLeer
     (KoordinatenExtern : GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      case
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund
      is
         when GlobaleKonstanten.LeerDurchStadtBelegterGrund =>
            return True;
         
         when others =>
            return False;
      end case;
      
   end BelegterGrundLeer;
   
   
   
   function BestimmteStadtBelegtGrund
     (StadtRasseNummerExtern : in GlobaleRecords.RassePlatznummerRecord;
      KoordinatenExtern : GlobaleRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
     
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund
        = GlobaleDatentypen.Rassen_Verwendet_Enum'Pos (StadtRasseNummerExtern.Rasse) * GlobaleKonstanten.RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Platznummer)
      then
         return True;
         
      else
         return False;
      end if;
      
   end BestimmteStadtBelegtGrund;

end LeseKarten;
