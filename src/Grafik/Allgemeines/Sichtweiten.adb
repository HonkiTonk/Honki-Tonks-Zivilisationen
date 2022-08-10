pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;

with BerechnungenKarteSFML;

package body Sichtweiten is
   
   procedure SichtweiteBewegungsfeldFestlegen
   is begin
         
      BerechnungenKarteSFML.KartenfelderAbmessungBerechnen;
      BerechnungenKarteSFML.StadtfelderAbmessungBerechnen;
      
   end SichtweiteBewegungsfeldFestlegen;
   
   
   
   -- Eventuell noch von der Kartengröße abhängig machen, damit bei kleinen Karten keine Probleme auftreten. äöü
   procedure ZoomstufeÄndern
     (HöherTieferExtern : in Boolean)
   is begin
      
      if
        HöherTieferExtern
        and
          AktuelleZoomstufe < MaximaleZoomstufe
      then
         AktuelleZoomstufe := AktuelleZoomstufe + 1;
         
      elsif
        HöherTieferExtern = False
        and
          AktuelleZoomstufe > KartenDatentypen.KartenfeldPositiv'First
      then
         AktuelleZoomstufe := AktuelleZoomstufe - 1;
         
      else
         null;
      end if;
      
      SichtweiteBewegungsfeldFestlegen;
      
   end ZoomstufeÄndern;
   
   

   function SichtweiteLesen
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      return AktuelleZoomstufe * 2;
      
   end SichtweiteLesen;
   
   

   function BewegungsfeldLesen
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      return AktuelleZoomstufe * 2 - 1;
      
   end BewegungsfeldLesen;

end Sichtweiten;
