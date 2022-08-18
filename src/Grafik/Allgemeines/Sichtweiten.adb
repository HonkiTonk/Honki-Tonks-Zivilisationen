pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with TastenbelegungDatentypen;

with BerechnungenKarteSFML;
with BewegungCursor;
with NachGrafiktask;

package body Sichtweiten is
   
   procedure SichtweiteBewegungsfeldFestlegen
   is begin
         
      BerechnungenKarteSFML.KartenfelderAbmessungBerechnen;
      BerechnungenKarteSFML.StadtfelderAbmessungBerechnen;
      
   end SichtweiteBewegungsfeldFestlegen;
   
   
   
   -- Eventuell noch von der Kartengröße abhängig machen, damit bei kleinen Karten keine Probleme auftreten. äöü
   procedure ZoomstufeÄndern
     (ÄnderungExtern : in KartenDatentypen.Kartenfeld)
   is begin
      
      -- Eine Möglichkeit einbauen das abzustellen. äöü
      if
        AktuelleZoomstufe + ÄnderungExtern > MaximaleZoomstufe
      then
         BewegungCursor.BewegungCursorRichtung (KarteExtern    => True,
                                                RichtungExtern => TastenbelegungDatentypen.Ebene_Hoch_Enum,
                                                RasseExtern    => NachGrafiktask.AktuelleRasse);
         AktuelleZoomstufe := StandardZoomstufe;
         
      elsif
          AktuelleZoomstufe + ÄnderungExtern < KartenDatentypen.KartenfeldPositiv'First
      then
         BewegungCursor.BewegungCursorRichtung (KarteExtern    => True,
                                                RichtungExtern => TastenbelegungDatentypen.Ebene_Runter_Enum,
                                                RasseExtern    => NachGrafiktask.AktuelleRasse);
         AktuelleZoomstufe := StandardZoomstufe;
         
      else
         AktuelleZoomstufe := AktuelleZoomstufe + ÄnderungExtern;
      end if;
      
      BerechnungenKarteSFML.KartenfelderAbmessungBerechnen;
      
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
