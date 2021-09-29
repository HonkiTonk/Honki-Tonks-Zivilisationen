pragma SPARK_Mode (On);

with SonstigesKonstanten, KartenKonstanten;

with RassenAllgemein;

package body LeseKarten is
   
   function Grund
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Karten_Grund_Enum
   is begin
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Grund;
      
   end Grund;
   
   
   
   function Hügel
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Hügel;
      
   end Hügel;
   
   
   
   function Sichtbar
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Sichtbar (RasseExtern);
        
   end Sichtbar;
   
   
   
   function Fluss
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Karten_Grund_Enum
   is begin
      
      case
        Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Fluss
      is
         when GlobaleDatentypen.Leer | GlobaleDatentypen.Karten_Fluss_Enum'Range =>
            null;
         
         when others =>
            Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Fluss := GlobaleDatentypen.Leer;
      end case;
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Fluss;
      
   end Fluss;
   
   
   
   function VerbesserungWeg
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Karten_Verbesserung_Enum
   is begin
      
      case
        Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungWeg
      is
         when GlobaleDatentypen.Leer | GlobaleDatentypen.Karten_Weg_Enum'Range =>
            null;
         
         when others =>
            Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungWeg := GlobaleDatentypen.Leer;
      end case;
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungWeg;
      
   end VerbesserungWeg;
   
   
   
   function VerbesserungGebiet
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Karten_Verbesserung_Enum
   is begin
      
      case
        Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungGebiet
      is
         when GlobaleDatentypen.Leer | GlobaleDatentypen.Karten_Verbesserung_Gebilde_Enum'Range =>
            null;
         
         when others =>
            Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungGebiet := GlobaleDatentypen.Leer;
      end case;
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungGebiet;
      
   end VerbesserungGebiet;
   
   
   
   function Ressource
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return GlobaleDatentypen.Karten_Grund_Enum
   is begin
      
      case
        Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Ressource
      is
         when GlobaleDatentypen.Leer | GlobaleDatentypen.Karten_Grund_Ressourcen_Enum'Range =>
            null;
         
         when others =>
            Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Ressource := GlobaleDatentypen.Leer;
      end case;
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Ressource;
      
   end Ressource;
   
   
   
   function Bewertung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum)
      return GlobaleDatentypen.GesamtproduktionStadt
   is begin
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Felderwertung (RasseExtern);
      
   end Bewertung;
   
   
   
   function BelegterGrund
     (RasseExtern : in GlobaleDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : KartenRecords.AchsenKartenfeldPositivRecord)
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
     (KoordinatenExtern : KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      case
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund
      is
         when KartenKonstanten.LeerDurchStadtBelegterGrund =>
            return True;
         
         when others =>
            return False;
      end case;
      
   end BelegterGrundLeer;
   
   
   
   function BestimmteStadtBelegtGrund
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      KoordinatenExtern : KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
     
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund
        = GlobaleDatentypen.Rassen_Verwendet_Enum'Pos (StadtRasseNummerExtern.Rasse) * SonstigesKonstanten.RassenMulitplikationWert + GlobaleDatentypen.BelegterGrund (StadtRasseNummerExtern.Platznummer)
      then
         return True;
         
      else
         return False;
      end if;
      
   end BestimmteStadtBelegtGrund;

end LeseKarten;
