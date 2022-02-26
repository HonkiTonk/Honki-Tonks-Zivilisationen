pragma SPARK_Mode (On);

with KartenEinstellungenKonstanten;

with Karten;
with BerechnungenKarteSFML;

package body Sichtweiten is
   
   procedure SichtweiteBewegungsfeldFestlegen
   is begin
      
      case
        Karten.Kartengröße
      is
         when KartenEinstellungenKonstanten.Kartengröße2020Konstante =>
            Sichtweiten.SichtweiteFestlegen := 1;
            Sichtweiten.BewegungsfeldFestlegen := 1;
            
         when KartenEinstellungenKonstanten.Kartengröße4040Konstante =>
            Sichtweiten.SichtweiteFestlegen := 2;
            Sichtweiten.BewegungsfeldFestlegen := 2;

         when KartenEinstellungenKonstanten.KartengrößeNutzerKonstante =>
            if
              Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße <= Karten.Kartengrößen (KartenEinstellungenKonstanten.Kartengröße2020Konstante).YAchsenGröße
              or
                Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße <= Karten.Kartengrößen (KartenEinstellungenKonstanten.Kartengröße2020Konstante).XAchsenGröße
            then
               Sichtweiten.SichtweiteFestlegen := 1;
               Sichtweiten.BewegungsfeldFestlegen := 1;
               
            elsif
              Karten.Kartengrößen (Karten.Kartengröße).YAchsenGröße <= Karten.Kartengrößen (KartenEinstellungenKonstanten.Kartengröße4040Konstante).YAchsenGröße
              or
                Karten.Kartengrößen (Karten.Kartengröße).XAchsenGröße <= Karten.Kartengrößen (KartenEinstellungenKonstanten.Kartengröße4040Konstante).XAchsenGröße
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
