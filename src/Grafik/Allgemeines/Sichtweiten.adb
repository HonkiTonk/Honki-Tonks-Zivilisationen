pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with Karten;
with BerechnungenKarteSFML;

package body Sichtweiten is
   
   procedure SichtweiteBewegungsfeldFestlegen
   is begin
      
      if
        Karten.Karteneinstellungen.Kartengröße.YAchse <= 20
        or
          Karten.Karteneinstellungen.Kartengröße.XAchse <= 20
      then
         Sichtweiten.SichtweiteFestlegen := 1;
         Sichtweiten.BewegungsfeldFestlegen := 1;
         
      elsif
        Karten.Karteneinstellungen.Kartengröße.YAchse <= 40
        or
          Karten.Karteneinstellungen.Kartengröße.XAchse <= 40
      then
         Sichtweiten.SichtweiteFestlegen := 2;
         Sichtweiten.BewegungsfeldFestlegen := 2;

      else
         Sichtweiten.SichtweiteFestlegen := 3;
         Sichtweiten.BewegungsfeldFestlegen := 3;
      end if;
   
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
