pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with Weltkarte;

with KartenberechnungenGrafik;
with CursorbewegungLogik;
with NachGrafiktask;
-- with EinstellungenGrafik;

-- Das und KartenberechnungenGrafik mal anders aufteilen. äöü
package body SichtweitenGrafik is
   
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
      
      -- Eine Möglichkeit einbauen das abzustellen? äöü
      -- Eine Möglichkeit einbauen um direkt zu Standardzoomstufe zu springen und nicht zur Kleinsten?
      if
        AktuelleZoomstufe + ÄnderungExtern > MaximaleZoomstufe
      then
         AktuelleZoomstufe := KartenDatentypen.KartenfeldPositiv'First;
         WelcheZoomanpassung := TastenbelegungDatentypen.Ebene_Hoch_Enum;
         
      elsif
        AktuelleZoomstufe + ÄnderungExtern < MinimaleZoomstufe
      then
         AktuelleZoomstufe := MaximaleZoomstufe;
         WelcheZoomanpassung := TastenbelegungDatentypen.Ebene_Runter_Enum;
         
      else
         AktuelleZoomstufe := AktuelleZoomstufe + ÄnderungExtern;
         WelcheZoomanpassung := TastenbelegungDatentypen.Auswählen_Enum;
      end if;
      
      CursorbewegungLogik.CursorbewegungBerechnen (RichtungExtern => WelcheZoomanpassung,
                                                   RasseExtern    => NachGrafiktask.AktuelleRasse);
      
      KartenberechnungenGrafik.KartenfelderAbmessungBerechnen;
      
   end ZoomstufeÄndern;
   
   

   function SichtweiteLesen
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      return AktuelleZoomstufe * 2;
            
   end SichtweiteLesen;
   
   

   function BewegungsfeldLesen
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      return SichtweiteLesen - 1;
      
   end BewegungsfeldLesen;
   
   
   
   function UntenRechts
     (RasseExtern : in RassenDatentypen.Rassen_Verwendet_Enum)
     return Boolean
   is begin
      
      if
        SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.YAchse >= Weltkarte.Karteneinstellungen.Kartengröße.YAchse - SichtweiteLesen
        and
          SpielVariablen.CursorImSpiel (RasseExtern).KoordinatenAlt.XAchse >= Weltkarte.Karteneinstellungen.Kartengröße.XAchse - SichtweiteLesen
      then
         return False;
               
      else
         return True;
      end if;
      
   end UntenRechts;

end SichtweitenGrafik;
