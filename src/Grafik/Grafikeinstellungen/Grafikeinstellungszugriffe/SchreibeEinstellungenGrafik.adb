with EinstellungenGrafik;

package body SchreibeEinstellungenGrafik is
   
   -- Fenstereinstellungen
   procedure Fenstermodus
     (FenstermodusExtern : in Sf.Window.Window.sfWindowStyle)
   is begin
      
      EinstellungenGrafik.FensterEinstellungen.Fenstermodus := FenstermodusExtern;
      
   end Fenstermodus;
   
   
   
   procedure Auflösung
     (AuflösungExtern : in Sf.System.Vector2.sfVector2u)
   is begin
      
      EinstellungenGrafik.FensterEinstellungen.Auflösung := AuflösungExtern;
      
   end Auflösung;
   
   
   
   procedure Farbtiefe
     (FarbtiefeExtern : in Sf.sfUint32)
   is begin
      
      EinstellungenGrafik.FensterEinstellungen.Farbtiefe := FarbtiefeExtern;
      
   end Farbtiefe;
   
   
   
   procedure Bildrate
     (BildrateExtern : in Sf.sfUint32)
   is begin
      
      EinstellungenGrafik.FensterEinstellungen.Bildrate := BildrateExtern;
      
   end Bildrate;
   -- Fenstereinstellungen
   
   
   
   -- Grafikeinstellungen
   procedure EbenenUnterhalbSichtbar
   is begin
      
      EinstellungenGrafik.Grafikeinstellungen.EbeneUnterhalbSichtbar := not EinstellungenGrafik.Grafikeinstellungen.EbeneUnterhalbSichtbar;
      
   end EbenenUnterhalbSichtbar;
   -- Grafikeinstellungen
   
   

   procedure Fenstereinstellungen
     (EintragExtern : in GrafikRecords.FensterRecord)
   is begin
      
      EinstellungenGrafik.FensterEinstellungen := EintragExtern;
      
   end Fenstereinstellungen;
   
   
   
   procedure Grafikeinstellungen
     (EintragExtern : in GrafikRecords.GrafikeinstellungenRecord)
   is begin
      
      EinstellungenGrafik.Grafikeinstellungen := EintragExtern;
      
   end Grafikeinstellungen;

end SchreibeEinstellungenGrafik;
