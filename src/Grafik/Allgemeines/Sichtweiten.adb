pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Karten;
with BerechnungenKarteSFML;

package body Sichtweiten is
   
   procedure SichtweiteBewegungsfeldFestlegen
   is begin
      
      case
        Karten.Kartenparameter.Kartengröße
      is
         when KartenDatentypen.Kartengröße_20_20_Enum =>
            Sichtweiten.SichtweiteFestlegen := 1;
            Sichtweiten.BewegungsfeldFestlegen := 1;
            
         when KartenDatentypen.Kartengröße_40_40_Enum =>
            Sichtweiten.SichtweiteFestlegen := 2;
            Sichtweiten.BewegungsfeldFestlegen := 2;

         when KartenDatentypen.Kartengröße_Nutzer_Enum =>
            if
              Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse <= Karten.Kartengrößen (KartenDatentypen.Kartengröße_20_20_Enum).YAchse
              or
                Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse <= Karten.Kartengrößen (KartenDatentypen.Kartengröße_20_20_Enum).XAchse
            then
               Sichtweiten.SichtweiteFestlegen := 1;
               Sichtweiten.BewegungsfeldFestlegen := 1;
               
            elsif
              Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).YAchse <= Karten.Kartengrößen (KartenDatentypen.Kartengröße_40_40_Enum).YAchse
              or
                Karten.Kartengrößen (Karten.Kartenparameter.Kartengröße).XAchse <= Karten.Kartengrößen (KartenDatentypen.Kartengröße_40_40_Enum).XAchse
            then
               Sichtweiten.SichtweiteFestlegen := 2;
               Sichtweiten.BewegungsfeldFestlegen := 2;
               
            else
               Sichtweiten.SichtweiteFestlegen := 3;
               Sichtweiten.BewegungsfeldFestlegen := 3;
            end if;
            
         when others =>
            Sichtweiten.SichtweiteFestlegen := 3;
            Sichtweiten.BewegungsfeldFestlegen := 3;
      end case;
      
      BerechnungenKarteSFML.KartenfelderAbmessungBerechnen;
      BerechnungenKarteSFML.StadtfelderAbmessungBerechnen;
      
   end SichtweiteBewegungsfeldFestlegen;
   
   

   function SichtweiteLesen
     (YAchseXAchseExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      case
        YAchseXAchseExtern
      is
         when True =>
            return SichtweitenStandard (SichtweiteFestlegen).YAchse;
            
         when False =>
            return SichtweitenStandard (SichtweiteFestlegen).XAchse;
      end case;
      
   end SichtweiteLesen;
   
   

   function BewegungsfeldLesen
     (YAchseXAchseExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      case
        YAchseXAchseExtern
      is
         when True =>
            return Bewegungsfeld (BewegungsfeldFestlegen).YAchse;
            
         when False =>
            return Bewegungsfeld (BewegungsfeldFestlegen).XAchse;
      end case;
      
   end BewegungsfeldLesen;

end Sichtweiten;