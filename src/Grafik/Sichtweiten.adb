pragma SPARK_Mode (On);

with SystemDatentypen;

with Karten;
with BerechnungenKarteSFML;

package body Sichtweiten is
   
   procedure SichtweiteBewegungsfeldFestlegen
   is begin
      
      case
        Karten.Kartengröße
      is
         when SystemDatentypen.Karte_Größe_20_20 =>
            Sichtweiten.SichtweiteFestlegen := 1;
            Sichtweiten.BewegungsfeldFestlegen := 1;
            
         when SystemDatentypen.Karte_Größe_40_40 =>
            Sichtweiten.SichtweiteFestlegen := 2;
            Sichtweiten.BewegungsfeldFestlegen := 2;

         when SystemDatentypen.Karte_Größe_Nutzer =>
            if
              Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße <= Karten.Kartengrößen (SystemDatentypen.Karte_Größe_20_20).YAchsenGröße
              or
                Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße <= Karten.Kartengrößen (SystemDatentypen.Karte_Größe_20_20).XAchsenGröße
            then
               Sichtweiten.SichtweiteFestlegen := 1;
               Sichtweiten.BewegungsfeldFestlegen := 1;
               
            elsif
              Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße <= Karten.Kartengrößen (SystemDatentypen.Karte_Größe_40_40).YAchsenGröße
              or
                Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße <= Karten.Kartengrößen (SystemDatentypen.Karte_Größe_40_40).XAchsenGröße
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
