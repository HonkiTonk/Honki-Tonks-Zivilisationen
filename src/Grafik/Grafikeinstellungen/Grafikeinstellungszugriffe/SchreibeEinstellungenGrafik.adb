with EinstellungenGrafik;

package body SchreibeEinstellungenGrafik is
   
   procedure Fenstermodus
     (FenstermodusExtern : in Sf.Window.Window.sfWindowStyle)
   is begin
      
      EinstellungenGrafik.Grafikeinstellungen.Fenstermodus := FenstermodusExtern;
      
   end Fenstermodus;
   
   
   
   procedure Auflösung
     (AuflösungExtern : in Sf.System.Vector2.sfVector2u)
   is begin
      
      EinstellungenGrafik.Grafikeinstellungen.Auflösung := AuflösungExtern;
      
   end Auflösung;
   
   
   
   procedure Farbtiefe
     (FarbtiefeExtern : in Sf.sfUint32)
   is begin
      
      EinstellungenGrafik.Grafikeinstellungen.Farbtiefe := FarbtiefeExtern;
      
   end Farbtiefe;
   
   
   
   procedure Bildrate
     (BildrateExtern : in Sf.sfUint32)
   is begin
      
      EinstellungenGrafik.Grafikeinstellungen.Bildrate := BildrateExtern;
      
   end Bildrate;
   
   
   
   procedure EbenenUnterhalbSichtbar
   is begin
      
      EinstellungenGrafik.Grafikeinstellungen.EbeneUnterhalbSichtbar := not EinstellungenGrafik.Grafikeinstellungen.EbeneUnterhalbSichtbar;
      
   end EbenenUnterhalbSichtbar;
   
   
   
   procedure BildrateAnzeigen
   is begin
      
      EinstellungenGrafik.Grafikeinstellungen.BildrateAnzeigen := not EinstellungenGrafik.Grafikeinstellungen.BildrateAnzeigen;
      
   end BildrateAnzeigen;
   
   
   
   procedure GesamteGrafikeinstellungen
     (EinstellungenExtern : in GrafikRecords.GrafikeinstellungenRecord)
   is begin
      
      EinstellungenGrafik.Grafikeinstellungen := EinstellungenExtern;
      
   end GesamteGrafikeinstellungen;

end SchreibeEinstellungenGrafik;
