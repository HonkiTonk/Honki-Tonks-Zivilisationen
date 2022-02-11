pragma SPARK_Mode (On);

with KartenDatentypen; use KartenDatentypen;
with EinheitStadtDatentypen; use EinheitStadtDatentypen;
with StadtKonstanten;

with Fehler;

package body LeseKarten is
   
   -- Position auf Koordinaten ändern, damit weniger Probleme mit der Grafikposition auftreten.
   function Grund
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return KartenDatentypen.Karten_Grund_Enum
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
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return Boolean
   is begin
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Sichtbar (RasseExtern);
        
   end Sichtbar;
   
   
   
   function Fluss
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return KartenDatentypen.Karten_Grund_Enum
   is begin
      
      case
        Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Fluss
      is
         when KartenDatentypen.Leer_Grund | KartenDatentypen.Karten_Fluss_Enum'Range =>
            null;
         
         when others =>
            Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Fluss := KartenDatentypen.Leer_Grund;
      end case;
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Fluss;
      
   end Fluss;
   
   
   
   function VerbesserungWeg
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return KartenDatentypen.Karten_Verbesserung_Enum
   is begin
      
      case
        Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungWeg
      is
         when KartenDatentypen.Leer_Verbesserung | KartenDatentypen.Karten_Weg_Enum'Range =>
            null;
         
         when others =>
            Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungWeg := KartenDatentypen.Leer_Verbesserung;
      end case;
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungWeg;
      
   end VerbesserungWeg;
   
   
   
   function VerbesserungGebiet
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return KartenDatentypen.Karten_Verbesserung_Enum
   is begin
      
      case
        Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungGebiet
      is
         when KartenDatentypen.Leer_Verbesserung | KartenDatentypen.Karten_Verbesserung_Gebilde_Enum'Range =>
            null;
         
         when others =>
            Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungGebiet := KartenDatentypen.Leer_Verbesserung;
      end case;
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).VerbesserungGebiet;
      
   end VerbesserungGebiet;
   
   
   
   function Ressource
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return KartenDatentypen.Karten_Grund_Enum
   is begin
      
      case
        Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Ressource
      is
         when KartenDatentypen.Leer_Grund | KartenDatentypen.Karten_Grund_Ressourcen_Enum'Range =>
            null;
         
         when others =>
            Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Ressource := KartenDatentypen.Leer_Grund;
      end case;
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Ressource;
      
   end Ressource;
   
   
   
   function Bewertung
     (PositionExtern : in KartenRecords.AchsenKartenfeldPositivRecord;
      RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum)
      return KartenDatentypen.GesamtbewertungFeld
   is begin
      
      return Karten.Weltkarte (PositionExtern.EAchse, PositionExtern.YAchse, PositionExtern.XAchse).Felderwertung (RasseExtern);
      
   end Bewertung;
   
   
   
   function BelegterGrund
     (RasseExtern : in SystemDatentypen.Rassen_Verwendet_Enum;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.RasseBelegt = RasseExtern
        and
          Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.StadtBelegt > StadtKonstanten.LeerNummer
      then
         return True;
         
      else
         return False;
      end if;
      
   end BelegterGrund;
   
      
   
   function BelegterGrundLeer
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
      
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.RasseBelegt = StadtKonstanten.LeerRasse
        and
          Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.StadtBelegt = StadtKonstanten.LeerNummer
      then
         return True;
         
      elsif
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.RasseBelegt = StadtKonstanten.LeerRasse
        or
          Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.StadtBelegt = StadtKonstanten.LeerNummer
      then
         Fehler.LogikStopp (FehlermeldungExtern => "LeseKarten.BelegterGrundLeer - Rasse oder Nummer nicht korrekt gesetzt");
         -- return muss hier sein, weil der Kompiler nicht weiß dass der Prozeduraufruf das Programm stoppt.
         return True;
         
      else
         return False;
      end if;
      
   end BelegterGrundLeer;
   
   
   
   function BestimmteStadtBelegtGrund
     (StadtRasseNummerExtern : in EinheitStadtRecords.RassePlatznummerRecord;
      KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return Boolean
   is begin
     
      if
        Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.RasseBelegt = StadtRasseNummerExtern.Rasse
        and
          Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.StadtBelegt = StadtRasseNummerExtern.Platznummer
      then
         return True;
         
      else
         return False;
      end if;
      
   end BestimmteStadtBelegtGrund;
   
   
   
   function RasseBelegtGrund
     (KoordinatenExtern : in KartenRecords.AchsenKartenfeldPositivRecord)
      return SystemDatentypen.Rassen_Enum
   is begin
      
      return Karten.Weltkarte (KoordinatenExtern.EAchse, KoordinatenExtern.YAchse, KoordinatenExtern.XAchse).DurchStadtBelegterGrund.RasseBelegt;
      
   end RasseBelegtGrund;

end LeseKarten;
