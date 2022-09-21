pragma SPARK_Mode (On);
pragma Warnings (Off, "*array aggregate*");

with KartenDatentypen; use KartenDatentypen;
with TastenbelegungDatentypen;

with KartenberechnungenGrafik;
with CursorbewegungLogik;
with NachGrafiktask;
-- with EinstellungenGrafik;

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
         CursorbewegungLogik.CursorbewegungBerechnen (RichtungExtern => TastenbelegungDatentypen.Ebene_Hoch_Enum,
                                                      RasseExtern    => NachGrafiktask.AktuelleRasse);
         AktuelleZoomstufe := KartenDatentypen.KartenfeldPositiv'First;
         
      elsif
        AktuelleZoomstufe + ÄnderungExtern < MinimaleZoomstufe
      then
         CursorbewegungLogik.CursorbewegungBerechnen (RichtungExtern => TastenbelegungDatentypen.Ebene_Runter_Enum,
                                                      RasseExtern    => NachGrafiktask.AktuelleRasse);
         AktuelleZoomstufe := MaximaleZoomstufe;
         
      else
         AktuelleZoomstufe := AktuelleZoomstufe + ÄnderungExtern;
      end if;
      
      KartenberechnungenGrafik.KartenfelderAbmessungBerechnen;
      CursorbewegungLogik.ZoomanpassungCursor (RasseExtern => NachGrafiktask.AktuelleRasse);
      
   end ZoomstufeÄndern;
   
   

   -- Das noch einmal überarbeiten und anschließend vom Nutzer auswählbar machen? äöü
   -- Dazu muss vermutlich auch ZoomstufeÄndern ein wenig angepasst werden. äöü
   function SichtweiteLesen
     (YXExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
   is begin
            
      case
        YXExtern
      is
         when True =>
            -- return KartenDatentypen.KartenfeldPositiv (Float (AktuelleZoomstufe * 2) * EinstellungenGrafik.AktuelleFensterAuflösung.y / EinstellungenGrafik.AktuelleFensterAuflösung.x);
            return AktuelleZoomstufe * 2;
            
         when False =>
            -- return KartenDatentypen.KartenfeldPositiv (Float (AktuelleZoomstufe * 2) * EinstellungenGrafik.AktuelleFensterAuflösung.x / EinstellungenGrafik.AktuelleFensterAuflösung.y);
            return AktuelleZoomstufe * 2;
      end case;
            
   end SichtweiteLesen;
   
   

   function BewegungsfeldLesen
     (YXExtern : in Boolean)
      return KartenDatentypen.KartenfeldPositiv
   is begin
      
      case
        YXExtern
      is
         when True =>
            -- return KartenDatentypen.KartenfeldPositiv (Float (AktuelleZoomstufe * 2) * EinstellungenGrafik.AktuelleFensterAuflösung.y / EinstellungenGrafik.AktuelleFensterAuflösung.x) - 1;
            return AktuelleZoomstufe * 2 - 1;
            
         when False =>
            -- return KartenDatentypen.KartenfeldPositiv (Float (AktuelleZoomstufe * 2) * EinstellungenGrafik.AktuelleFensterAuflösung.x / EinstellungenGrafik.AktuelleFensterAuflösung.y) - 1;
            return AktuelleZoomstufe * 2 - 1;
      end case;
      
   end BewegungsfeldLesen;
   
   
   
   function SichtbereichKarteBerechnen
     return KartenDatentypen.SichtbereichAnfangEndeArray
   is begin
      
      return (-SichtweiteLesen (YXExtern => True), SichtweiteLesen (YXExtern => True), -SichtweiteLesen (YXExtern => False), SichtweiteLesen (YXExtern => False));
      
   end SichtbereichKarteBerechnen;

end Sichtweiten;
