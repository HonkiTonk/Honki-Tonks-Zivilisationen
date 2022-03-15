pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with KartenKonstanten;

with Karten;

package body KartePositionKeinUebergangBerechnungen is

   function PositionBestimmenEAchse
     (EAchseExtern : in KartenDatentypen.EbeneVorhanden;
      ÄnderungEAchseExtern : in KartenDatentypen.EbeneVorhanden)
      return KartenDatentypen.Ebene
   is begin
      
      if
        EAchseExtern + ÄnderungEAchseExtern < Karten.WeltkarteArray'First (1)
        or
          EAchseExtern + ÄnderungEAchseExtern > Karten.WeltkarteArray'Last (1)
      then
         return KartenKonstanten.LeerEAchse;
         
      else
         return EAchseExtern + ÄnderungEAchseExtern;
      end if;
      
   end PositionBestimmenEAchse;
   
   
   
   function PositionBestimmenYAchse
     (YAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungYAchseExtern : in KartenDatentypen.Kartenfeld)
      return KartenDatentypen.KartenfeldPositivMitNullwert
   is begin
      
      if
        YAchseExtern + ÄnderungYAchseExtern < Karten.WeltkarteArray'First (2)
        or
          YAchseExtern + ÄnderungYAchseExtern > Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße
      then
         return KartenKonstanten.LeerYAchse;
         
      else
         return YAchseExtern + ÄnderungYAchseExtern;
      end if;
      
   end PositionBestimmenYAchse;
   
   
   
   function PositionBestimmenXAchse
     (XAchseExtern : in KartenDatentypen.KartenfeldPositiv;
      ÄnderungXAchseExtern : in KartenDatentypen.Kartenfeld)
      return KartenDatentypen.KartenfeldPositivMitNullwert
   is begin
      
      if
        XAchseExtern + ÄnderungXAchseExtern < Karten.WeltkarteArray'First (3)
        or
          XAchseExtern + ÄnderungXAchseExtern > Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße
      then
         return KartenKonstanten.LeerXAchse;
         
      else
         return XAchseExtern + ÄnderungXAchseExtern;
      end if;
      
   end PositionBestimmenXAchse;

end KartePositionKeinUebergangBerechnungen;
