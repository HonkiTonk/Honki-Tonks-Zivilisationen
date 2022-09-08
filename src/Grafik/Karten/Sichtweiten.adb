pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with TastenbelegungDatentypen;

with KartenberechnungenGrafik;
with BewegungCursor;
with NachGrafiktask;

-- Das und KartenberechnungenGrafik mal anders aufteilen. äöü
package body Sichtweiten is
   
   procedure SichtweiteBewegungsfeldFestlegen
   is begin
         
      KartenberechnungenGrafik.KartenfelderAbmessungBerechnen;
      KartenberechnungenGrafik.StadtfelderAbmessungBerechnen;
      
   end SichtweiteBewegungsfeldFestlegen;
   
   
   
   procedure StandardSichtweiten
   is begin
      
      AktuelleZoomstufe := StandardZoomstufe;
      SichtweiteBewegungsfeldFestlegen;
      
   end StandardSichtweiten;
   
   
   
   procedure ZoomstufeÄndern
     (ÄnderungExtern : in KartenDatentypen.Kartenfeld)
   is begin
      
      -- Eine Möglichkeit einbauen das abzustellen. äöü
      -- Eine Möglichkeit einbauen um direkt zu Standardzoomstufe zu springen und nicht zur Kleinsten?
      if
        AktuelleZoomstufe + ÄnderungExtern > MaximaleZoomstufe
      then
         BewegungCursor.CursorbewegungBerechnen (RichtungExtern => TastenbelegungDatentypen.Ebene_Hoch_Enum,
                                                 RasseExtern    => NachGrafiktask.AktuelleRasse);
         AktuelleZoomstufe := KartenDatentypen.KartenfeldPositiv'First;
         
      elsif
        AktuelleZoomstufe + ÄnderungExtern < MinimaleZoomstufe
      then
         BewegungCursor.CursorbewegungBerechnen (RichtungExtern => TastenbelegungDatentypen.Ebene_Runter_Enum,
                                                 RasseExtern    => NachGrafiktask.AktuelleRasse);
         AktuelleZoomstufe := MaximaleZoomstufe;
         
      else
         AktuelleZoomstufe := AktuelleZoomstufe + ÄnderungExtern;
      end if;
      
      KartenberechnungenGrafik.KartenfelderAbmessungBerechnen;
      BewegungCursor.ZoomanpassungCursor (RasseExtern => NachGrafiktask.AktuelleRasse);
      
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
   
   
   
   function SichtbereichKarteBerechnen
     return KartenDatentypen.SichtbereichAnfangEndeArray
   is begin
      
      return (-SichtweiteLesen, SichtweiteLesen, -SichtweiteLesen, SichtweiteLesen);
      
   end SichtbereichKarteBerechnen;

end Sichtweiten;
